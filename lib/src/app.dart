import 'package:flutter/material.dart';

/// Main application widget
/// 
/// This is the root widget of the application, configuring:
/// - Theme
/// - Routes
/// - Global providers
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bookie Buddy',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF667eea),
        ),
      ),
      // TODO: Add proper routing
      home: const Scaffold(
        body: Center(
          child: Text('Bookie Buddy - Desktop'),
        ),
      ),
    );
  }
}
