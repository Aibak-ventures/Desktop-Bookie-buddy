import 'package:bookie_buddy_web/core/common/widgets/custom_network_image.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

/// 250×250 image picker/preview for [AddEditProductDialog].
///
/// Displays the newly picked [XFile] (via [imageNotifier]), or the
/// [existingImageUrl] from the server, or an "Add image" placeholder.
/// Tapping the area calls [onPickImage].
class ProductImagePickerSection extends StatelessWidget {
  final ValueNotifier<XFile?> imageNotifier;
  final String? existingImageUrl;
  final VoidCallback onPickImage;

  const ProductImagePickerSection({
    super.key,
    required this.imageNotifier,
    required this.existingImageUrl,
    required this.onPickImage,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<XFile?>(
      valueListenable: imageNotifier,
      builder: (context, image, child) {
        Widget imageWidget;

        if (image != null) {
          imageWidget = FutureBuilder<Uint8List>(
            future: image.readAsBytes(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Image.memory(snapshot.data!, fit: BoxFit.cover);
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          );
        } else if (existingImageUrl != null) {
          imageWidget = CustomNetworkImage(imageUrl: existingImageUrl!);
        } else {
          imageWidget = const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.add_photo_alternate_rounded,
                  size: 32,
                  color: AppColors.purpleLight,
                ),
                SizedBox(height: 6),
                Text(
                  'Add image',
                  style: TextStyle(
                    color: AppColors.purpleLight,
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          );
        }

        return GestureDetector(
          onTap: onPickImage,
          child: Container(
            width: 250,
            height: 250,
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade300),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade200,
                  blurRadius: 6,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            clipBehavior: Clip.antiAlias,
            child: imageWidget,
          ),
        );
      },
    );
  }
}
