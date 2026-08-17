extension ListX<T> on List<T> {
  /// Returns the sum of all values returned by [selector] applied to each element in the list.
  /// If the list is empty, returns 0.
  N sum<N extends num>(N Function(T element) selector) {
    if (isEmpty) return 0 as N;
    return fold(0 as N, (pv, e) => (pv + selector(e)) as N);
  }
}

extension ListXNullable<T> on List<T>? {
  bool get isNullOrEmpty {
    if (this == null) return true;
    return this!.isEmpty;
  }

  bool get isNotNullOrEmpty => !isNullOrEmpty;

  T? firstWhereOrNull(bool Function(T element) test) {
    if (this == null) return null;
    for (final element in this!) {
      if (test(element)) return element;
    }
    return null;
  }
}
