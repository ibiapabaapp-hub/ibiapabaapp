import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:ibiapabaapp/shared/ui/maps/app_map.dart';
import 'package:ibiapabaapp/shared/ui/maps/app_map_provider.dart';
import 'package:ibiapabaapp/shared/ui/maps/fallback_map_widget.dart';

class SheetMap extends StatelessWidget {
  final AppMapWidget mapWithPosition;
  final bool isLoadingMap;

  const SheetMap({
    super.key,
    required this.isLoadingMap,
    required this.mapWithPosition,
  });

  @override
  Widget build(BuildContext context) {
    final isFallback = mapWithPosition is FallbackMapWidget;

    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: SizedBox(
        height: isFallback ? 64 : 180,
        child: Stack(
          children: [
            mapWithPosition,
            if (isLoadingMap)
              Positioned.fill(
                child: ColoredBox(
                  color: context.theme.colors.muted,
                  child: Center(
                    child: FCircularProgress(
                      style: (style) => style.copyWith(
                        iconStyle: style.iconStyle.copyWith(size: 32),
                      ),
                    ),
                  ),
                ),
              ),
            if (!isFallback && !isLoadingMap)
              Positioned(
                bottom: 8,
                right: 8,
                child: _ExpandMapButton(mapWithPosition: mapWithPosition),
              ),
          ],
        ),
      ),
    );
  }
}

class _ExpandMapButton extends StatelessWidget {
  final AppMapWidget mapWithPosition;
  const _ExpandMapButton({required this.mapWithPosition});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          _showMapPopup(context, AppMapProvider.asInteractive(mapWithPosition)),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: context.theme.colors.background.withAlpha(200),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: context.theme.colors.border),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.fullscreen,
              size: 16,
              color: context.theme.colors.foreground,
            ),
            const SizedBox(width: 4),
            Text(
              'Expandir',
              style: context.theme.typography.sm.copyWith(
                color: context.theme.colors.foreground,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void _showMapPopup(BuildContext context, AppMapWidget mapWidget) {
  showDialog(
    context: context,
    barrierColor: Colors.black54,
    builder: (context) => _MapPopup(mapWidget: mapWidget),
  );
}

class _MapPopup extends StatelessWidget {
  final AppMapWidget mapWidget;
  const _MapPopup({required this.mapWidget});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Center(
      child: SizedBox(
        width: size.width * 0.9,
        height: size.height * 0.9,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            children: [
              // ── Mapa ──────────────────────────────────────────────────────
              Positioned.fill(child: mapWidget),

              // ── Botão fechar ──────────────────────────────────────────────
              Positioned(
                top: 12,
                right: 12,
                child: GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: context.theme.colors.background.withAlpha(224),
                      shape: BoxShape.circle,
                      border: Border.all(color: context.theme.colors.border),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.close,
                      size: 18,
                      color: context.theme.colors.foreground,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
