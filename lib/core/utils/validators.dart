class Validators {
  // Email validation
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email không được để trống';
    }
    
    // Regular expression for email validation
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    
    if (!emailRegExp.hasMatch(value)) {
      return 'Email không hợp lệ';
    }
    
    return null;
  }
  
  // Phone number validation (Vietnam)
  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Số điện thoại không được để trống';
    }
    
    // Regular expression for Vietnam phone numbers
    final phoneRegExp = RegExp(r'^(0|\+84)(\s|\.)?((3[2-9])|(5[689])|(7[06-9])|(8[1-689])|(9[0-46-9]))(\d)(\s|\.)?(\d{3})(\s|\.)?(\d{3})$');
    
    if (!phoneRegExp.hasMatch(value)) {
      return 'Số điện thoại không hợp lệ';
    }
    
    return null;
  }
  
  // Email or phone validation (for login where either can be used)
  static String? validateEmailOrPhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Thông tin đăng nhập không được để trống';
    }
    
    // Check if input is an email or phone number
    final emailResult = validateEmail(value);
    final phoneResult = validatePhoneNumber(value);
    
    // If both validations fail, return error
    if (emailResult != null && phoneResult != null) {
      return 'Vui lòng nhập email hợp lệ';
    }
    
    return null;
  }
  
  // Name validation
  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Họ và tên không được để trống';
    }
    
    if (value.length < 2) {
      return 'Họ và tên phải có ít nhất 2 ký tự';
    }
    
    return null;
  }
  
  // Password validation
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Mật khẩu không được để trống';
    }
    
    if (value.length < 6) {
      return 'Mật khẩu phải có ít nhất 6 ký tự';
    }
    
    // Check for at least one uppercase letter
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Mật khẩu phải chứa ít nhất 1 chữ hoa';
    }
    
    // Check for at least one number
    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Mật khẩu phải chứa ít nhất 1 số';
    }
    
    return null;
  }
  
  // Password confirmation validation
  static String? validatePasswordConfirmation(String? value, String password) {
    if (value == null || value.isEmpty) {
      return 'Xác nhận mật khẩu không được để trống';
    }
    
    if (value != password) {
      return 'Mật khẩu xác nhận không khớp';
    }
    
    return null;
  }
  
  // OTP validation
  static String? validateOtp(String? value) {
    if (value == null || value.isEmpty) {
      return 'Mã OTP không được để trống';
    }
    
    if (value.length != 6) {
      return 'Mã OTP phải có 6 chữ số';
    }
    
    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
      return 'Mã OTP chỉ được chứa số';
    }
    
    return null;
  }
}