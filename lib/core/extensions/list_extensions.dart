extension ListX<T> on List<T>? {
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
