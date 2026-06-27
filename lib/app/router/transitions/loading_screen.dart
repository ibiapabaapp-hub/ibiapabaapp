import 'dart:async';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

class LoadingScreen extends StatefulWidget {
  final String? message;
  final List<String>? messages;

  const LoadingScreen({super.key, this.message, this.messages});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  int _currentMessageIndex = 0;
  Timer? _messageTimer;

  @override
  void initState() {
    super.initState();
    if (widget.messages != null && widget.messages!.length > 1) {
      _messageTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
        if (mounted) {
          setState(() {
            _currentMessageIndex =
                (_currentMessageIndex + 1) % widget.messages!.length;
          });
        }
      });
    }
  }

  @override
  void dispose() {
    _messageTimer?.cancel();
    super.dispose();
  }

  String get _displayMessage {
    if (widget.message != null) return widget.message!;
    if (widget.messages != null && widget.messages!.isNotEmpty) {
      return widget.messages![_currentMessageIndex];
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return FScaffold(
      child: Column(
        mainAxisSize: .max,
        mainAxisAlignment: .center,
        children: [
          FCircularProgress(
            style: (style) =>
                style.copyWith(iconStyle: style.iconStyle.copyWith(size: 32)),
          ),
          if (_displayMessage.isNotEmpty) ...[
            const SizedBox(height: 16),
            Text(
              _displayMessage,
              style: context.theme.typography.sm,
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }
}
