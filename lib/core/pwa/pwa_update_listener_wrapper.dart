import 'package:bookie_buddy_web/core/pwa/pwa_update_service.dart';
import 'package:bookie_buddy_web/core/pwa/update_available_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PwaUpdateListenerWrapper extends StatefulWidget {
  const PwaUpdateListenerWrapper({super.key, required this.child});

  final Widget child;

  @override
  State<PwaUpdateListenerWrapper> createState() =>
      _PwaUpdateListenerWrapperState();
}

class _PwaUpdateListenerWrapperState extends State<PwaUpdateListenerWrapper> {
  @override
  void initState() {
    super.initState();
    if (kIsWeb) {
      PwaUpdateService.listenForUpdates(_onUpdateAvailable);
    }
  }

  void _onUpdateAvailable() {
    if (!mounted) return;
    showUpdateAvailableDialog(context);
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
