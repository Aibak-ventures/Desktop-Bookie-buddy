// ignore_for_file: public_member_api_docs, sort_constructors_first
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
    required this.imageUrl, Key? key,
    this.placeholder,
    this.errorWidget,
    this.imageBuilder,
    this.fit = BoxFit.cover,
    this.filterQuality = FilterQuality.medium,
    this.height,
    this.width,
    this.progressIndicatorBuilder,
  }) : super(key: key);

  final String imageUrl;

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
    return CachedNetworkImage(
      imageUrl: imageUrl,
      placeholder: placeholder,
      errorWidget: errorWidget,
      imageBuilder: imageBuilder,
      fit: fit,
      filterQuality: filterQuality,
      alignment: Alignment.center,
      height: height,
      width: width,
      progressIndicatorBuilder: progressIndicatorBuilder,
    );
  }
}
