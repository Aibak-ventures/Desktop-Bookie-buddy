/// Model for uploaded document files
class DocumentFile {
  final String name;
  final String path;
  final List<int>? bytes;

  DocumentFile({
    required this.name,
    required this.path,
    this.bytes,
  });
}
