import 'dart:io';

sealed class MediaSource {
  final String url;
  final String? title;
  final String? route;
  final bool isVideo;

  MediaSource({
    required this.url,
    this.title,
    this.route,
    this.isVideo = false,
  });
}

class NetworkMedia extends MediaSource {
  final Map<String, String>? headers;
  final String? blurHash;

  NetworkMedia({
    required super.url,
    super.title,
    super.route,
    super.isVideo,
    this.headers,
    this.blurHash,
  });
}

class AssetMedia extends MediaSource {
  AssetMedia({
    required super.url,
    super.title,
    super.route,
    super.isVideo,
  });
}

class FileMedia extends MediaSource {
  final File file;
  FileMedia({
    required this.file,
    super.title,
    super.route,
    super.isVideo,
  }) : super(url: file.path);
}
