import 'package:ibivibe/core/logger/log_tags.dart';

enum LocationActions implements LogTag {
  restore('[RESTORE]'),
  setCurrentCity('[SET_CURRENT_CITY]'),
  clearCurrentCity('[CLEAR_CURRENT_CITY]'),
  detectNearestCity('[DETECT_NEAREST_CITY]'),
  resolveDevicePosition('[RESOLVE_DEVICE_POSITION]');

  @override
  final String tag;
  const LocationActions(this.tag);
}