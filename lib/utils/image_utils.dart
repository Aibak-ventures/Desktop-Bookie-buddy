import 'dart:developer';
import 'dart:io';

import 'package:bookie_buddy_web/core/common/widgets/custom_snack_bar.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/utils/extensions/context_extensions.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// ignore: depend_on_referenced_packages
import 'package:image/image.dart' as img;
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

/// Utility class for image picking, cropping, and compressing etc.
final class ImageUtils {
  const ImageUtils._();

  static ImagePicker? _imagePicker;
  static ImageCropper? _imageCropper;

  static Future<void> _showPermissionDialog(
    BuildContext context, {
    required String title,
    required String message,
  }) async {
    if (!context.mounted) return;
    await context.showErrorDialog(
      title: 'Camera Permission Required',
      message:
          'Camera access is needed to scan QR codes and barcodes. '
          'Please grant permission in your device settings.',
      buttonText: 'Open Settings',
      onButtonPressed: () async {
        log('📷 Opening app settings...');

        Navigator.of(context).pop();
        await openAppSettings();
      },
    );
  }

  // static Future<void> _showPermissionDialog(
  //   BuildContext context, {
  //   required String title,
  //   required String message,
  // }) async {
  //   if (!context.mounted) return;

  //   await showDialog<void>(
  //     context: context,
  //     builder: (dialogContext) => AlertDialog(
  //       title: Text(title),
  //       content: Text(message),
  //       actions: [
  //         TextButton(
  //           onPressed: () => Navigator.of(dialogContext).pop(),
  //           child: const Text('Cancel'),
  //         ),
  //         FilledButton(
  //           onPressed: () async {
  //             Navigator.of(dialogContext).pop();
  //             await openAppSettings();
  //           },
  //           child: const Text('Open Settings'),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  static Future<bool> _ensurePickerPermission(
    BuildContext context,
    ImageSource source,
  ) async {
    if (source == ImageSource.camera) {
      final status = await Permission.camera.request();
      if (status.isGranted) return true;

      if (status.isPermanentlyDenied || status.isRestricted) {
        await _showPermissionDialog(
          context,
          title: 'Camera permission needed',
          message: 'Please allow camera access in Settings to take photos.',
        );
      } else {
        CustomSnackBar(message: 'Camera permission denied');
      }
      return false;
    }

    // Gallery / photo library
    // if (Platform.isIOS) {
    //   final status = await Permission.photos.request();
    //   if (status.isGranted || status.isLimited) return true;

    //   if (status.isPermanentlyDenied || status.isRestricted) {
    //     await _showPermissionDialog(
    //       context,
    //       title: 'Photos permission needed',
    //       message:
    //           'Please allow photo library access in Settings to select images.',
    //     );
    //   } else {
    //     CustomSnackBar(context: context, message: 'Photos permission denied');
    //   }
    //   return false;
    // }

    // Other platforms: ImagePicker will handle prompts or isn’t restricted.
    return true;
  }

  /// Picks an image from the specified source, crops it, and compresses it if necessary.
  /// Returns the final image file or null if the operation was cancelled or failed.
  static Future<File?> pickAndCompressImage({
    required BuildContext context,
    ImageSource source = ImageSource.gallery,
    double maxSizeInMB = 2.5,
    bool keepAspectRatio = true,
  }) async {
    // Initialize ImagePicker if not already done
    _imagePicker ??= ImagePicker();

    final hasPermission = await _ensurePickerPermission(context, source);
    if (!hasPermission) return null;

    XFile? pickedImage;
    try {
      pickedImage = await _imagePicker!.pickImage(source: source);
    } on PlatformException catch (e, stackTrace) {
      log('Image pick failed: ${e.code} ${e.message}\n$stackTrace');

      final lower = (e.message ?? '').toLowerCase();
      if (lower.contains('permission') ||
          e.code.toLowerCase().contains('denied')) {
        CustomSnackBar(
          message:
              'Permission required to access ${source == ImageSource.camera ? 'camera' : 'photos'}',
        );
      } else if (source == ImageSource.camera && Platform.isIOS) {
        CustomSnackBar(message: 'Camera is not available on this device');
      } else {
        CustomSnackBar(message: 'Unable to pick image. Please try again.');
      }
      return null;
    } catch (e, stackTrace) {
      log('Image pick failed: $e\n$stackTrace');
      CustomSnackBar(message: 'Unable to pick image. Please try again.');
      return null;
    }

    if (pickedImage == null) return null;

    final croppedPath = await cropImage(
      context: context,
      sourcePath: pickedImage.path,
      keepAspectRatio: keepAspectRatio,
    );
    if (croppedPath == null) return null;

    final croppedFile = File(croppedPath);
    final originalSize = await croppedFile.length() / (1024 * 1024);
    log('Original image size: ${originalSize.toStringAsFixed(2)} MB');

    if (originalSize <= maxSizeInMB) return croppedFile;

    try {
      final originalBytes = await croppedFile.readAsBytes();
      final compressedBytes = await compressImage(originalBytes);

      final tempDir = await getTemporaryDirectory();
      final compressedFile = await File(
        '${tempDir.path}/compressed_${DateTime.now().millisecondsSinceEpoch}.jpg',
      ).writeAsBytes(compressedBytes);

      final compressedSize = compressedFile.lengthSync() / (1024 * 1024);
      log('Compressed image size: ${compressedSize.toStringAsFixed(2)} MB');

      if (compressedSize <= maxSizeInMB) {
        return compressedFile;
      } else {
        CustomSnackBar(message: 'Image is still too large after compression');
      }
    } catch (e) {
      log('Image compression failed: $e');
      CustomSnackBar(
        message: 'Something went wrong while compressing the image',
      );
    }

    return null;
  }

  // This will run in a separate isolate
  /// Wrapper to call from main isolate
  static Future<Uint8List> compressImage(Uint8List originalBytes) async =>
      compute(_compressImageLogic, originalBytes);

  static Uint8List _compressImageLogic(
    Uint8List originalBytes, {
    int quality = 90,
    int width = 800,
    double maxSizeInMB = 2.5,
  }) {
    final decodedImage = img.decodeImage(originalBytes);
    if (decodedImage == null) throw Exception('Failed to decode image');

    final resizedImage = img.copyResize(decodedImage, width: width);
    var compressedBytes = Uint8List.fromList(
      img.encodeJpg(resizedImage, quality: quality),
    );

    // Loop to reduce quality until size is below maxSize
    while (compressedBytes.lengthInBytes / (1024 * 1024) > maxSizeInMB &&
        quality > 10) {
      quality -= 10;
      compressedBytes = Uint8List.fromList(
        img.encodeJpg(resizedImage, quality: quality),
      );
    }

    return compressedBytes;
  }

  /// Crops the image at [sourcePath] and returns the path of the cropped image.
  /// Returns null if cropping was cancelled.
  static Future<String?> cropImage({
    required BuildContext context,
    required String sourcePath,
    required bool keepAspectRatio,
    int compressQuality = 90,
  }) async {
    // Initialize ImageCropper if not already done
    _imageCropper ??= ImageCropper();

    final cFile = await _imageCropper!.cropImage(
      sourcePath: sourcePath,
      aspectRatio: keepAspectRatio
          ? const CropAspectRatio(ratioX: 1, ratioY: 1)
          : null,
      compressQuality: compressQuality,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Cropper',
          toolbarColor: AppColors.purple,
          toolbarWidgetColor: AppColors.white,
          activeControlsWidgetColor: AppColors.purple,
          aspectRatioPresets: keepAspectRatio
              ? [CropAspectRatioPreset.original, CropAspectRatioPreset.square]
              : const [
                  CropAspectRatioPreset.original,
                  CropAspectRatioPreset.square,
                  CropAspectRatioPreset.ratio3x2,
                  CropAspectRatioPreset.ratio4x3,
                  CropAspectRatioPreset.ratio16x9,
                ],
        ),
        IOSUiSettings(
          title: 'Cropper',
          aspectRatioPresets: keepAspectRatio
              ? [CropAspectRatioPreset.original, CropAspectRatioPreset.square]
              : const [
                  CropAspectRatioPreset.original,
                  CropAspectRatioPreset.square,
                  CropAspectRatioPreset.ratio3x2,
                  CropAspectRatioPreset.ratio4x3,
                  CropAspectRatioPreset.ratio16x9,
                ],
        ),
        WebUiSettings(context: context),
      ],
    );

    if (cFile != null) {
      log('Image cropped: ${cFile.path}');
      return cFile.path;
    }
    return null;
  }

  /// Check if path is a network image (e.g., starts with http:// or https://)
  static bool isNetworkImage(String path) =>
      path.startsWith('http://') || path.startsWith('https://');

  /// Check if path is a file image (not network image)
  static bool isFileImage(String path) => !isNetworkImage(path);

  static Uint8List? convertPngToJpeg({
    Uint8List? pngBytes,
    img.Image? imageData,
    int quality = 90,
  }) {
    try {
      // Decode the PNG image
      final img.Image? image =
          imageData ?? (pngBytes != null ? img.decodePng(pngBytes) : null);
      if (image == null) {
        throw 'Failed to decode/find PNG image';
      }

      // Convert to JPEG with specified quality
      final jpegBytes = img.encodeJpg(image, quality: quality);
      return Uint8List.fromList(jpegBytes);
    } catch (e) {
      rethrow;
    }
  }

  static Future<MultipartFile> toMultipartFile({
    String? imageFilePath,
    Uint8List? imageBytes,

    /// Add filename for imageBytes to avoid issues
    String? filename,
  }) async {
    if (imageFilePath != null) {
      // Don't forget to add filename otherwise it will not convert properly
      return MultipartFile.fromFile(
        imageFilePath,
        filename: filename ?? imageFilePath.split('/').last,
      );
    }
    if (imageBytes != null) {
      return MultipartFile.fromBytes(imageBytes, filename: filename);
    }
    throw 'Either imageFilePath or imageBytes must be provided';
  }
}
