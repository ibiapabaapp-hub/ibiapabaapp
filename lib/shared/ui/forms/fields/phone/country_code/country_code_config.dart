class CountryPhoneConfig {
  final String code;
  final String flag;
  final String name;
  final String example;
  final int minDigits;
  final int maxDigits;

  const CountryPhoneConfig({
    required this.code,
    required this.flag,
    required this.name,
    required this.example,
    required this.minDigits,
    required this.maxDigits,
  });

  static const brazil = CountryPhoneConfig(
    code: '+55',
    flag: '🇧🇷',
    name: 'Brasil',
    example: '(11) 99999-9999',
    minDigits: 10,
    maxDigits: 11,
  );

  static const custom = CountryPhoneConfig(
    code: 'custom',
    flag: '🌍',
    name: 'Outro país',
    example: '123456789',
    minDigits: 4,
    maxDigits: 14,
  );
}
