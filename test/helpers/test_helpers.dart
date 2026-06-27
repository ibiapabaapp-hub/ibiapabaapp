import 'package:flutter_riverpod/flutter_riverpod.dart';

ProviderContainer createContainer({
  List<dynamic> overrides = const [],
}) {
  return ProviderContainer(overrides: overrides.cast());
}
