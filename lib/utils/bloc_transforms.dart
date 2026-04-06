// utils/bloc_transformers.dart

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_transform/stream_transform.dart';

/// Creates an [EventTransformer] that applies a throttle duration to the
/// incoming events, allowing only one event to pass through during the
/// specified [duration]. All other events within this duration are dropped.
///
/// This is useful in scenarios where you want to limit the rate at which
/// events are processed, ensuring that only the first event in the given
/// time frame is handled.
EventTransformer<E> throttleDroppable<E>(
    [Duration duration = const Duration(milliseconds: 500)]) {
  return (events, mapper) =>
      droppable<E>().call(events.throttle(duration), mapper);
}

/// Creates an [EventTransformer] that applies a debounce duration to the
/// incoming events, allowing only the last event to pass through after a
/// specified [duration] of inactivity. Any intermediate events within this
/// duration are dropped.
///
/// This is useful in scenarios where you want to ensure that events are
/// processed only after a certain period of inactivity, such as user input
/// in a search field where you want to wait until the user has stopped
/// typing before performing a search.
EventTransformer<E> debounceDroppable<E>(
    [Duration duration = const Duration(milliseconds: 300)]) {
  return (events, mapper) =>
      droppable<E>().call(events.debounce(duration), mapper);
}
