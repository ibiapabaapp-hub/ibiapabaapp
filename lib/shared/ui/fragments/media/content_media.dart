import 'package:audio_session/audio_session.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:forui/forui.dart';
import 'package:video_player/video_player.dart';
import 'sources.dart';

class ContentMedia extends StatelessWidget {
  final MediaSource source;
  final bool isVideo;
  final bool isPlaying;
  final BoxFit fit;
  final Widget? errorWidget;

  const ContentMedia({
    super.key,
    required this.source,
    this.isVideo = false,
    this.isPlaying = false,
    this.fit = BoxFit.cover,
    this.errorWidget,
  });

  @override
  Widget build(BuildContext context) {
    if (isVideo) {
      return _VideoPlayerWrapper(source: source, isPlaying: isPlaying);
    }
    return _ImagePlayerWrapper(
      source: source,
      fit: fit,
      errorWidget: errorWidget,
    );
  }
}

class _ImagePlayerWrapper extends StatelessWidget {
  final MediaSource source;
  final BoxFit fit;
  final Widget? errorWidget;

  const _ImagePlayerWrapper({
    required this.source,
    required this.fit,
    this.errorWidget,
  });

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: switch (source) {
        NetworkMedia n => CachedNetworkImage(
          fadeOutDuration: const Duration(milliseconds: 0),
          fadeInDuration: const Duration(milliseconds: 200),
          imageUrl: n.url,
          httpHeaders: n.headers,
          fit: fit,
          width: double.infinity,
          height: double.infinity,
          placeholder: (context, url) =>
              Container(color: context.theme.colors.muted),
          errorWidget: (context, url, error) =>
              errorWidget ?? const Icon(Icons.broken_image),
        ),
        AssetMedia a => Image.asset(a.url, fit: fit, width: double.infinity),
        FileMedia f => Image.file(f.file, fit: fit, width: double.infinity),
      },
    );
  }
}

class _VideoPlayerWrapper extends StatefulWidget {
  final MediaSource source;
  final bool isPlaying;

  const _VideoPlayerWrapper({required this.source, required this.isPlaying});

  @override
  State<_VideoPlayerWrapper> createState() => _VideoPlayerWrapperState();
}

class _VideoPlayerWrapperState extends State<_VideoPlayerWrapper> {
  VideoPlayerController? _controller;
  bool _isInitialized = false;

  Future<void> _setupAudioSession() async {
    final session = await AudioSession.instance;
    await session.configure(
      const AudioSessionConfiguration(
        avAudioSessionCategory:
            AVAudioSessionCategory.ambient, // iOS: Permite mixar áudio
        avAudioSessionMode: AVAudioSessionMode.defaultMode,
        avAudioSessionRouteSharingPolicy:
            AVAudioSessionRouteSharingPolicy.defaultPolicy,
        androidAudioAttributes: AndroidAudioAttributes(
          contentType: AndroidAudioContentType.movie,
          usage: AndroidAudioUsage.media,
        ),
        androidAudioFocusGainType: AndroidAudioFocusGainType
            .gainTransientMayDuck, // Android: Baixa o som de outros apps mas não pausa
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _initializeController();
  }

  @override
  void didUpdateWidget(_VideoPlayerWrapper oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (_isInitialized) {
      if (widget.isPlaying) {
        _controller?.play();
      } else {
        _controller?.pause();
      }
    } else if (widget.isPlaying) {
      _initializeController();
    }
  }

  Future<void> _initializeController() async {
    if (_controller != null) return;

    await _setupAudioSession();

    _controller = switch (widget.source) {
      NetworkMedia n => VideoPlayerController.networkUrl(
        Uri.parse(n.url),
        httpHeaders: n.headers ?? {},
      ),
      AssetMedia a => VideoPlayerController.asset(a.url),
      FileMedia f => VideoPlayerController.file(f.file),
    };

    try {
      await _controller!.initialize();

      // Opcional: Garante que o loop esteja ativo para vídeos curtos (stories/destaques)
      await _controller!.setLooping(true);
      await _controller!.setVolume(0);

      if (mounted) {
        setState(() => _isInitialized = true);
        // Só damos o play de fato se ele for o item ativo agora
        if (widget.isPlaying) {
          _controller!.play();
        }
      }
    } catch (e) {
      debugPrint("Erro ao carregar vídeo: $e");
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      return RepaintBoundary(
        child: Container(
          color: Colors.black,
          child: const Center(child: CircularProgressIndicator()),
        ),
      );
    }
    return RepaintBoundary(
      child: Container(
        color: Colors.black,
        child: Center(
          child: AspectRatio(
            aspectRatio: _controller!.value.aspectRatio,
            child: VideoPlayer(_controller!),
          ),
        ),
      ),
    );
  }
}
