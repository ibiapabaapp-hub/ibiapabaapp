import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:ibivibe/core/location/presentation/providers/location_state_provider.dart';
import 'package:ibivibe/core/session/app_session_notifier_provider.dart';
import 'package:ibivibe/features/cities/providers/cities_providers.dart';
import 'package:ibivibe/features/home/widgets/recent_locations_list.dart';
import 'package:ibivibe/features/home/widgets/sheet_actions.dart';
import 'package:ibivibe/features/home/widgets/sheet_header.dart';
import 'package:ibivibe/features/home/widgets/sheet_map.dart';
import 'package:ibivibe/shared/ui/fragments/toast/show_app_toast.dart';
import 'package:ibivibe/shared/ui/layout/sheet_drag_indicator.dart';
import 'package:ibivibe/shared/ui/maps/app_map.dart';
import 'package:ibivibe/shared/ui/maps/app_map_provider.dart';

void showChangeLocationSheet({required BuildContext context}) {
  showModalBottomSheet(
    useRootNavigator: true,
    isScrollControlled: true,
    context: context,
    barrierColor: Colors.black45,
    isDismissible: true,
    builder: (context) => const _ChangeLocationSheet(),
  );
}

class _ChangeLocationSheet extends ConsumerStatefulWidget {
  const _ChangeLocationSheet();

  @override
  ConsumerState<_ChangeLocationSheet> createState() =>
      _ChangeLocationSheetState();
}

class _ChangeLocationSheetState extends ConsumerState<_ChangeLocationSheet> {
  bool _loadingLocation = false;
  String? _locationError;

  bool get _locationSupported =>
      defaultTargetPlatform == TargetPlatform.android ||
      defaultTargetPlatform == TargetPlatform.iOS ||
      kIsWeb;

  static const _fallbackPosition = AppLatLng(-3.9248, -40.8868);

  // Widget de mapa criado UMA VEZ — nunca recriado em rebuilds
  late final AppMapWidget _mapWidget;

  @override
  void initState() {
    super.initState();

    final sessionPos = ref.read(locationStateProvider).devicePosition;
    final initialPos = sessionPos != null
        ? AppLatLng(sessionPos.latitude, sessionPos.longitude)
        : _fallbackPosition;

    _mapWidget = AppMapProvider.create(
      initialPosition: initialPos,
      initialZoom: sessionPos != null ? 15.0 : 13.0,
      currentPosition: sessionPos != null ? initialPos : null,
      onCitySelected: onCitySelectedManually,
      currentCityName: ref.read(locationStateProvider).currentCity?.name,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(locationStateProvider.notifier).resolveDevicePosition();
    });
  }

  Future<void> onCitySelectedManually(String cityName) async {
    setState(() {
      _loadingLocation = true;
      _locationError = null;
    });

    final navigator = Navigator.of(context, rootNavigator: true);
    final previousCity = ref.read(appSessionProvider).currentCity;

    try {
      final cities = await ref
          .read(citiesRepositoryProvider)
          .getAllCities();

      if (!mounted) return;

      final city = cities.firstWhereOrNull(
        (c) => c.name.toLowerCase() == cityName.toLowerCase(),
      );

      if (city == null) {
        setState(() {
          _loadingLocation = false;
          _locationError = 'Cidade não encontrada.';
        });
        return;
      }

      await ref.read(locationStateProvider.notifier).setCurrentCity(city);

      if (!mounted) return;
      setState(() => _loadingLocation = false);
      navigator.pop();

      final newCity = ref.read(appSessionProvider).currentCity;
      final cityChanged = newCity != null && newCity.id != previousCity?.id;

      showAppToast(
        alignment: .bottomCenter,
        context: context,
        icon: Icon(
          cityChanged ? Icons.location_on : Icons.location_on_outlined,
        ),
        title: cityChanged
            ? 'Localização atualizada'
            : 'Localização confirmada',
        description: cityChanged
            ? 'Você agora está em ${newCity.name}'
            : 'Você continua em ${newCity?.name ?? 'sua cidade atual'}',
      );
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _loadingLocation = false;
        _locationError = e.toString();
      });
    }
  }

  Future<void> _detectNearestCity() async {
    setState(() {
      _loadingLocation = true;
      _locationError = null;
    });

    final previousCity = ref.read(appSessionProvider).currentCity;
    final failure = await ref
        .read(locationStateProvider.notifier)
        .detectAndSetNearestCity();

    if (!mounted) return;

    if (failure != null) {
      setState(() {
        _loadingLocation = false;
        _locationError = failure.message;
      });

      final title = switch (failure.code) {
        'location_permission_denied' => 'Permissão de localização negada',
        'location_permission_denied_permanently' =>
          'Permissão de localização negada permanentemente',
        'location_service_disabled' => 'Localização desativada ou indisponível',
        'location_service_timeout' => 'Tempo esgotado para obter localização',
        _ => 'Erro de localização',
      };

      showAppToast(
        alignment: .topCenter,
        context: context,
        icon: const Icon(Icons.location_off_outlined),
        title: title,
        description: failure.message,
      );
    } else {
      setState(() => _loadingLocation = false);

      final newCity = ref.read(appSessionProvider).currentCity;
      final cityChanged = newCity != null && newCity.id != previousCity?.id;

      showAppToast(
        alignment: .bottomCenter,
        context: context,
        icon: Icon(
          cityChanged ? Icons.location_on : Icons.location_on_outlined,
        ),
        title: cityChanged
            ? 'Localização atualizada'
            : 'Localização confirmada',
        description: cityChanged
            ? 'Você agora está em ${newCity.name}'
            : 'Você continua em ${newCity?.name ?? ', sua cidade atual'}',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    final devicePos = ref.watch(locationStateProvider).devicePosition;
    final currentPosition = devicePos != null
        ? AppLatLng(devicePos.latitude, devicePos.longitude)
        : null;

    final mapWithPosition = AppMapProvider.updatePosition(
      _mapWidget,
      currentPosition,
    );

    return SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.72,
        decoration: BoxDecoration(
          color: theme.colors.background,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(child: SheetDragIndicator()),
              const SizedBox(height: 16),

              // ── Header ────────────────────────────────────────────────────
              const SheetHeader(),
              const SizedBox(height: 12),

              // ── Mapa ──────────────────────────────────────────────────────
              if (!_locationSupported) const SheetActionsUnsupported(),

              SheetMap(
                isLoadingMap: _loadingLocation,
                mapWithPosition: mapWithPosition,
              ),
              const SizedBox(height: 12),

              // ── Botões ────────────────────────────────────────────────────
              if (_locationSupported)
                SheetActions(
                  isLoadingLocation: _loadingLocation,
                  detectNearestCity: _detectNearestCity,
                  currentCityName: ref
                      .read(locationStateProvider)
                      .currentCity
                      ?.name,
                  currentPosition: currentPosition,
                  onCitySelected: onCitySelectedManually,
                ),

              // ── Erro ──────────────────────────────────────────────────────
              if (_locationError != null) ...[
                const SizedBox(height: 8),
                Text(
                  _locationError!,
                  style: theme.typography.sm.copyWith(
                    color: theme.colors.destructive,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
              const SizedBox(height: 24),

              // ── Locais recentes ───────────────────────────────────────────
              Text(
                'Locais recentes',
                style: theme.typography.lg.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              const RecentLocationsList(),
            ],
          ),
        ),
      ),
    );
  }
}
