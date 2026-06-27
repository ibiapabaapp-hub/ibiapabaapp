import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ibivibe/core/cache/cache_database_service.dart';
import 'package:logger/logger.dart';
import 'package:mocktail/mocktail.dart';


class MockLogger extends Mock implements Logger {}

void main() {
  late CacheDatabaseService service;
  late MockLogger logger;
  late Directory tempDir;

  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();

    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      const MethodChannel('plugins.flutter.io/path_provider'),
      (MethodCall methodCall) async {
        if (methodCall.method == 'getApplicationCacheDirectory') {
          return tempDir.path;
        }
        return null;
      },
    );

    registerFallbackValue(Level.info);
    registerFallbackValue(StackTrace.empty);
  });

  setUp(() async {
    logger = MockLogger();
    tempDir = Directory.systemTemp.createTempSync('cache_test_');
    service = CacheDatabaseService(logger: logger);
    await service.init();
  });

  tearDown(() async {
    try {
      await tempDir.delete(recursive: true);
    } catch (_) {}
  });

  group('CacheDatabaseService', () {
    group('init', () {
      test('should initialize database successfully', () {
        expect(service, isA<CacheDatabaseService>());
      });
    });

    group('saveObject and getObject', () {
      test('should save and retrieve an object', () async {
        await service.saveObject<Map<String, dynamic>>(
          storeName: 'test_store',
          key: 'item1',
          item: {'name': 'Test Item', 'value': 42},
          toMap: (item) => item,
        );

        final result = await service.getObject<Map<String, dynamic>>(
          storeName: 'test_store',
          key: 'item1',
          fromJson: (map) => map,
        );

        expect(result, isNotNull);
        expect(result!['name'], 'Test Item');
        expect(result['value'], 42);
      });

      test('should return null for non-existent key', () async {
        final result = await service.getObject<Map<String, dynamic>>(
          storeName: 'test_store',
          key: 'non_existent',
          fromJson: (map) => map,
        );

        expect(result, isNull);
      });

      test('should add last_update timestamp', () async {
        await service.saveObject<Map<String, dynamic>>(
          storeName: 'test_store',
          key: 'item_with_ts',
          item: {'data': 'test'},
          toMap: (item) => item,
        );

        final result = await service.getObject<Map<String, dynamic>>(
          storeName: 'test_store',
          key: 'item_with_ts',
          fromJson: (map) => map,
        );

        expect(result, isNotNull);
        expect(result!['last_update'], isA<String>());
        expect(result['data'], 'test');
      });

      test('should overwrite existing object', () async {
        await service.saveObject<Map<String, dynamic>>(
          storeName: 'test_store',
          key: 'overwrite',
          item: {'version': 1},
          toMap: (item) => item,
        );

        await service.saveObject<Map<String, dynamic>>(
          storeName: 'test_store',
          key: 'overwrite',
          item: {'version': 2},
          toMap: (item) => item,
        );

        final result = await service.getObject<Map<String, dynamic>>(
          storeName: 'test_store',
          key: 'overwrite',
          fromJson: (map) => map,
        );

        expect(result!['version'], 2);
      });
    });

    group('getObject with maxAge', () {
      test('should return null when cache is expired', () async {
        await service.saveObject<Map<String, dynamic>>(
          storeName: 'ttl_store',
          key: 'old_item',
          item: {'data': 'old'},
          toMap: (item) => item,
        );

        final result = await service.getObject<Map<String, dynamic>>(
          storeName: 'ttl_store',
          key: 'old_item',
          fromJson: (map) => map,
          maxAge: Duration.zero,
        );

        expect(result, isNull);
      });

      test('should return data when cache is fresh', () async {
        await service.saveObject<Map<String, dynamic>>(
          storeName: 'ttl_store',
          key: 'fresh_item',
          item: {'data': 'fresh'},
          toMap: (item) => item,
        );

        final result = await service.getObject<Map<String, dynamic>>(
          storeName: 'ttl_store',
          key: 'fresh_item',
          fromJson: (map) => map,
          maxAge: const Duration(hours: 1),
        );

        expect(result, isNotNull);
        expect(result!['data'], 'fresh');
      });
    });

    group('saveList and getList', () {
      test('should save and retrieve a list', () async {
        final items = [
          {'id': '1', 'name': 'Item 1'},
          {'id': '2', 'name': 'Item 2'},
        ];

        await service.saveList<Map<String, dynamic>>(
          storeName: 'list_store',
          items: items,
          toMap: (item) => item,
        );

        final result = await service.getList<Map<String, dynamic>>(
          storeName: 'list_store',
          fromJson: (map) => map,
        );

        expect(result, hasLength(2));
        expect(result[0]['name'], 'Item 1');
        expect(result[1]['name'], 'Item 2');
      });

      test('should return empty list for non-existent store', () async {
        final result = await service.getList<Map<String, dynamic>>(
          storeName: 'non_existent_store',
          fromJson: (map) => map,
        );

        expect(result, isEmpty);
      });

      test('should use custom key', () async {
        await service.saveList<Map<String, dynamic>>(
          storeName: 'keyed_store',
          items: [{'id': '1'}],
          toMap: (item) => item,
          key: 'custom_key',
        );

        final result = await service.getList<Map<String, dynamic>>(
          storeName: 'keyed_store',
          fromJson: (map) => map,
          key: 'custom_key',
        );

        expect(result, hasLength(1));
      });

      test('should return expired list as empty with maxAge', () async {
        await service.saveList<Map<String, dynamic>>(
          storeName: 'ttl_list',
          items: [{'id': '1'}],
          toMap: (item) => item,
        );

        final result = await service.getList<Map<String, dynamic>>(
          storeName: 'ttl_list',
          fromJson: (map) => map,
          maxAge: Duration.zero,
        );

        expect(result, isEmpty);
      });
    });

    group('clearKey', () {
      test('should delete a specific key', () async {
        await service.saveObject<Map<String, dynamic>>(
          storeName: 'clear_store',
          key: 'to_delete',
          item: {'data': 'delete me'},
          toMap: (item) => item,
        );

        await service.clearKey(
          storeName: 'clear_store',
          key: 'to_delete',
        );

        final result = await service.getObject<Map<String, dynamic>>(
          storeName: 'clear_store',
          key: 'to_delete',
          fromJson: (map) => map,
        );

        expect(result, isNull);
      });
    });

    group('clear', () {
      test('should clear a specific store', () async {
        await service.saveObject<Map<String, dynamic>>(
          storeName: 'to_clear',
          key: 'item1',
          item: {'data': '1'},
          toMap: (item) => item,
        );

        await service.clear(storeName: 'to_clear');

        final result = await service.getObject<Map<String, dynamic>>(
          storeName: 'to_clear',
          key: 'item1',
          fromJson: (map) => map,
        );

        expect(result, isNull);
      });
    });
  });
}
