import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:ibiapabaapp/shared/models/city.dart';
import 'package:ibiapabaapp/features/cities/presentation/providers/cities_providers.dart';
import 'package:ibiapabaapp/shared/ui/maps/app_map.dart';

class FallbackMapWidget extends AppMapWidget {
  const FallbackMapWidget({
    super.key,
    required super.initialPosition,
    required super.initialZoom,
    super.currentPosition,
    super.onCitySelected,
    super.currentCityName,
  });

  @override
  ConsumerState<FallbackMapWidget> createState() => _FallbackMapWidgetState();
}

class _FallbackMapWidgetState extends ConsumerState<FallbackMapWidget> {
  List<City> _cities = [];
  City? _selected;

  @override
  void initState() {
    super.initState();
    _loadCities();
  }

  @override
  void didUpdateWidget(FallbackMapWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.currentPosition == oldWidget.currentPosition) return;
    final matched = _cityFromPosition(widget.currentPosition);
    if (matched != null && matched != _selected) {
      setState(() => _selected = matched);
    }
  }

  // ── helpers ───────────────────────────────────────────────────────────────

  Future<void> _loadCities() async {
    final container = ProviderScope.containerOf(context, listen: false);
    try {
      final cities = await container
          .read(citiesRepositoryProvider)
          .getAllCities();

      if (!mounted) return;

      setState(() {
        _cities = cities;

        final byName = widget.currentCityName != null
            ? cities.firstWhereOrNull(
                (c) =>
                    c.name.toLowerCase() ==
                    widget.currentCityName!.toLowerCase(),
              )
            : null;

        _selected = byName ?? _cityFromPosition(widget.currentPosition);
      });
    } catch (_) {}
  }

  City? _cityFromPosition(AppLatLng? pos) {
    if (pos == null) return null;
    for (final city in _cities) {
      final loc = city.location;
      if (loc == null) continue;
      if ((loc.latitude - pos.latitude).abs() < 0.01 &&
          (loc.longitude - pos.longitude).abs() < 0.01) {
        return city;
      }
    }
    return null;
  }

  Iterable<City> _filter(String query) => query.isEmpty
      ? _cities
      : _cities.where(
          (c) => c.name.toLowerCase().contains(query.toLowerCase()),
        );

  Future<void> _onChange(City? city) async {
    if (city == null) return;
    setState(() => _selected = city);
    await widget.onCitySelected?.call(city.name);
  }

  // ── build ─────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (_cities.isEmpty)
          Center(
            child: FCircularProgress(
              style: (s) =>
                  s.copyWith(iconStyle: s.iconStyle.copyWith(size: 20)),
            ),
          )
        else
          _CitySelect(
            selected: _selected,
            filter: _filter,
            onChange: _onChange,
          ),
      ],
    );
  }
}

// ── Sub-widgets ───────────────────────────────────────────────────────────────
class _CitySelect extends StatelessWidget {
  final City? selected;
  final Iterable<City> Function(String) filter;
  final Future<void> Function(City?) onChange;

  const _CitySelect({
    required this.selected,
    required this.filter,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return FSelect<City>.searchBuilder(
      control: FSelectControl.lifted(value: selected, onChange: onChange),
      hint: 'Selecione uma cidade',
      format: (city) => city.name,
      filter: filter,
      contentBuilder: (context, _, cities) => [
        for (final city in cities)
          FSelectItem.item(
            prefix: Icon(
              Icons.location_on_outlined,
              size: 16,
              color: context.theme.colors.mutedForeground,
            ),
            title: Text(
              city.name,
              style: TextStyle(color: context.theme.colors.foreground),
            ),
            value: city,
          ),
      ],
    );
  }
}
