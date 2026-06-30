import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:forui/widgets/progress.dart';
import 'package:go_router/go_router.dart';

import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:url_launcher/url_launcher.dart';

/// ─── NAVIGATION ─────────────────────────────────────────────────────────────
void openWebView(
  BuildContext context, {
  required String title,
  required String url,
}) {
  context.push(
    '/app/webview',
    extra: WebViewArgs(title: title, url: url),
  );
}

class WebViewArgs {
  final String title;
  final String url;

  const WebViewArgs({required this.title, required this.url});
}

/// ─── SCREEN ─────────────────────────────────────────────────────────────────
class WebViewScreen extends StatelessWidget {
  final WebViewArgs args;

  const WebViewScreen({super.key, required this.args});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(args.title)),
      body: _WebViewContainer(url: args.url),
    );
  }
}

/// ─── CONTAINER ──────────────────────────────────────────────────────────────
class _WebViewContainer extends StatefulWidget {
  final String url;

  const _WebViewContainer({required this.url});

  @override
  State<_WebViewContainer> createState() => _WebViewContainerState();
}

class _WebViewContainerState extends State<_WebViewContainer> {
  bool _isLoading = true;
  bool _fallbackTriggered = false;

  late final WebViewController? _mobileController;

  /// ─── PLATFORM CHECKS ──────────────────────────────────────────────────────
  bool get _isLinux => !kIsWeb && Platform.isLinux;

  bool get _canUseLinuxWebView {
    return _isLinux && InAppWebViewPlatform.instance != null;
  }

  /// ─── INIT ─────────────────────────────────────────────────────────────────
  @override
  void initState() {
    super.initState();

    if (!_isLinux) {
      _mobileController = _createMobileController();
    } else {
      _mobileController = null;
    }

    /// fallback imediato
    if (_isLinux && !_canUseLinuxWebView) {
      _scheduleFallback();
    }
  }

  /// ─── CONTROLLER ───────────────────────────────────────────────────────────
  WebViewController _createMobileController() {
    return WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (_) => _setLoading(true),
          onPageFinished: (_) => _setLoading(false),
          onWebResourceError: (error) {
            _handleError(error.description);
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  /// ─── STATE ────────────────────────────────────────────────────────────────
  void _setLoading(bool value) {
    if (mounted && _isLoading != value) {
      setState(() => _isLoading = value);
    }
  }

  void _handleError(String message) {
    debugPrint('WebView error: $message');
    _scheduleFallback();
  }

  /// ─── FALLBACK ─────────────────────────────────────────────────────────────
  void _scheduleFallback() {
    if (_fallbackTriggered) return;
    _fallbackTriggered = true;

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _openExternal();
    });
  }

  Future<void> _openExternal() async {
    final uri = Uri.parse(widget.url);
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  /// ─── BUILD ────────────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    if (_fallbackTriggered) {
      return const Center(child: Text('Abrindo no navegador externo...'));
    }

    final webView = _buildPlatformWebView();

    return Stack(
      fit: StackFit.expand,
      children: [
        Positioned.fill(child: webView),
        if (_isLoading) const _LoadingOverlay(),
      ],
    );
  }

  /// ─── PLATFORM STRATEGY ──────────────────────────────────────────────────────
  Widget _buildPlatformWebView() {
    if (_canUseLinuxWebView) {
      return _buildLinuxWebView();
    }

    return _buildMobileWebView();
  }

  /// ─── MOBILE ───────────────────────────────────────────────────────────────
  Widget _buildMobileWebView() {
    return WebViewWidget(controller: _mobileController!);
  }

  /// ─── LINUX (FOR DEBUGGING) ────────────────────────────────────────────────
  Widget _buildLinuxWebView() {
    return SizedBox.expand(
      child: InAppWebView(
        initialUrlRequest: URLRequest(url: WebUri(widget.url)),
        onLoadStart: (_, _) => _setLoading(true),
        onLoadStop: (_, _) => _setLoading(false),
        onReceivedError: (_, _, error) {
          _handleError(error.description);
        },
      ),
    );
  }
}

/// ─── LOADING ────────────────────────────────────────────────────────────────
class _LoadingOverlay extends StatelessWidget {
  const _LoadingOverlay();

  @override
  Widget build(BuildContext context) {
    return const Positioned(
      top: 12,
      right: 12,
      child: SizedBox(width: 24, height: 24, child: FCircularProgress()),
    );
  }
}
