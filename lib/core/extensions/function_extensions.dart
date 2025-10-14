import 'package:flutter/foundation.dart';

extension ExFuture<T> on Future<T> {
  Future<T> trackTime(String label) async {
    final start = DateTime.now();
    final result = await this;
    final end = DateTime.now();
    final duration = end.difference(start);
    debugPrint('$label completed in ${duration.inMilliseconds} ms');
    return result;
  }
}
