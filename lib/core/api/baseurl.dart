import 'package:flutter/foundation.dart' show kDebugMode, kIsWeb;

// const String devBaseUrl = "https://dev.bookiebuddy.in";
// const String prodBaseUrl = "https://flutter.bookiebuddy.in";
// String baseUrl = "http://dev.bookiebuddy.in"; //development

// const String baseUrl = 'https://flutter.bookiebuddy.in'; //production
// Force dev API for now since production tokens/setup might not be ready
const String baseUrl = "https://dev.bookiebuddy.in";

// When ready for production, use this:
// const String baseUrl = kDebugMode
//     ? (kIsWeb ? "https://dev.bookiebuddy.in" : "https://flutter.bookiebuddy.in") 
//     : "https://flutter.bookiebuddy.in";
