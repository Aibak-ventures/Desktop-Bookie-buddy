import 'dart:developer';
import 'dart:io';

import 'package:bookie_buddy_web/core/constants/app_assets.dart';
import 'package:bookie_buddy_web/core/constants/enums/service_type_enums.dart';
import 'package:bookie_buddy_web/utils/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/string_extensions.dart';
import 'package:bookie_buddy_web/features/product/domain/models/product_model/product_model.dart';
import 'package:bookie_buddy_web/core/models/user_shop_model/user_shop_model.dart';
import 'package:bookie_buddy_web/core/ui/widgets/global_loading_overlay.dart';
import 'package:bookie_buddy_web/utils/download_file.dart';
import 'package:bookie_buddy_web/utils/get_pdf_image_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class GenerateAvailableProductsPdf {
  static Future<void> shareInvoice({
    required BuildContext context,
    required List<ProductModel> products,
    required UserShopModel shopDetails,
    required String availabilityDate,
  }) async {
    try {
      GlobalLoadingOverlay.show(context, text: 'Generating PDF...');
      final pdf = await generateAvailableProductsPdf(
          products, shopDetails, availabilityDate);

      GlobalLoadingOverlay.hide();

      final fileName =
          'available_products_${DateTime.now().millisecondsSinceEpoch}.pdf';

      if (kIsWeb) {
        // On web, trigger browser download
        downloadFileWeb(pdf, fileName);

        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('PDF downloaded successfully'),
              backgroundColor: Colors.green,
            ),
          );
        }
      } else if (Platform.isWindows) {
        // For Windows desktop, save to Downloads folder and open
        final downloadsDir =
            Directory('${Platform.environment['USERPROFILE']}\\Downloads');
        if (!downloadsDir.existsSync()) {
          downloadsDir.createSync(recursive: true);
        }

        final filePath = '${downloadsDir.path}\\$fileName';
        final file = File(filePath);
        await file.writeAsBytes(pdf);

        log('PDF saved to: $filePath');

        // Open the PDF with default viewer
        try {
          await launchUrl(Uri.file(filePath));
        } catch (e) {
          log('Could not open PDF: $e');
        }

        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('PDF saved to Downloads\\$fileName'),
              backgroundColor: Colors.green,
              action: SnackBarAction(
                label: 'Open Folder',
                textColor: Colors.white,
                onPressed: () async {
                  try {
                    await launchUrl(Uri.file(downloadsDir.path));
                  } catch (e) {
                    log('Could not open folder: $e');
                  }
                },
              ),
            ),
          );
        }
      } else {
        // For mobile, save to temp and share
        final output = await getApplicationDocumentsDirectory();
        final box =
            context.isMobile ? null : context.findRenderObject() as RenderBox?;

        final file = File('${output.path}/$fileName');
        await file.writeAsBytes(pdf);
        final fileNameShort = file.path.split('/').last;

        await SharePlus.instance.share(
          ShareParams(
            title: fileNameShort,
            subject: fileNameShort,
            previewThumbnail: XFile(file.path),
            files: [XFile(file.path)],
            sharePositionOrigin: box == null
                ? null
                : Rect.fromLTWH(
                    box.localToGlobal(Offset.zero).dx,
                    box.localToGlobal(Offset.zero).dy,
                    box.size.width,
                    box.size.height,
                  ),
          ),
        );
      }
    } catch (e, stackTrace) {
      GlobalLoadingOverlay.hide();
      log('Error sharing available products PDF: $e', stackTrace: stackTrace);
      if (context.mounted) {
        context.showSnackBar('Failed to generate PDF: $e');
      }
    }
  }

  // Cached unknown product image (lazy)
  static pw.ImageProvider? _cachedUnknownImage;
  static pw.ImageProvider get _unknownProductImage => _cachedUnknownImage ??=
      pw.MemoryImage(File(AppAssets.unknownProduct).readAsBytesSync());

  static const double _letterSpacing = 0.5;
  static final _pdfGreyColor = PdfColor.fromHex('D9D9D9');
  static final _customColor = const PdfColor.fromInt(0xFF6C5CE7);

  static Future<Uint8List> generateAvailableProductsPdf(
    List<ProductModel> products,
    UserShopModel shopDetails,
    String availabilityDate,
  ) async {
    // Font loading logic
    final fontRegular = await rootBundle.load(AppAssets.interRegularFont);
    final fontSemiBold = await rootBundle.load(AppAssets.interSemiBoldFont);
    final fontExtraBold = await rootBundle.load(AppAssets.interExtraBoldFont);
    final fontMalayalam = await rootBundle.load(
      AppAssets.notoSansMalayalamFont,
    );
    final ttfRegular = pw.Font.ttf(fontRegular);
    final ttfMedium = pw.Font.ttf(fontSemiBold);
    final ttfExtraBold = pw.Font.ttf(fontExtraBold);
    final ttfMalayalam = pw.Font.ttf(fontMalayalam);

    // Load the SVG header graphic
    final headerSvg = await rootBundle.loadString(
      AppAssets.bookingPdfLayoutHeaderSvg,
    );
    final footerSvg = await rootBundle.loadString(
      AppAssets.bookingPdfLayoutFooterSvg,
    );

    final pdf = pw.Document(
      creator: 'Bookie Buddy',
      author: 'AFNAN P',
      theme: pw.ThemeData.withFont(
        base: ttfRegular,
        bold: ttfMedium,
        fontFallback: [ttfMalayalam],
      ),
    );

    final dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 30),
        validateStatus: (status) => status != null && status < 400,
      ),
    );

    final businessImage = await getPdfImageProvider(
      imagePath: shopDetails.image,
      isAsset: false,
      dio: dio,
    );
    final productImages = <pw.ImageProvider>[];
    // download image from network
    for (var i = 0; i < products.length; i++) {
      final product = products[i];
      final productImage = await getPdfImageProvider(
        imagePath: product.image,
        isAsset: product.image == null,
        dio: dio,
      );

      productImages.add(productImage);
    }

    pdf.addPage(
      pw.MultiPage(
        // Page theme with background SVG used as header background
        pageTheme: pw.PageTheme(
          margin: const pw.EdgeInsets.fromLTRB(24, 60, 24, 40),
          buildBackground: (context) {
            if (context.pageNumber == 1) {
              return pw.FullPage(
                ignoreMargins: true,
                child: pw.Column(
                  children: [
                    pw.SvgImage(
                      svg: headerSvg,
                      fit: pw.BoxFit.cover,
                      alignment: pw.Alignment.topCenter,
                    ),
                    pw.Spacer(),
                    pw.SvgImage(
                      svg: footerSvg,
                      alignment: pw.Alignment.bottomCenter,
                    ),
                  ],
                ),
              );
            }
            return pw.FullPage(
              ignoreMargins: true,
              child: pw.SvgImage(
                svg: footerSvg,
                alignment: pw.Alignment.bottomCenter,
              ),
            );
          },
        ),
        build: (context) => [
          _buildShopDetails(
            businessImage,
            shopDetails.name,
            shopDetails.phone,
            shopDetails.phone2,
            shopDetails.fullAddress,
            ttfExtraBold,
          ),
          pw.SizedBox(height: 30),
          _buildInvoiceDetails(availabilityDate),
          pw.SizedBox(height: 20),
          _buildItemsTable(products, productImages),
        ],
      ),
    );

    return pdf.save();
  }

  // Shop details
  static pw.Row _buildShopDetails(
    pw.ImageProvider shopImage,
    String shopName,
    String shopPhone,
    String? shopPhone2,
    String shopAddress,
    pw.Font fontBold,
  ) =>
      pw.Row(
        children: [
          pw.Image(shopImage, width: 60, height: 60),
          pw.SizedBox(width: 12),
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                shopName,
                style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                  color: _customColor,
                  fontSize: 16,
                  fontBold: fontBold,
                ),
              ),
              pw.Text(shopPhone),
              if (shopPhone2?.isNotEmpty == true) pw.Text(shopPhone2!),
              ...shopAddress.splitByWords(4).map(pw.Text.new),
            ],
          ),
        ],
      );

  // Invoice details
  static pw.Widget _buildInvoiceDetails(String availabilityDate) {
    pw.RichText text(String text, String secondText) => pw.RichText(
          text: pw.TextSpan(
            text: text,
            children: [
              pw.TextSpan(
                text: secondText,
                style: const pw.TextStyle(color: PdfColors.grey500),
              ),
            ],
            style: pw.TextStyle(
              fontWeight: pw.FontWeight.bold,
              color: PdfColors.grey800,
              letterSpacing: _letterSpacing,
            ),
          ),
        );

    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        text('AVAILABLE DATE: ', availabilityDate),
      ],
    );
  }

  // Product items table
  static pw.Widget _buildItemsTable(
    List<ProductModel> products,
    List<pw.ImageProvider> productImages,
  ) {
    pw.Text tableHeadingText(
      String text, {
      pw.TextAlign textAlign = pw.TextAlign.left,
    }) =>
        pw.Text(
          text,
          style: pw.TextStyle(
            fontWeight: pw.FontWeight.bold,
            color: PdfColors.black,
            letterSpacing: _letterSpacing,
          ),
          textAlign: textAlign,
        );

    return pw.Container(
      decoration: pw.BoxDecoration(border: pw.Border.all(color: _pdfGreyColor)),
      child: pw.Column(
        children: [
          // Table header
          pw.Container(
            padding: const pw.EdgeInsets.all(12),
            decoration: pw.BoxDecoration(color: _pdfGreyColor),
            child: pw.Row(
              children: [
                pw.Expanded(child: tableHeadingText('NO')),
                pw.Expanded(flex: 5, child: tableHeadingText('ITEM NAME')),
                pw.Expanded(
                  child: tableHeadingText(
                    'QTY',
                    textAlign: pw.TextAlign.center,
                  ),
                ),
                pw.Expanded(
                  flex: 2,
                  child: tableHeadingText(
                    'AMOUNT',
                    textAlign: pw.TextAlign.right,
                  ),
                ),
              ],
            ),
          ),
          // products rows
          if (products.isNotEmpty)
            ...List.generate(products.length, (index) {
              final product = products[index];
              final productImage = index < productImages.length
                  ? productImages[index]
                  : _unknownProductImage;
              return pw.Container(
                padding: const pw.EdgeInsets.all(12),
                decoration: pw.BoxDecoration(
                  color: index % 2 == 0 ? PdfColors.white : PdfColors.grey50,
                ),
                child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.center,
                  children: [
                    pw.Expanded(child: pw.Text((index + 1).toString())),
                    pw.Expanded(
                      flex: 5,
                      child: _itemBuilder(productImage, product),
                    ),
                    pw.Expanded(
                      child: pw.Text(
                        product.variants
                            .fold<int>(
                              0,
                              (qty, variant) =>
                                  qty + (variant.remainingStock ?? 0),
                            )
                            .toString(),
                        textAlign: pw.TextAlign.center,
                      ),
                    ),
                    pw.Expanded(
                      flex: 2,
                      child: pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.end,
                        crossAxisAlignment: pw.CrossAxisAlignment.end,
                        children: [
                          pw.Center(
                            child: pw.Text(
                              (product.price != null && product.price! > 0)
                                  ? product.price!.toCurrency()
                                  : '-----',
                              style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold,
                              ),
                              textAlign: pw.TextAlign.right,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
        ],
      ),
    );
  }

  static pw.Row _itemBuilder(
    pw.ImageProvider productImage,
    ProductModel product,
  ) {
    final mainServiceType = product.mainServiceType;
    const textStyle = const pw.TextStyle(
      fontSize: 12,
      color: PdfColors.grey600,
    );
    return pw.Row(
      children: [
        pw.ClipRRect(
          horizontalRadius: 5,
          verticalRadius: 5,
          child: pw.Image(
            productImage,
            width: 50,
            height: 50,
            fit: pw.BoxFit.cover,
          ),
        ),
        pw.SizedBox(width: 10),
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(
              product.name,
              style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
            ),
            if (mainServiceType.isDress || mainServiceType.isOthers)
              pw.Text('Color: ${product.color ?? '-'}', style: textStyle),
            if (mainServiceType.isVehicle)
              pw.Text('Model: ${product.model ?? '-'}', style: textStyle),
            if (mainServiceType.isVehicle ||
                mainServiceType.isOthers ||
                mainServiceType.isEquipment)
              pw.Text(
                '${mainServiceType.isVehicle ? 'Brand' : 'Category'} : ${product.category ?? '-'}',
                style: textStyle,
              ),
          ],
        ),
      ],
    );
  }
}
