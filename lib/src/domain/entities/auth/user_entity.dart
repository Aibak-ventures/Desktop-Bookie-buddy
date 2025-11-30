/// Domain entity representing a user
/// 
/// This is a pure domain object with no dependencies on external packages.
/// It represents the business concept of a User.
class UserEntity {
  final int id;
  final String phone;
  final String name;
  final String? email;
  final String? profileImage;
  final DateTime createdAt;

  const UserEntity({
    required this.id,
    required this.phone,
    required this.name,
    this.email,
    this.profileImage,
    required this.createdAt,
  });

  /// Create a copy with modified fields
  UserEntity copyWith({
    int? id,
    String? phone,
    String? name,
    String? email,
    String? profileImage,
    DateTime? createdAt,
  }) {
    return UserEntity(
      id: id ?? this.id,
      phone: phone ?? this.phone,
      name: name ?? this.name,
      email: email ?? this.email,
      profileImage: profileImage ?? this.profileImage,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is UserEntity &&
        other.id == id &&
        other.phone == phone &&
        other.name == name &&
        other.email == email &&
        other.profileImage == profileImage &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return Object.hash(
      id,
      phone,
      name,
      email,
      profileImage,
      createdAt,
    );
  }

  @override
  String toString() {
    return 'UserEntity(id: $id, phone: $phone, name: $name)';
  }
}
