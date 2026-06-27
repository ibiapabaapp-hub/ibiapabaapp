import 'package:ibivibe/core/entities/entity_type.dart';

class Media {
  final String id;
  final EntityType entityType;
  final String entityId;
  final MediaType mediaType;
  final String url;
  final String? thumbnailUrl;
  final String? altText;
  final bool isCover;
  final int position;

  const Media({
    required this.id,
    required this.entityType,
    required this.entityId,
    required this.mediaType,
    required this.url,
    this.thumbnailUrl,
    this.altText,
    required this.isCover,
    required this.position,
  });
}

enum MediaType { image, video }
