class AppInputValidators {
  // Phone number validation
  static String? phoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }
    
    // Remove any non-digit characters for validation
    final cleanValue = value.replaceAll(RegExp(r'[^\d]'), '');
    
    if (cleanValue.length < 10) {
      return 'Phone number must be at least 10 digits';
    }
    
    if (cleanValue.length > 15) {
      return 'Phone number cannot exceed 15 digits';
    }
    
    return null;
  }

  // Number only validation (for debug mode)
  static String? numberOnly(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    
    if (!RegExp(r'^\d+$').hasMatch(value)) {
      return 'Only numbers are allowed';
    }
    
    return null;
  }

  // Password validation
  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    
    if (value.length > 50) {
      return 'Password cannot exceed 50 characters';
    }
    
    return null;
  }

  // Email validation
  static String? email(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    
    final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    
    return null;
  }

  // Required field validation
  static String? required(String? value, {String fieldName = 'This field'}) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  // Name validation
  static String? name(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Name is required';
    }
    
    if (value.trim().length < 2) {
      return 'Name must be at least 2 characters';
    }
    
    if (value.trim().length > 50) {
      return 'Name cannot exceed 50 characters';
    }
    
    return null;
  }

  // Confirm password validation
  static String? confirmPassword(String? value, String originalPassword) {
    if (value == null || value.isEmpty) {
      return 'Confirm password is required';
    }
    
    if (value != originalPassword) {
      return 'Passwords do not match';
    }
    
    return null;
  }

  // New password validation (for change password)
  static String? newPassword(String? value, String? oldPassword) {
    if (value == null || value.isEmpty) {
      return 'New password is required';
    }
    
    if (value.length < 6) {
      return 'New password must be at least 6 characters';
    }
    
    if (value.length > 50) {
      return 'New password cannot exceed 50 characters';
    }
    
    if (oldPassword != null && value == oldPassword) {
      return 'New password must be different from old password';
    }
    
    return null;
  }

  // Secret password validation (for wallet login)
  static String? secretPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Secret password is required';
    }
    
    if (value.length < 4) {
      return 'Secret password must be at least 4 characters';
    }
    
    return null;
  }

  // Phone number formatter (to add +91 prefix if needed)
  static String formatPhoneNumber(String phone) {
    // Remove any non-digit characters
    final cleanPhone = phone.replaceAll(RegExp(r'[^\d]'), '');
    
    // Add +91 prefix if it's a 10-digit Indian number
    if (cleanPhone.length == 10 && !cleanPhone.startsWith('91')) {
      return '+91$cleanPhone';
    }
    
    // Add + prefix if it's missing
    if (cleanPhone.length > 10 && !phone.startsWith('+')) {
      return '+$cleanPhone';
    }
    
    return phone;
  }
}
