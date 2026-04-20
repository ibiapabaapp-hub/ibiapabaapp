import 'package:ibiapabaapp/features/events/domain/entities/event.dart';
import 'package:ibiapabaapp/features/medias/domain/entity/media.dart';

class EventDetailData {
  final Event event;
  final List<Media> media;
  const EventDetailData({required this.event, required this.media});
}
