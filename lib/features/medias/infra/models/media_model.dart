import 'package:ibiapabaapp/features/medias/domain/entity/media.dart';

class MediaModel {
  static Media fromJson(Map<String, dynamic> json) {
    return Media(
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

  static EntityType _parseEntityType(String value) {
    return EntityType.values.firstWhere((e) => e.name == value);
  }

  static List<Media> fromJsonList(dynamic jsonList) {
    if (jsonList == null) return [];
    final list = jsonList as List<dynamic>;
    return list.map((json) => fromJson(json as Map<String, dynamic>)).toList();
  }
}
