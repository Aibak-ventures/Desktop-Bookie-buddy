enum GenderType {
  male,
  female,
  unisex;

  String get name {
    switch (this) {
      case GenderType.male:
        return 'Male';
      case GenderType.female:
        return 'Female';
      case GenderType.unisex:
        return 'Both';
    }
  }
}
