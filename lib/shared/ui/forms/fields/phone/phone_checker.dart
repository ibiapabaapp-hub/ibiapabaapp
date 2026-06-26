abstract class PhoneChecker {
  Future<bool> checkPhoneAvailability(String phone);

  void setPhone(String phone);

  /// Returns null if availability hasn't been checked yet.
  bool? isPhoneAvailable();

  bool isPhoneChecking();
}
