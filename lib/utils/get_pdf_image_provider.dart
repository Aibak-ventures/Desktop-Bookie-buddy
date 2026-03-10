import 'package:bookie_buddy_web/core/constants/app_assets.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:pdf/widgets.dart' as pw;

Future<pw.ImageProvider> getPdfImageProvider({
  required String? imagePath,
  required bool isAsset,
  String assetImagePath = AppAssets.unknownProduct,
  Dio? dio,
}) async {
  Uint8List imageBytes;

  if (isAsset || imagePath == null) {
    // Load image from assets
    final byteData = await rootBundle.load(assetImagePath);
    imageBytes = byteData.buffer.asUint8List();
  } else {
    // Load image from network using Dio
    final dioClient = dio ?? Dio();
    try {
      final response = await dioClient.get<List<int>>(
        imagePath,
        options: Options(responseType: ResponseType.bytes),
      );
      imageBytes = Uint8List.fromList(response.data!);
    } catch (e) {
      // Load image from assets
      final byteData = await rootBundle.load(assetImagePath);
      imageBytes = byteData.buffer.asUint8List();
    }
  }

  return pw.MemoryImage(imageBytes);
}
