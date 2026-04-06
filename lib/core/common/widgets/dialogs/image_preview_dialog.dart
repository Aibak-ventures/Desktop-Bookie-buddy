import 'dart:developer';
import 'dart:io';

import 'package:bookie_buddy_web/core/common/widgets/custom_network_image.dart';
import 'package:bookie_buddy_web/core/constants/app_assets.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/utils/extensions/color_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/list_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/string_extensions.dart';
import 'package:bookie_buddy_web/utils/image_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ImagePreviewDialog extends StatefulWidget {
  const ImagePreviewDialog({
    super.key,
    required this.imageUrl,
    this.imageUrls,
    this.errorWidgetBuilder,
    this.downloadable = false,
    this.shareable = false,
  });

  final String? imageUrl;
  final List<String>? imageUrls;
  final Widget Function()? errorWidgetBuilder;
  final bool downloadable;
  final bool shareable;

  @override
  State<ImagePreviewDialog> createState() => _ImagePreviewDialogState();
}

class _ImagePreviewDialogState extends State<ImagePreviewDialog> {
  late final List<String> _urls;
  late final int _initialIndex;
  late final PageController _pageController;

  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();

    final validImageUrl = widget.imageUrl.isNullOrEmpty
        ? null
        : widget.imageUrl;

    _urls = <String>[
      ...?widget.imageUrls,
      if (widget.imageUrls.isNullOrEmpty && validImageUrl != null)
        validImageUrl,
    ].map((e) => e.trim()).where((e) => e.isNotEmpty).toList(growable: false);

    final foundIndex = validImageUrl == null
        ? -1
        : _urls.indexWhere((e) => e == validImageUrl);
    _initialIndex = _urls.isEmpty ? 0 : (foundIndex >= 0 ? foundIndex : 0);
    _currentIndex = _initialIndex;

    _pageController = PageController(initialPage: _initialIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  bool get _hasMultiple => _urls.length > 1;
  bool get _isFirst => _currentIndex <= 0;
  bool get _isLast => _urls.isEmpty || _currentIndex >= (_urls.length - 1);

  void _previous() {
    if (_hasMultiple && !_isFirst) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
      );
    }
  }

  void _next() {
    if (_hasMultiple && !_isLast) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
      );
    }
  }

  // void _showSnackBar(String message, {bool isError = false}) {
  //   if (!mounted) return;

  //   CustomSnackBar(
  //     message: message,
  //     isError: isError,
  //     duration: const Duration(seconds: 4),
  //   );
  // }

  Widget _buildErrorWidget() => Container(
    width: 120.w,
    height: 350.w,
    decoration: BoxDecoration(
      color: Colors.grey.shade200,
      borderRadius: 12.radiusBorder,
    ),
    child: Icon(Icons.broken_image, size: 40.sp, color: Colors.grey.shade400),
  );

  Widget _buildPreviewContent(String? url) {
    final safeUrl = url.isNullOrEmpty ? null : url!;
    final isNetwork = ImageUtils.isNetworkImage(safeUrl ?? '');

    final Widget child = safeUrl.isNullOrEmpty
        ? Image.asset(
            AppAssets.unknownProduct,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) =>
                widget.errorWidgetBuilder?.call() ?? _buildErrorWidget(),
          )
        : isNetwork
        ? CustomNetworkImage(
            imageUrl: safeUrl!,
            fit: BoxFit.contain,
            placeholder: (context, url) => SizedBox(
              width: double.infinity,
              height: 0.4.heightR,
              child: ColoredBox(color: AppColors.grey.changeOpacity(0.2)),
            ),
            filterQuality: FilterQuality.high,
            errorWidget: (context, error, stackTrace) {
              log('Error loading image file: $error\n$stackTrace');
              return widget.errorWidgetBuilder?.call() ?? _buildErrorWidget();
            },
          )
        : Image.file(
            File(safeUrl!),
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
              log('Error loading image file: $error\n$stackTrace');
              return widget.errorWidgetBuilder?.call() ?? _buildErrorWidget();
            },
          );

    return InteractiveViewer(
      minScale: 1.0,
      maxScale: 4.5,
      // Keep horizontal swipes reliable when multiple.
      panEnabled: !_hasMultiple,
      child: child,
    );
  }

  Widget _buildNavButton({
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return IconButton(
      onPressed: onPressed,
      icon: Container(
        padding: 8.padding,
        decoration: BoxDecoration(
          color: Colors.black54,
          borderRadius: 999.radiusBorder,
        ),
        child: Icon(icon, color: Colors.white, size: 28.sp),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentUrl = _urls.isEmpty ? null : _urls[_currentIndex];
    // final currentIsNetwork = ImageUtils.isNetworkImage(currentUrl ?? '');
    final canShowActions =
        (widget.downloadable || widget.shareable) && !currentUrl.isNullOrEmpty;

    return Shortcuts(
      shortcuts: const <ShortcutActivator, Intent>{
        SingleActivator(LogicalKeyboardKey.arrowLeft): _PreviousIntent(),
        SingleActivator(LogicalKeyboardKey.arrowRight): _NextIntent(),
      },
      child: Actions(
        actions: <Type, Action<Intent>>{
          _PreviousIntent: CallbackAction<_PreviousIntent>(
            onInvoke: (_) {
              _previous();
              return null;
            },
          ),
          _NextIntent: CallbackAction<_NextIntent>(
            onInvoke: (_) {
              _next();
              return null;
            },
          ),
        },
        child: Focus(
          autofocus: true,
          child: Dialog(
            backgroundColor: Colors.transparent,
            insetPadding: 16.padding,
            child: Stack(
              alignment: Alignment.center,
              fit: StackFit.expand,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: _hasMultiple
                      ? PageView.builder(
                          controller: _pageController,
                          onPageChanged: (i) =>
                              setState(() => _currentIndex = i),
                          itemCount: _urls.length,
                          itemBuilder: (context, index) =>
                              _buildPreviewContent(_urls[index]),
                        )
                      : _buildPreviewContent(currentUrl),
                ),

                if (_hasMultiple && !_isFirst)
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 8.w),
                        child: _buildNavButton(
                          icon: Icons.chevron_left_rounded,
                          onPressed: _previous,
                        ),
                      ),
                    ),
                  ),

                if (_hasMultiple && !_isLast)
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsets.only(right: 8.w),
                        child: _buildNavButton(
                          icon: Icons.chevron_right_rounded,
                          onPressed: _next,
                        ),
                      ),
                    ),
                  ),

                if (_hasMultiple)
                  Positioned(
                    bottom: 12.h,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ).r,
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: 999.radiusBorder,
                      ),
                      child: Text(
                        '${_currentIndex + 1}/${_urls.length}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

                Positioned(
                  top: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      20.height,
                      if (canShowActions)
                        // _ActionButtons(
                        //   imageUrl: currentUrl!,
                        //   isNetworkImage: currentIsNetwork,
                        //   downloadable: widget.downloadable,
                        //   shareable: widget.shareable,
                        //   showSnackBar: _showSnackBar,
                        // ),
                        20.width,
                      IconButton(
                        icon: Container(
                          padding: 8.padding,
                          decoration: BoxDecoration(
                            color: Colors.black54,
                            borderRadius: 20.radiusBorder,
                          ),
                          child: const Icon(Icons.close, color: Colors.white),
                        ),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// class _ActionButtons extends StatelessWidget {
//   const _ActionButtons({
//     required this.imageUrl,
//     required this.isNetworkImage,
//     required this.downloadable,
//     required this.shareable,
//     required this.showSnackBar,
//   });

//   final String imageUrl;
//   final bool isNetworkImage;
//   final bool downloadable;
//   final bool shareable;
//   final void Function(String message, {bool isError}) showSnackBar;

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       mainAxisAlignment: MainAxisAlignment.end,
//       spacing: 5,
//       children: [
//         if (shareable)
//           IconButton.filled(
//             icon: const Icon(LucideIcons.share2),
//             style: ElevatedButton.styleFrom(
//               padding: 10.padding,
//               backgroundColor: AppColors.purpleLight,
//               iconColor: AppColors.black,
//               shape: RoundedRectangleBorder(borderRadius: 10.radiusBorder),
//             ),
//             onPressed: () async {
//               try {
//                 // final file = isNetworkImage
//                 //     ? await AppCacheManager.productImages.getSingleFile(
//                 //         imageUrl,
//                 //       )
//                 //     : File(imageUrl);
//                 if (isNetworkImage) {
//                   log('Network image not supported for sharing');
//                   return;
//                 }
//                 final file = File(imageUrl);
//                 await shareFile(context: context, filePath: file.path);
//               } catch (e, stackTrace) {
//                 log('Error opening share dialog: $e\n$stackTrace');
//                 showSnackBar('Unable to open share options', isError: true);
//               }
//             },
//           ),
//         if (downloadable)
//           IconButton.filled(
//             icon: const Icon(LucideIcons.download),
//             style: ElevatedButton.styleFrom(
//               padding: 10.padding,
//               backgroundColor: AppColors.purpleLight,
//               iconColor: AppColors.black,
//               shape: RoundedRectangleBorder(borderRadius: 10.radiusBorder),
//             ),
//             onPressed: () async {
//               try {
//                 // final file = isNetworkImage
//                 //     ? await AppCacheManager.productImages.getSingleFile(
//                 //         imageUrl,
//                 //       )
//                 //     : File(imageUrl);

//                  if (isNetworkImage) {
//                   log('Network image not supported for sharing');
//                   return;
//                 }
//                 final file = File(imageUrl);

//                 FileSaveResult result;
//                 try {
//                   result = await FileStorageUtils.saveFileToDownloads(
//                     fileBytes: await file.readAsBytes(),
//                     fileName: file.path.split('/').last,
//                     subfolder: FileStorageSubDirectory.images,
//                   );
//                 } catch (e) {
//                   result = FileSaveResult.failed();
//                 }

//                 log(
//                   'Image Save Result: isSuccess=${result.isSuccess}, filePath=${result.filePath}',
//                 );

//                 if (!context.mounted) return;

//                 if (result.isSuccess) {
//                   final message =
//                       'File saved to ${Platform.isAndroid ? FileStorageSubDirectory.images.fullFolderPath : FileStorageSubDirectory.images.folderPath}!';
//                   showSnackBar(message);
//                 } else {
//                   showSnackBar('Error saving file to device', isError: true);
//                 }
//               } catch (e, stackTrace) {
//                 log('Error opening save dialog: $e\n$stackTrace');
//                 showSnackBar('Unable to open save options', isError: true);
//               }
//             },
//           ),
//       ],
//     );
//   }
// }

class _PreviousIntent extends Intent {
  const _PreviousIntent();
}

class _NextIntent extends Intent {
  const _NextIntent();
}
