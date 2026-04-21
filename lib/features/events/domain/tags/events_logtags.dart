import 'package:ibiapabaapp/core/logger/log_tags.dart';

enum EventAction implements LogTag {
  getAllEvents('[GET_ALL_EVENTS]'),
  getEventById('[GET_EVENT_BY_ID]'),
  getEventMedia('[GET_EVENT_MEDIA]');

  @override
  final String tag;
  const EventAction(this.tag);
}
