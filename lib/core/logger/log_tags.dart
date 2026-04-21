abstract class LogTag {
  String get tag;
}

enum LogLayer implements LogTag {
  network('[NETWORK]'),
  datasource('[DATASOURCE]'),
  repository('[REPOSITORY]'),
  controller('[CONTROLLER]');

  @override
  final String tag;
  const LogLayer(this.tag);
}

enum LogLib implements LogTag {
  dio('[DIO]'),
  sembast('[SEMBAST]');

  @override
  final String tag;
  const LogLib(this.tag);
}

enum LogStatus implements LogTag {
  success('[SUCCESS]'),
  error('[ERROR]'),
  info('[INFO]');

  @override
  final String tag;
  const LogStatus(this.tag);
}

enum LogFeature implements LogTag {
  auth('[AUTH]'),
  cities('[CITIES]'),
  businesses('[COMPANIES]'),
  events('[EVENTS]'),
  medias('[MEDIAS]'),
  session('[SESSION]'),
  preferences('[PREFERENCES]'),
  categories('[CATEGORIES]'),
  interests('[INTERESTS]'),
  onboarding('[ONBOARDING]'),
  profiles('[PROFILES]'),
  location('[LOCATION]'),
  search('[SEARCH]');

  @override
  final String tag;
  const LogFeature(this.tag);
}
