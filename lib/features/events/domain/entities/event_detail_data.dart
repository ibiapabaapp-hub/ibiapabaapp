import 'package:ibiapabaapp/shared/models/event.dart';
import 'package:ibiapabaapp/shared/models/media.dart';

class EventDetailData {
  final Event event;
  final List<Media> media;
  const EventDetailData({required this.event, required this.media});
}
