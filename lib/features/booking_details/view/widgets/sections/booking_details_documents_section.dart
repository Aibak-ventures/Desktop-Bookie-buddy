import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/features/booking_details/view/widgets/dialogs/document_viewer_dialog.dart';

class BookingDetailsDocumentsSection extends StatelessWidget {
  const BookingDetailsDocumentsSection({
    super.key,
    required this.documents,
  });

  final List<dynamic> documents;

  @override
  Widget build(BuildContext context) {
    if (documents.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.attach_file,
                size: 20.sp,
                color: AppColors.purple,
              ),
              SizedBox(width: 8.w),
              Text(
                'Uploaded Documents',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              SizedBox(width: 8.w),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                decoration: BoxDecoration(
                  color: AppColors.purpleLight,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${documents.length}',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.purple,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          // Horizontal scrollable list of document thumbnails
          SizedBox(
            height: 100.h,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: documents.length,
              separatorBuilder: (context, index) => SizedBox(width: 12.w),
              itemBuilder: (context, index) {
                final document = documents[index];
                final documentUrl = _getDocumentUrl(document);
                final documentName = _getDocumentName(document, index);
                final isImage = _isImageFile(documentUrl);

                return _DocumentThumbnail(
                  documentUrl: documentUrl,
                  documentName: documentName,
                  isImage: isImage,
                  onTap: () => _showDocumentViewer(
                    context,
                    documentUrl,
                    documentName,
                    isImage,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  String _getDocumentUrl(dynamic document) {
    if (document is String) return document;
    if (document is Map) {
      return document['url'] ?? document['path'] ?? document['file'] ?? '';
    }
    return '';
  }

  String _getDocumentName(dynamic document, int index) {
    if (document is Map) {
      return document['name'] ?? 'Document ${index + 1}';
    }
    final url = _getDocumentUrl(document);
    if (url.isNotEmpty) {
      final parts = url.split('/');
      return parts.last;
    }
    return 'Document ${index + 1}';
  }

  bool _isImageFile(String url) {
    final lowerUrl = url.toLowerCase();
    return lowerUrl.endsWith('.jpg') ||
        lowerUrl.endsWith('.jpeg') ||
        lowerUrl.endsWith('.png') ||
        lowerUrl.endsWith('.gif') ||
        lowerUrl.endsWith('.webp') ||
        lowerUrl.endsWith('.bmp');
  }

  void _showDocumentViewer(
    BuildContext context,
    String documentUrl,
    String documentName,
    bool isImage,
  ) {
    showDialog(
      context: context,
      builder: (context) => DocumentViewerDialog(
        documentUrl: documentUrl,
        documentName: documentName,
        isImage: isImage,
      ),
    );
  }
}

class _DocumentThumbnail extends StatelessWidget {
  const _DocumentThumbnail({
    required this.documentUrl,
    required this.documentName,
    required this.isImage,
    required this.onTap,
  });

  final String documentUrl;
  final String documentName;
  final bool isImage;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: 100.w,
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isImage)
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
                  child: Image.network(
                    documentUrl,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    errorBuilder: (context, error, stackTrace) =>
                        _buildFileIcon(),
                  ),
                ),
              )
            else
              Expanded(child: _buildFileIcon()),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(8)),
              ),
              child: Text(
                documentName,
                style: TextStyle(
                  fontSize: 10.sp,
                  color: Colors.black87,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFileIcon() {
    return Icon(
      _getFileIcon(),
      size: 40.sp,
      color: AppColors.purple,
    );
  }

  IconData _getFileIcon() {
    final lowerUrl = documentUrl.toLowerCase();
    if (lowerUrl.endsWith('.pdf')) return Icons.picture_as_pdf;
    if (lowerUrl.endsWith('.doc') || lowerUrl.endsWith('.docx')) {
      return Icons.description;
    }
    if (lowerUrl.endsWith('.xls') || lowerUrl.endsWith('.xlsx')) {
      return Icons.table_chart;
    }
    return Icons.insert_drive_file;
  }
}
