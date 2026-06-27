import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ibivibe/core/storage/token_storage_impl.dart';
import 'package:ibivibe/core/storage/token_storage_strategy.dart';
import 'package:ibivibe/core/storage/token_response.dart';

class FakeTokenResponse implements TokenResponse {
  @override
  final String accessToken;
  @override
  final String refreshToken;

  FakeTokenResponse({required this.accessToken, required this.refreshToken});
}

void main() {
  const channel = MethodChannel('plugins.it_nomads.com/flutter_secure_storage');
  final tokens = <String, String>{};

  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();

    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        switch (methodCall.method) {
          case 'write':
            final args = methodCall.arguments as Map;
            tokens[args['key'] as String] = args['value'] as String;
            return null;
          case 'read':
            final args = methodCall.arguments as Map;
            return tokens[args['key'] as String];
          case 'delete':
            final args = methodCall.arguments as Map;
            tokens.remove(args['key'] as String);
            return null;
          case 'deleteAll':
            tokens.clear();
            return null;
          default:
            return null;
        }
      },
    );
  });

  tearDownAll(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  group('TokenStorageImpl', () {
    test('should be a singleton', () {
      final instance1 = TokenStorageImpl.instance;
      final instance2 = TokenStorageImpl.instance;
      expect(identical(instance1, instance2), isTrue);
    });

    test('should implement TokenStorageStrategy', () {
      expect(TokenStorageImpl.instance, isA<TokenStorageStrategy>());
    });

    group('token operations', () {
      test('should save tokens', () async {
        final storage = TokenStorageImpl.instance;
        final response = FakeTokenResponse(
          accessToken: 'test-access-token',
          refreshToken: 'test-refresh-token',
        );

        await storage.saveTokens(response);

        expect(tokens['access_token'], 'test-access-token');
        expect(tokens['refresh_token'], 'test-refresh-token');
      });

      test('should get tokens', () async {
        final storage = TokenStorageImpl.instance;

        final access = await storage.getAccessToken();
        final refresh = await storage.getRefreshToken();

        expect(access, 'test-access-token');
        expect(refresh, 'test-refresh-token');
      });

      test('should clear tokens', () async {
        final storage = TokenStorageImpl.instance;

        await storage.clearTokens();

        expect(tokens.containsKey('access_token'), isFalse);
        expect(tokens.containsKey('refresh_token'), isFalse);
      });

      test('should support saveTokens followed by getTokens', () async {
        final storage = TokenStorageImpl.instance;
        await storage.saveTokens(FakeTokenResponse(
          accessToken: 'access-123',
          refreshToken: 'refresh-456',
        ));

        final access = await storage.getAccessToken();
        final refresh = await storage.getRefreshToken();

        expect(access, 'access-123');
        expect(refresh, 'refresh-456');
      });

      test('should return null after clearTokens', () async {
        final storage = TokenStorageImpl.instance;
        await storage.saveTokens(FakeTokenResponse(
          accessToken: 'temp',
          refreshToken: 'temp',
        ));

        await storage.clearTokens();
        final access = await storage.getAccessToken();

        expect(access, isNull);
      });

      test('should overwrite existing tokens', () async {
        final storage = TokenStorageImpl.instance;
        await storage.saveTokens(FakeTokenResponse(
          accessToken: 'old-access',
          refreshToken: 'old-refresh',
        ));

        await storage.saveTokens(FakeTokenResponse(
          accessToken: 'new-access',
          refreshToken: 'new-refresh',
        ));

        final access = await storage.getAccessToken();
        final refresh = await storage.getRefreshToken();

        expect(access, 'new-access');
        expect(refresh, 'new-refresh');
      });
    });
  });
}
