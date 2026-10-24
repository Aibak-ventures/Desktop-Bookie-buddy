// Conditional export for PDF viewing
export 'open_pdf_in_new_tab_stub.dart'
    if (dart.library.js_interop) 'open_pdf_in_new_tab_web.dart';
