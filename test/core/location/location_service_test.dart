import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ibiapabaapp/core/location/domain/exceptions/location_exceptions.dart';
import 'package:ibiapabaapp/core/location/infra/location_service.dart';
import 'package:ibiapabaapp/core/location/infra/models/geolocator_wrapper.dart';
import 'package:latlong2/latlong.dart';
import 'package:mocktail/mocktail.dart';

class MockGeolocatorWrapper extends Mock implements GeolocatorWrapper {}

void main() {
  late MockGeolocatorWrapper geolocator;
  late LocationService sut;

  final fakePosition = Position(
    latitude: -3.7333,
    longitude: -40.9833,
    timestamp: DateTime(2025),
    accuracy: 10,
    altitude: 0,
    altitudeAccuracy: 0,
    heading: 0,
    headingAccuracy: 0,
    speed: 0,
    speedAccuracy: 0,
  );

  setUpAll(() {
    geolocator = MockGeolocatorWrapper();
    sut = LocationService(geolocator: geolocator);
  });

  // Helper — cenário base: serviço ativo + permissão concedida
  void stubReady({
    LocationPermission permission = LocationPermission.whileInUse,
  }) {
    when(
      () => geolocator.isLocationServiceEnabled(),
    ).thenAnswer((_) async => true);
    when(
      () => geolocator.checkPermission(),
    ).thenAnswer((_) async => permission);
  }

  group('getCurrentLocation', () {
    test('retorna LatLng quando serviço ativo e permissão concedida', () async {
      stubReady();
      when(
        () => geolocator.getCurrentPosition(
          locationSettings: any(named: 'locationSettings'),
        ),
      ).thenAnswer((_) async => fakePosition);

      final result = await sut.getCurrentLocation();

      expect(result, equals(const LatLng(-3.7333, -40.9833)));
    });

    test('lança LocationDisabledException se GPS desativado', () {
      when(
        () => geolocator.isLocationServiceEnabled(),
      ).thenAnswer((_) async => false);

      expect(
        sut.getCurrentLocation,
        throwsA(isA<LocationDisabledException>()),
      );
    });

    test('solicita permissão quando status é denied', () async {
      when(
        () => geolocator.isLocationServiceEnabled(),
      ).thenAnswer((_) async => true);
      when(
        () => geolocator.checkPermission(),
      ).thenAnswer((_) async => LocationPermission.denied);
      when(
        () => geolocator.requestPermission(),
      ).thenAnswer((_) async => LocationPermission.whileInUse);
      when(
        () => geolocator.getCurrentPosition(
          locationSettings: any(named: 'locationSettings'),
        ),
      ).thenAnswer((_) async => fakePosition);

      await sut.getCurrentLocation();

      verify(() => geolocator.requestPermission()).called(1);
    });

    test(
      'lança LocationPermissionDeniedException se usuário nega o diálogo',
      () async {
        when(
          () => geolocator.isLocationServiceEnabled(),
        ).thenAnswer((_) async => true);
        when(
          () => geolocator.checkPermission(),
        ).thenAnswer((_) async => LocationPermission.denied);
        when(
          () => geolocator.requestPermission(),
        ).thenAnswer((_) async => LocationPermission.denied);

        expect(
          sut.getCurrentLocation,
          throwsA(isA<LocationPermissionDeniedException>()),
        );
      },
    );

    test('lança LocationPermissionPermanentlyDeniedException', () async {
      stubReady(permission: LocationPermission.deniedForever);

      expect(
        sut.getCurrentLocation,
        throwsA(isA<LocationPermissionPermanentlyDeniedException>()),
      );
    });

    test('lança LocationTimeoutException em timeout', () async {
      stubReady();
      when(
        () => geolocator.getCurrentPosition(
          locationSettings: any(named: 'locationSettings'),
        ),
      ).thenThrow(TimeoutException('timeout'));

      expect(sut.getCurrentLocation, throwsA(isA<LocationTimeoutException>()));
    });

    test('lança LocationUnknownException para erros inesperados', () async {
      stubReady();
      when(
        () => geolocator.getCurrentPosition(
          locationSettings: any(named: 'locationSettings'),
        ),
      ).thenThrow(Exception('erro inesperado'));

      expect(sut.getCurrentLocation, throwsA(isA<LocationUnknownException>()));
    });
  });

  group('openAppSettings', () {
    test('delega para o geolocator wrapper', () async {
      when(() => geolocator.openAppSettings()).thenAnswer((_) async => true);

      final result = await sut.openAppSettings();

      expect(result, true);
      verify(() => geolocator.openAppSettings()).called(1);
    });
  });
}
