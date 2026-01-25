import 'dart:typed_data';

import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/features/new_booking/view/new_booking_screen.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class BookingDocumentUploadSection extends StatelessWidget {
  final ValueNotifier<List<DocumentFile>> documentsNotifier;

  const BookingDocumentUploadSection({
    super.key,
    required this.documentsNotifier,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Upload documents',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
              InkWell(
                onTap: () => _pickDocuments(context),
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: AppColors.purple.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Icon(
                    Icons.add,
                    color: AppColors.purple,
                    size: 18,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ValueListenableBuilder<List<DocumentFile>>(
            valueListenable: documentsNotifier,
            builder: (context, documents, _) {
              if (documents.isEmpty) {
                return _buildEmptyState(context);
              }
              return _buildDocumentGrid(documents);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return InkWell(
      onTap: () => _pickDocuments(context),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.grey.shade200,
            style: BorderStyle.solid,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.cloud_upload_outlined,
              color: Colors.grey.shade400,
              size: 24,
            ),
            const SizedBox(width: 8),
            Text(
              'Click to upload documents',
              style: TextStyle(
                color: Colors.grey.shade500,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDocumentGrid(List<DocumentFile> documents) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: documents.map((doc) => _buildDocumentThumbnail(doc)).toList(),
    );
  }

  Widget _buildDocumentThumbnail(DocumentFile document) {
    final isImage = _isImageFile(document.name);

    return Stack(
      children: [
        Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: isImage && document.bytes != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(7),
                  child: Image.memory(
                    Uint8List.fromList(document.bytes!),
                    fit: BoxFit.cover,
                  ),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      _getFileIcon(document.name),
                      color: Colors.grey.shade500,
                      size: 24,
                    ),
                    const SizedBox(height: 4),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Text(
                        document.name,
                        style: TextStyle(
                          fontSize: 9,
                          color: Colors.grey.shade600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
        ),
        Positioned(
          top: -4,
          right: -4,
          child: InkWell(
            onTap: () => _removeDocument(document),
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.close,
                color: Colors.white,
                size: 12,
              ),
            ),
          ),
        ),
      ],
    );
  }

  bool _isImageFile(String fileName) {
    final ext = fileName.toLowerCase().split('.').last;
    return ['jpg', 'jpeg', 'png', 'gif', 'webp', 'bmp'].contains(ext);
  }

  IconData _getFileIcon(String fileName) {
    final ext = fileName.toLowerCase().split('.').last;
    switch (ext) {
      case 'pdf':
        return Icons.picture_as_pdf;
      case 'doc':
      case 'docx':
        return Icons.description;
      case 'xls':
      case 'xlsx':
        return Icons.table_chart;
      default:
        return Icons.insert_drive_file;
    }
  }

  void _pickDocuments(BuildContext context) async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf', 'doc', 'docx'],
        allowMultiple: true,
        withData: true,
      );

      if (result != null && result.files.isNotEmpty) {
        final newDocs = result.files.map((file) {
          return DocumentFile(
            name: file.name,
            path: file.path ?? '',
            bytes: file.bytes,
          );
        }).toList();

        final currentDocs = List<DocumentFile>.from(documentsNotifier.value);
        currentDocs.addAll(newDocs);
        documentsNotifier.value = currentDocs;
      }
    } on Exception catch (e) {
      debugPrint('File picker error: $e');
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error selecting files: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      debugPrint('Unexpected error picking files: $e');
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('An unexpected error occurred while selecting files'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _removeDocument(DocumentFile document) {
    final docs = List<DocumentFile>.from(documentsNotifier.value);
    docs.remove(document);
    documentsNotifier.value = docs;
  }
}
