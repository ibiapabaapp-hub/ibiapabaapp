import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:ibiapabaapp/shared/ui/maps/app_map.dart';
import 'package:latlong2/latlong.dart';

class FlutterMapWidget extends AppMapWidget {
  const FlutterMapWidget({
    super.key,
    required super.initialPosition,
    required super.initialZoom,
    super.currentPosition,
  });

  @override
  State<FlutterMapWidget> createState() => _FlutterMapWidgetState();
}

class _FlutterMapWidgetState extends State<FlutterMapWidget> {
  late final MapController _mapController;

  LatLng _toLatLng(AppLatLng p) => LatLng(p.latitude, p.longitude);

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
  }

  @override
  void didUpdateWidget(FlutterMapWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    final pos = widget.currentPosition;
    if (pos != null && pos != oldWidget.currentPosition) {
      _mapController.move(_toLatLng(pos), 15.0);
    }
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final current = widget.currentPosition;

    return FlutterMap(
      mapController: _mapController,
      options: MapOptions(
        initialCenter: _toLatLng(widget.initialPosition),
        initialZoom: widget.initialZoom,
        interactionOptions: const InteractionOptions(
          flags: InteractiveFlag.none,
        ),
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.ibiapabaapp.app',
          retinaMode: RetinaMode.isHighDensity(context),
        ),
        if (current != null)
          MarkerLayer(
            markers: [
              Marker(
                point: _toLatLng(current),
                width: 40,
                height: 40,
                child: const _LocationMarker(),
              ),
            ],
          ),
      ],
    );
  }
}

class _LocationMarker extends StatelessWidget {
  const _LocationMarker();

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.blue.withAlpha(48),
            shape: BoxShape.circle,
          ),
        ),
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: Colors.blue,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 2),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
