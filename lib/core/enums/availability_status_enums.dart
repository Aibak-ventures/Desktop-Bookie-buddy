enum CheckAvailabilityStatus {
  available,
  partiallyAvailable,
  unavailable;

  /// Converts [CheckAvailabilityStatus] enum to a string label to display in the UI.
  String get name {
    switch (this) {
      case CheckAvailabilityStatus.available:
        return "Available";
      case CheckAvailabilityStatus.partiallyAvailable:
        return "Partially Available";
      case CheckAvailabilityStatus.unavailable:
        return "Unavailable";
    }
  }

  /// Converts the [CheckAvailabilityStatus] enum to its corresponding string value
  /// for use in API requests or data storage.
  ///
  /// Returns:
  ///   The string value associated with the enum.
  String toValue() {
    switch (this) {
      case CheckAvailabilityStatus.available:
        return "available";
      case CheckAvailabilityStatus.partiallyAvailable:
        return "partial_unavailable";
      case CheckAvailabilityStatus.unavailable:
        return "unavailable";
    }
  }

  /// Converts a string representation of a check availability status to its corresponding enum value.
  ///
  /// Supported string representations:
  ///
  /// - "available"
  /// - "partially available"
  /// - "unavailable"
  ///
  /// Returns [CheckAvailabilityStatus.available] if the given string is not recognized.
  static CheckAvailabilityStatus fromString(String status) {
    switch (status.toLowerCase()) {
      case "available":
        return CheckAvailabilityStatus.available;
      case "partial_unavailable":
        return CheckAvailabilityStatus.partiallyAvailable;
      case "unavailable":
        return CheckAvailabilityStatus.unavailable;
      default:
        return CheckAvailabilityStatus.available;
    }
  }
}
