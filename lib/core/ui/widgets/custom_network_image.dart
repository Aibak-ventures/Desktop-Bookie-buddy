import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

/// A widget that displays a network image with caching support.
///
/// The [CustomNetworkImage] widget uses the `CachedNetworkImage` package
/// to display an image from the network and cache it for future use. It
/// provides various customization options such as placeholder, error widget,
/// image builder, fit, filter quality, height, and width.
class CustomNetworkImage extends StatelessWidget {
  CustomNetworkImage({
    super.key,
    required this.imageUrl,
    this.placeholder,
    this.errorWidget,
    this.imageBuilder,
    this.fit = BoxFit.cover,
    this.filterQuality = FilterQuality.medium,
    this.height,
    this.width,
    this.progressIndicatorBuilder,
    // this.enableRelativePathResolution = true,
  });

  final String imageUrl;

  // / If true (default) and [imageUrl] is a relative path (starts with '/')
  // / the global [baseUrl] will be prefixed.
  // final bool enableRelativePathResolution;

  final Widget Function(BuildContext context, String url)? placeholder;

  final Widget Function(BuildContext context, String url, Object error)?
      errorWidget;

  final Widget Function(
      BuildContext context, ImageProvider<Object> imageProvider)? imageBuilder;

  final Widget Function(
          BuildContext context, String url, DownloadProgress progress)?
      progressIndicatorBuilder;

  final BoxFit fit;

  final FilterQuality filterQuality;

  final double? height;

  final double? width;

  @override
  Widget build(BuildContext context) {
    final sanitizedUrl = _sanitizeAndResolve(imageUrl);

    if (sanitizedUrl == null) {
      log('🔴 Invalid image URL: $imageUrl 🔴');
      // Don't call CachedNetworkImage with an invalid/empty URL – return fallback immediately.
      if (errorWidget != null) {
        return errorWidget!(context, imageUrl, 'Invalid image URL');
      }
      // Basic neutral placeholder
      return Container(
        color: Colors.grey.shade200,
        alignment: Alignment.center,
        child: Icon(
          Icons.image_not_supported_outlined,
          size: (height != null && height! < 40) ? height! * 0.6 : 24,
          color: Colors.grey.shade400,
        ),
      );
    }

    return CachedNetworkImage(
      imageUrl: sanitizedUrl,
      placeholder: placeholder,
      errorWidget: errorWidget,
      imageBuilder: imageBuilder,
      fit: fit,
      filterQuality: filterQuality,
      height: height,
      width: width,
      progressIndicatorBuilder: progressIndicatorBuilder,
    );
  }

  /// Returns a valid absolute URL string or null if invalid/empty.
  String? _sanitizeAndResolve(String raw) {
    final trimmed = raw.trim();
    if (trimmed.isEmpty)
      return null; // Prevent the Crashlytics: No host specified

    // Already full http/https URL
    if (trimmed.startsWith('http://') || trimmed.startsWith('https://')) {
      return trimmed;
    }

    // If looks like protocol-relative (//host/path) add https:
    if (trimmed.startsWith('//')) {
      return 'https:$trimmed';
    }

    // // Relative path handling
    // if (enableRelativePathResolution && trimmed.startsWith('/')) {
    //   // Ensure no double slash after baseUrl
    //   return baseUrl.endsWith('/')
    //       ? '${baseUrl.substring(0, baseUrl.length - 1)}$trimmed'
    //       : '$baseUrl$trimmed';
    // }

    // Any other case (e.g., 'image.png') – treat as invalid to avoid malformed URI.
    return null;
  }
}
