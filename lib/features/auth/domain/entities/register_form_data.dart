class RegisterFormData {
  String name;
  String username;
  String email;
  String phoneNumber;
  String password;
  String confirmPassword;
  DateTime? birthDate;
  String role;

  RegisterFormData({
    this.name = '',
    this.username = '',
    this.email = '',
    this.phoneNumber = '',
    this.password = '',
    this.confirmPassword = '',
    this.birthDate,
    this.role = 'user',
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'username': username,
      'email': email,
      'phone_number': phoneNumber,
      'password': password,
      'password_confirm': confirmPassword,
      'birth_date': birthDate?.toIso8601String(),
      'role': role,
    };
  }
}
