class UserModel {
  final int id;
  final String phone;
  final String fullName;
  final String? lastName;
  final String? email;
  final String role;
  final int shopId;
  final String shopName;
  final String shopPhone;
  final String shopAddress;
  final String? gstNumber;
  final String? shopRole;
  final String? shopImage;
  final String? termsAndConditions;
  final bool? multipleShops;
  final SubscriptionModel? subscription;

  const UserModel({
    required this.id,
    required this.phone,
    required this.fullName,
    this.lastName,
    this.email,
    required this.role,
    required this.shopId,
    required this.shopName,
    required this.shopPhone,
    required this.shopAddress,
    this.gstNumber,
    this.shopRole,
    this.shopImage,
    this.termsAndConditions,
    this.multipleShops,
    this.subscription,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? 0,
      phone: json['phone'] ?? '',
      fullName: json['full_name'] ?? '',
      lastName: json['last_name'],
      email: json['email'],
      role: json['role'] ?? '',
      shopId: json['shop_id'] ?? 0,
      shopName: json['shop_name'] ?? '',
      shopPhone: json['shop_phone'] ?? '',
      shopAddress: json['shop_address'] ?? '',
      gstNumber: json['gst_number'],
      shopRole: json['shop_role'],
      shopImage: json['shop_image'],
      termsAndConditions: json['terms_and_conditions'],
      multipleShops: json['multiple_shops'],
      subscription: json['subscription'] != null
          ? SubscriptionModel.fromJson(json['subscription'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'phone': phone,
      'full_name': fullName,
      'last_name': lastName,
      'email': email,
      'role': role,
      'shop_id': shopId,
      'shop_name': shopName,
      'shop_phone': shopPhone,
      'shop_address': shopAddress,
      'gst_number': gstNumber,
      'shop_role': shopRole,
      'shop_image': shopImage,
      'terms_and_conditions': termsAndConditions,
      'multiple_shops': multipleShops,
      'subscription': subscription?.toJson(),
    };
  }

  UserModel copyWith({
    int? id,
    String? phone,
    String? fullName,
    String? lastName,
    String? email,
    String? role,
    int? shopId,
    String? shopName,
    String? shopPhone,
    String? shopAddress,
    String? gstNumber,
    String? shopRole,
    String? shopImage,
    String? termsAndConditions,
    bool? multipleShops,
    SubscriptionModel? subscription,
  }) {
    return UserModel(
      id: id ?? this.id,
      phone: phone ?? this.phone,
      fullName: fullName ?? this.fullName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      role: role ?? this.role,
      shopId: shopId ?? this.shopId,
      shopName: shopName ?? this.shopName,
      shopPhone: shopPhone ?? this.shopPhone,
      shopAddress: shopAddress ?? this.shopAddress,
      gstNumber: gstNumber ?? this.gstNumber,
      shopRole: shopRole ?? this.shopRole,
      shopImage: shopImage ?? this.shopImage,
      termsAndConditions: termsAndConditions ?? this.termsAndConditions,
      multipleShops: multipleShops ?? this.multipleShops,
      subscription: subscription ?? this.subscription,
    );
  }
}

class SubscriptionModel {
  final String plan;
  final String status;
  final List<String> features;
  final String expiryDate;
  final int daysRemaining;

  const SubscriptionModel({
    required this.plan,
    required this.status,
    required this.features,
    required this.expiryDate,
    required this.daysRemaining,
  });

  factory SubscriptionModel.fromJson(Map<String, dynamic> json) {
    return SubscriptionModel(
      plan: json['plan'] ?? '',
      status: json['status'] ?? '',
      features: List<String>.from(json['features'] ?? []),
      expiryDate: json['expiry_date'] ?? '',
      daysRemaining: json['days_remaining'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'plan': plan,
      'status': status,
      'features': features,
      'expiry_date': expiryDate,
      'days_remaining': daysRemaining,
    };
  }
}

class UserProfileResponse {
  final String status;
  final String message;
  final UserModel data;
  final String? devMessage;

  const UserProfileResponse({
    required this.status,
    required this.message,
    required this.data,
    this.devMessage,
  });

  factory UserProfileResponse.fromJson(Map<String, dynamic> json) {
    return UserProfileResponse(
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      data: UserModel.fromJson(json['data'] ?? {}),
      devMessage: json['dev_message'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': data.toJson(),
      'dev_message': devMessage,
    };
  }
}
