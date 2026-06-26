abstract class SlugChecker {
  Future<bool> checkSlugAvailability(String slug);

  void setSlug(String slug);

  /// Returns null if availability hasn't been checked yet.
  bool? isSlugAvailable();

  bool isSlugChecking();
}

final slugRegex = RegExp(
  r'^(?=.{4,30}$)(?![._])(?!.*[._]{2})[a-zA-Z0-9._]+(?<![._])$',
);
