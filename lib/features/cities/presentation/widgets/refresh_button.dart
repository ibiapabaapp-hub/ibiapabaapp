import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:ibiapabaapp/shared/ui/fragments/toast/show_app_toast.dart';
import 'package:intl/intl.dart';

class RefreshButton extends StatefulWidget {
  final Future<void> Function() onRefresh;

  const RefreshButton({super.key, required this.onRefresh});

  @override
  State<RefreshButton> createState() => _RefreshButtonState();
}

class _RefreshButtonState extends State<RefreshButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isLoading = false;

  // --- Configurações de Rate Limiting ---
  final int maxAttempts = 3;
  final Duration windowDuration = const Duration(minutes: 30);
  final List<DateTime> _clickHistory = [];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool get _isRateLimited {
    final now = DateTime.now();
    // Limpa registros antigos fora da janela de tempo
    _clickHistory.removeWhere(
      (timestamp) => now.difference(timestamp) > windowDuration,
    );
    return _clickHistory.length >= maxAttempts;
  }

  DateTime get _nextReleaseTime {
    if (_clickHistory.isEmpty) return DateTime.now();
    // O botão libera quando o clique mais antigo sair da janela de tempo
    return _clickHistory.first.add(windowDuration);
  }

  Future<void> _handlePress() async {
    if (_isLoading) return;

    final now = DateTime.now();

    // Verifica Rate Limit
    if (_isRateLimited) {
      final waitTime = DateFormat('HH:mm').format(_nextReleaseTime);
      if (mounted) {
        showAppToast(
          context: context,
          title: 'Limite atingido. Tente novamente após às $waitTime',
        );
      }
      return;
    }

    // Registra a tentativa
    setState(() {
      _isLoading = true;
      _clickHistory.add(now);
    });

    _controller.repeat();

    try {
      await widget.onRefresh();
      if (mounted) {
        showAppToast(
          context: context,
          icon: const Icon(Icons.check_circle, color: Colors.green, size: 16),
          title: 'Dados atualizados!',
        );
      }
    } catch (e) {
      if (mounted) {
        showAppToast(context: context, title: 'Falha na sincronização.');
      }
    } finally {
      if (mounted) {
        _controller.stop();
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final limited = _isRateLimited;

    return FittedBox(
      alignment: Alignment.centerLeft,
      child: FButton(
        // Desabilita o botão visualmente se estiver em loading ou rate limited
        style: limited ? FButtonStyle.ghost() : FButtonStyle.secondary(),
        onPress: limited ? null : _handlePress,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            RotationTransition(
              turns: _controller,
              child: Icon(
                limited ? Icons.lock_clock_rounded : Icons.refresh_rounded,
                size: 20,
                color: limited ? context.theme.colors.mutedForeground : null,
              ),
            ),
            const SizedBox(width: 4),
            Text(
              limited ? 'Bloqueado' : 'Atualizar',
              style: TextStyle(
                color: limited ? context.theme.colors.mutedForeground : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
