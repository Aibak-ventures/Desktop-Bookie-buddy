// Conditional export for file download
export 'download_file_stub.dart'
    if (dart.library.js_interop) 'download_file_web.dart';
