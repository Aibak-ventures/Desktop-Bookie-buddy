import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:bookie_buddy_core/core/common/entities/user_shop_entity/user_shop_entity.dart';
import '../../../../../utils/extensions/string_extensions.dart';
import 'receipt_canvas.dart';

/// Shop-branded header and footer — logo, shop name/address/phone/GSTIN,
/// and the closing terms & conditions + sign-off line — shared by every
/// receipt type that prints against a specific shop (booking today,
/// sales/custom-work later). Each receipt builder (e.g.
/// `BookingReceiptCanvasBuilder`) supplies only the bits that actually
/// differ per type — the heading text and the closing message — and calls
/// these once at the start and end of its own `call()` instead of
/// reimplementing "how a shop's receipt starts and ends".
class ShopReceiptSections {
  const ShopReceiptSections._();

  static const double _logoHeight = 150;
  static const double _shopDetailsSize = 17;
  static const double _headerDividerTopSpacing = 2;

  static const double _termsAndConditionTitleBottomSpacing = 10;
  static const double _termsAndConditionListItemBottomSpacing = 7;
  static const double _termsAndConditionSize = 15;
  static const double _footerSize = 18;
  static const double _footerSpacerHeight = 6;

  /// [heading] is the receipt-type-specific title — e.g. "--- RENT BILL
  /// ---" for a booking.
  static Future<void> buildHeader(
    ReceiptCanvas canvas,
    UserShopEntity shop, {
    required String heading,
  }) async {
    canvas
      ..textTitle(heading, bold: false)
      ..divider(topSpacing: _headerDividerTopSpacing);

    if (shop.image != null && shop.image!.trim().isNotEmpty) {
      try {
        // Cached to disk (not just Flutter's in-memory ImageCache) via the
        // same package the rest of the app uses for network images — the
        // logo is the same URL print after print, so this is what actually
        // makes every print after the first one skip the network entirely,
        // including across app restarts.
        final provider = CachedNetworkImageProvider(shop.image!);
        // `renderWidgetOffscreen` only waits two frames before capturing —
        // plenty for a cache hit, nowhere near enough for a real network
        // fetch. Without forcing the resolve here, a cold cache means the
        // capture happens before the logo has decoded and it silently
        // prints blank. Cheap on every call after the first (cache hit
        // resolves near-instantly); only pays real time on a genuine miss.
        await precacheImage(provider, canvas.context);
        canvas.widget(
          Center(
            child: ClipRect(
              child: SizedBox(
                height: _logoHeight,
                width: _logoHeight,
                child: Image(
                  image: provider,
                  fit: BoxFit.cover,
                  errorBuilder: (_, _, _) => const SizedBox.shrink(),
                ),
              ),
            ),
          ),
        );
      } catch (_) {
        // Logo is a nice-to-have — a failed fetch shouldn't block the
        // whole receipt from printing.
      }
    }

    canvas
      ..textTitle(shop.name)
      ..text(shop.fullAddress, center: true, size: _shopDetailsSize);

    if (shop.phone.isNotEmpty) {
      canvas.text(
        'PH: ${shop.phone}${shop.phone2.isNotNullOrEmpty ? ', ${shop.phone2}' : ''}',
        center: true,
        size: _shopDetailsSize,
      );
    }
    if (shop.gstNumber != null && shop.gstNumber!.trim().isNotEmpty) {
      canvas.text(
        'GSTIN: ${shop.gstNumber}',
        center: true,
        size: _shopDetailsSize,
      );
    }
  }

  /// [termsAndConditions] is caller-resolved rather than read off [shop]
  /// directly — `UserShopEntity` exposes a different fallback list per
  /// receipt type (`defaultBookingsTermsAndConditions`,
  /// `defaultSalesTermsAndConditions`, ...) for when the shop hasn't set
  /// its own, so which one applies depends on the receipt type calling
  /// this, not on this shared section.
  ///
  /// [closingMessage] is the receipt-type-specific sign-off — e.g. "Thank
  /// you for your booking!".
  static Future<void> buildTermsAndFooter(
    ReceiptCanvas canvas, {
    required List<String> termsAndConditions,
    required String closingMessage,
  }) async {
    canvas.divider();
    if (termsAndConditions.isNotEmpty) {
      canvas
        ..text(
          'Terms & Conditions',
          bold: true,
          size: ReceiptCanvas.defaultSectionTitleSize,
          bottomSpacing: _termsAndConditionTitleBottomSpacing,
        )
        ..numberedList(
          termsAndConditions,
          size: _termsAndConditionSize,
          bottomSpacing: _termsAndConditionListItemBottomSpacing,
        );
    }

    canvas
      ..spacer(_footerSpacerHeight)
      ..text(closingMessage, center: true, size: _footerSize);
    await canvas.flushSection();
  }
}
