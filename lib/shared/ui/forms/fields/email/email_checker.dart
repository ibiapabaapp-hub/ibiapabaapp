abstract class EmailChecker {
  Future<bool> checkEmailAvailability(String email);

  void setEmail(String email);

  /// Returns null if availability hasn't been checked yet.
  bool? isEmailAvailable();

  bool isEmailChecking();
}
