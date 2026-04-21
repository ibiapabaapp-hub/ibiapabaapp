import 'package:ibiapabaapp/core/logger/log_tags.dart';

enum MediaAction implements LogTag {
  getEntityMedia('[GET_ENTITY_MEDIA]');

  @override
  final String tag;
  const MediaAction(this.tag);
}