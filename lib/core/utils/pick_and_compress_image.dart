import 'dart:developer';
import 'dart:io';

import 'package:bookie_buddy_web/core/ui/widgets/custom_snack_bar.dart';
import 'package:bookie_buddy_web/utils/image_crop.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

Future<File?> pickAndCompressImage({
  required BuildContext context,
  required ImageSource source,
  double maxSizeInMB = 2.5,
}) async {
  final XFile? pickedImage = await ImagePicker().pickImage(source: source);
  if (pickedImage == null) return null;

  final croppedPath = await cropImage(
    context: context,
    sourcePath: pickedImage.path,
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
    CustomSnackBar(message: 'Something went wrong while compressing the image');
  }

  return null;
}

// This will run in a separate isolate
/// Wrapper to call from main isolate
Future<Uint8List> compressImage(Uint8List originalBytes) async =>
    compute(compressImageLogic, originalBytes);

Uint8List compressImageLogic(
  Uint8List originalBytes, {
  int quality = 100,
  int width = 800,
  double maxSizeInMB = 2.8,
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
