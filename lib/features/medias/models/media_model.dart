import 'package:equatable/equatable.dart';
import 'package:ibivibe/core/entities/entity_type.dart';
import 'package:ibivibe/shared/models/media.dart';

class MediaModel extends Equatable {
  final String id;
  final EntityType entityType;
  final String entityId;
  final MediaType mediaType;
  final String url;
  final String? thumbnailUrl;
  final String? altText;
  final bool isCover;
  final int position;

  const MediaModel({
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

  factory MediaModel.fromJson(Map<String, dynamic> json) {
    return MediaModel(
      id: json['id'] as String,
      entityId: json['entity_id'] as String,
      entityType: _parseEntityType(json['entity_type'] as String),
      mediaType: json['media_type'] == 'video'
          ? MediaType.video
          : MediaType.image,
      url: json['url'] as String,
      thumbnailUrl: json['thumbnail_url'] as String?,
      altText: json['alt_text'] as String?,
      isCover: json['is_cover'] as bool? ?? false,
      position: json['position'] as int? ?? 0,
    );
  }

  Media toEntity() {
    return Media(
      id: id,
      entityType: entityType,
      entityId: entityId,
      mediaType: mediaType,
      url: url,
      thumbnailUrl: thumbnailUrl,
      altText: altText,
      isCover: isCover,
      position: position,
    );
  }

  static EntityType _parseEntityType(String value) {
    return EntityType.values.firstWhere((e) => e.name == value);
  }

  static List<Media> fromJsonList(dynamic jsonList) {
    if (jsonList == null) return [];
    final list = jsonList as List<dynamic>;
    return list
        .map((json) => MediaModel.fromJson(json as Map<String, dynamic>).toEntity())
        .toList();
  }

  @override
  List<Object?> get props => [
        id,
        entityType,
        entityId,
        mediaType,
        url,
        thumbnailUrl,
        altText,
        isCover,
        position,
      ];
}
