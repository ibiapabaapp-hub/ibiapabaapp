import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ibiapabaapp/core/errors/exceptions/exceptions.dart';
import 'package:ibiapabaapp/core/storage/token_storage_strategy.dart';
import 'package:ibiapabaapp/features/auth/data/exceptions/auth_exceptions.dart';
import 'package:ibiapabaapp/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:ibiapabaapp/features/auth/domain/entities/auth_result.dart';
import 'package:ibiapabaapp/features/auth/domain/entities/check_availability.dart';
import 'package:ibiapabaapp/features/auth/domain/entities/complete_google_registration.dart';
import 'package:ibiapabaapp/features/auth/domain/entities/google_auth_result.dart';
import 'package:ibiapabaapp/features/auth/domain/entities/register_form_data.dart';
import 'package:ibiapabaapp/shared/models/account_type.dart';
import 'package:ibiapabaapp/shared/models/gender.dart';
import 'package:mocktail/mocktail.dart';

class MockDio extends Mock implements Dio {}

class MockTokenStorage extends Mock implements TokenStorageStrategy {}

class MockResponse<T> extends Mock implements Response<T> {}

void main() {
  late MockDio mockDio;
  late MockTokenStorage mockStorage;
  late AuthRepositoryImpl sut;

  setUpAll(() {
    registerFallbackValue(Options());
  });

  setUp(() {
    mockDio = MockDio();
    mockStorage = MockTokenStorage();
    sut = AuthRepositoryImpl(mockDio, mockStorage);
  });

  final accountJson = {
    'id': '1',
    'email': 'test@example.com',
    'name': 'Test User',
    'active': true,
    'is_verified': true,
    'created_at': '2025-01-01T00:00:00.000Z',
    'updated_at': '2025-01-01T00:00:00.000Z',
    'slug': 'test-user',
    'display_name': 'Test User',
    'type': 'personal',
  };

  final authResultJson = {
    'access_token': 'test_access_token',
    'refresh_token': 'test_refresh_token',
    'account': accountJson,
  };

  Response<T> makeResponse<T>(T data, {int statusCode = 200}) {
    final response = MockResponse<T>();
    when(() => response.data).thenReturn(data);
    when(() => response.statusCode).thenReturn(statusCode);
    return response;
  }

  group('login', () {
    test('should return AuthResult on success', () async {
      when(
        () => mockDio.post(
          '/auth/login',
          data: {'email': 'test@example.com', 'password': 'password123'},
        ),
      ).thenAnswer((_) async => makeResponse(authResultJson));

      final result = await sut.login(
        email: 'test@example.com',
        password: 'password123',
      );

      expect(result, isA<AuthResult>());
      expect(result.accessToken, 'test_access_token');
      expect(result.refreshToken, 'test_refresh_token');
      expect(result.account.email, 'test@example.com');
      verify(
        () => mockDio.post(
          '/auth/login',
          data: {'email': 'test@example.com', 'password': 'password123'},
        ),
      ).called(1);
    });

    test('should throw mapped exception on DioException', () async {
      when(
        () => mockDio.post(
          '/auth/login',
          data: {'email': 'test@example.com', 'password': 'wrong'},
        ),
      ).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: '/auth/login'),
          response: Response(
            requestOptions: RequestOptions(path: '/auth/login'),
            statusCode: 401,
            data: {'message': 'Invalid credentials', 'code': 'wrong_password'},
          ),
        ),
      );

      expect(
        () => sut.login(email: 'test@example.com', password: 'wrong'),
        throwsA(isA<WrongPasswordException>()),
      );
    });

    test('should throw NetworkException when no response', () async {
      when(
        () => mockDio.post(
          '/auth/login',
          data: {'email': 'test@example.com', 'password': 'password'},
        ),
      ).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: '/auth/login'),
          type: DioExceptionType.connectionTimeout,
        ),
      );

      expect(
        () => sut.login(email: 'test@example.com', password: 'password'),
        throwsA(isA<NetworkException>()),
      );
    });
  });

  group('register', () {
    final formData = RegisterFormData(
      name: 'Test User',
      slug: 'test-user',
      email: 'test@example.com',
      password: 'Password1!',
      confirmPassword: 'Password1!',
      type: AccountType.personal,
    );

    test('should return AuthResult on success', () async {
      when(
        () => mockDio.post('/auth/register', data: formData.toJson()),
      ).thenAnswer((_) async => makeResponse(authResultJson));

      final result = await sut.register(registerFormData: formData);

      expect(result, isA<AuthResult>());
      expect(result.accessToken, 'test_access_token');
      verify(
        () => mockDio.post('/auth/register', data: formData.toJson()),
      ).called(1);
    });

    test('should throw mapped exception on DioException', () async {
      when(
        () => mockDio.post('/auth/register', data: formData.toJson()),
      ).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: '/auth/register'),
          response: Response(
            requestOptions: RequestOptions(path: '/auth/register'),
            statusCode: 400,
            data: {
              'message': 'Email already registered',
              'code': 'email_already_registered',
            },
          ),
        ),
      );

      expect(
        () => sut.register(registerFormData: formData),
        throwsA(isA<EmailAlreadyRegisteredException>()),
      );
    });

    test('should throw ServerException on 500 error', () async {
      when(
        () => mockDio.post('/auth/register', data: formData.toJson()),
      ).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: '/auth/register'),
          response: Response(
            requestOptions: RequestOptions(path: '/auth/register'),
            statusCode: 500,
            data: {'message': 'Internal server error'},
          ),
        ),
      );

      expect(
        () => sut.register(registerFormData: formData),
        throwsA(isA<ServerException>()),
      );
    });
  });

  group('checkAvailability', () {
    final availabilityJson = {
      'field': 'email',
      'value': 'test@example.com',
      'available': true,
    };

    test('should return CheckAvailability on success', () async {
      when(
        () => mockDio.get(
          '/auth/check-unique',
          queryParameters: {'field': 'email', 'value': 'test@example.com'},
        ),
      ).thenAnswer((_) async => makeResponse(availabilityJson));

      final result = await sut.checkAvailability(
        field: AvailabilityField.email,
        value: 'test@example.com',
      );

      expect(result, isA<CheckAvailability>());
      expect(result.available, true);
      expect(result.field, AvailabilityField.email);
      expect(result.value, 'test@example.com');
    });

    test('should return available false when taken', () async {
      when(
        () => mockDio.get(
          '/auth/check-unique',
          queryParameters: {'field': 'slug', 'value': 'taken-slug'},
        ),
      ).thenAnswer(
        (_) async => makeResponse({
          'field': 'slug',
          'value': 'taken-slug',
          'available': false,
        }),
      );

      final result = await sut.checkAvailability(
        field: AvailabilityField.slug,
        value: 'taken-slug',
      );

      expect(result.available, false);
    });

    test('should handle phone_number field', () async {
      when(
        () => mockDio.get(
          '/auth/check-unique',
          queryParameters: {'field': 'phone_number', 'value': '12345'},
        ),
      ).thenAnswer(
        (_) async => makeResponse({
          'field': 'phone_number',
          'value': '12345',
          'available': true,
        }),
      );

      final result = await sut.checkAvailability(
        field: AvailabilityField.phoneNumber,
        value: '12345',
      );

      expect(result.available, true);
      expect(result.field, AvailabilityField.phoneNumber);
    });

    test('should throw on DioException', () async {
      when(
        () => mockDio.get(
          '/auth/check-unique',
          queryParameters: {'field': 'email', 'value': 'test@example.com'},
        ),
      ).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: '/auth/check-unique'),
          response: Response(
            requestOptions: RequestOptions(path: '/auth/check-unique'),
            statusCode: 500,
            data: {'message': 'Server error'},
          ),
        ),
      );

      expect(
        () => sut.checkAvailability(
          field: AvailabilityField.email,
          value: 'test@example.com',
        ),
        throwsA(isA<ServerException>()),
      );
    });
  });

  group('getMe', () {
    test('should return Account on success', () async {
      when(
        () => mockDio.get('/auth/me'),
      ).thenAnswer((_) async => makeResponse(accountJson));

      final result = await sut.getMe();

      expect(result.id, '1');
      expect(result.email, 'test@example.com');
      expect(result.name, 'Test User');
      verify(() => mockDio.get('/auth/me')).called(1);
    });

    test('should throw on DioException', () async {
      when(
        () => mockDio.get('/auth/me'),
      ).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: '/auth/me'),
          response: Response(
            requestOptions: RequestOptions(path: '/auth/me'),
            statusCode: 401,
            data: {'message': 'Unauthorized', 'code': 'invalid_token'},
          ),
        ),
      );

      expect(() => sut.getMe(), throwsA(isA<InvalidTokenException>()));
    });

    test('should throw NetworkException when no response', () async {
      when(
        () => mockDio.get('/auth/me'),
      ).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: '/auth/me'),
          type: DioExceptionType.connectionTimeout,
        ),
      );

      expect(() => sut.getMe(), throwsA(isA<NetworkException>()));
    });
  });

  group('refreshTokens', () {
    final refreshResultJson = {
      'access_token': 'new_access_token',
      'refresh_token': 'new_refresh_token',
      'account': accountJson,
    };

    test('should return new AuthResult with tokens', () async {
      when(() => mockStorage.getRefreshToken())
          .thenAnswer((_) async => 'old_refresh_token');
      when(
        () => mockDio.post(
          '/auth/refresh',
          options: any(named: 'options'),
        ),
      ).thenAnswer((_) async => makeResponse(refreshResultJson));

      final result = await sut.refreshTokens();

      expect(result.accessToken, 'new_access_token');
      expect(result.refreshToken, 'new_refresh_token');
      verify(() => mockStorage.getRefreshToken()).called(1);
      verify(
        () => mockDio.post(
          '/auth/refresh',
          options: any(named: 'options'),
        ),
      ).called(1);
    });

    test('should throw on DioException', () async {
      when(() => mockStorage.getRefreshToken())
          .thenAnswer((_) async => 'expired_token');
      when(
        () => mockDio.post(
          '/auth/refresh',
          options: any(named: 'options'),
        ),
      ).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: '/auth/refresh'),
          response: Response(
            requestOptions: RequestOptions(path: '/auth/refresh'),
            statusCode: 401,
            data: {'message': 'Invalid token', 'code': 'invalid_token'},
          ),
        ),
      );

      expect(() => sut.refreshTokens(), throwsA(isA<InvalidTokenException>()));
    });
  });

  group('loginWithGoogle', () {
    final googleResultJson = {
      'is_new_user': false,
      'account': accountJson,
      'access_token': 'google_access_token',
      'refresh_token': 'google_refresh_token',
    };

    test('should return GoogleAuthResult for existing user', () async {
      when(
        () => mockDio.post(
          '/auth/google',
          data: {'id_token': 'google_id_token'},
        ),
      ).thenAnswer((_) async => makeResponse(googleResultJson));

      final result = await sut.loginWithGoogle(idToken: 'google_id_token');

      expect(result, isA<GoogleAuthResult>());
      expect(result.isNewUser, false);
      expect(result.accessToken, 'google_access_token');
      expect(result.refreshToken, 'google_refresh_token');
      expect(result.account, isNotNull);
    });

    test('should return GoogleAuthResult for new user', () async {
      final newUserResultJson = {
        'is_new_user': true,
        'temp_token': 'temp_token_123',
      };

      when(
        () => mockDio.post(
          '/auth/google',
          data: {'id_token': 'google_id_token'},
        ),
      ).thenAnswer((_) async => makeResponse(newUserResultJson));

      final result = await sut.loginWithGoogle(idToken: 'google_id_token');

      expect(result.isNewUser, true);
      expect(result.tempToken, 'temp_token_123');
      expect(result.account, null);
    });

    test('should throw on DioException', () async {
      when(
        () => mockDio.post(
          '/auth/google',
          data: {'id_token': 'bad_token'},
        ),
      ).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: '/auth/google'),
          response: Response(
            requestOptions: RequestOptions(path: '/auth/google'),
            statusCode: 400,
            data: {'message': 'Invalid Google token'},
          ),
        ),
      );

      expect(
        () => sut.loginWithGoogle(idToken: 'bad_token'),
        throwsA(isA<BadRequestException>()),
      );
    });
  });

  group('completeGoogleRegistration', () {
    final completeResultJson = {
      'access_token': 'completed_access_token',
      'refresh_token': 'completed_refresh_token',
      'account': accountJson,
    };

    test('should return CompleteGoogleRegistrationResponse on success', () async {
      when(
        () => mockDio.post(
          '/auth/google/complete',
          data: {
            'temp_token': 'temp_token_123',
            'slug': 'new-user',
            'type': 'personal',
            'gender': null,
          },
        ),
      ).thenAnswer((_) async => makeResponse(completeResultJson));

      final result = await sut.completeGoogleRegistration(
        tempToken: 'temp_token_123',
        slug: 'new-user',
        type: AccountType.personal,
      );

      expect(result, isA<CompleteGoogleRegistrationResponse>());
      expect(result.accessToken, 'completed_access_token');
      expect(result.refreshToken, 'completed_refresh_token');
      expect(result.account.email, 'test@example.com');
    });

    test('should include gender when provided', () async {
      when(
        () => mockDio.post(
          '/auth/google/complete',
          data: {
            'temp_token': 'temp_token_123',
            'slug': 'new-user',
            'type': 'personal',
            'gender': 'female',
          },
        ),
      ).thenAnswer((_) async => makeResponse(completeResultJson));

      final result = await sut.completeGoogleRegistration(
        tempToken: 'temp_token_123',
        slug: 'new-user',
        type: AccountType.personal,
        gender: Gender.female,
      );

      expect(result.accessToken, 'completed_access_token');
      verify(
        () => mockDio.post(
          '/auth/google/complete',
          data: {
            'temp_token': 'temp_token_123',
            'slug': 'new-user',
            'type': 'personal',
            'gender': 'female',
          },
        ),
      ).called(1);
    });

    test('should handle business account type', () async {
      when(
        () => mockDio.post(
          '/auth/google/complete',
          data: {
            'temp_token': 'temp_token_123',
            'slug': 'new-business',
            'type': 'business',
            'gender': null,
          },
        ),
      ).thenAnswer((_) async => makeResponse(completeResultJson));

      final result = await sut.completeGoogleRegistration(
        tempToken: 'temp_token_123',
        slug: 'new-business',
        type: AccountType.business,
      );

      expect(result.accessToken, 'completed_access_token');
    });

    test('should throw on DioException', () async {
      when(
        () => mockDio.post(
          '/auth/google/complete',
          data: {
            'temp_token': 'bad_token',
            'slug': 'new-user',
            'type': 'personal',
            'gender': null,
          },
        ),
      ).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: '/auth/google/complete'),
          response: Response(
            requestOptions: RequestOptions(path: '/auth/google/complete'),
            statusCode: 400,
            data: {'message': 'Invalid token'},
          ),
        ),
      );

      expect(
        () => sut.completeGoogleRegistration(
          tempToken: 'bad_token',
          slug: 'new-user',
          type: AccountType.personal,
        ),
        throwsA(isA<BadRequestException>()),
      );
    });
  });
}
