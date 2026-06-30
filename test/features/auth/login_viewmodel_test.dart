import 'package:flutter_test/flutter_test.dart';
import 'package:ibivibe/core/errors/failures/failures.dart';
import 'package:ibivibe/shared/models/account.dart';
import 'package:ibivibe/shared/models/account_type.dart';
import 'package:ibivibe/features/auth/models/auth_result.dart';
import 'package:ibivibe/features/auth/auth_repository.dart';
import 'package:ibivibe/features/auth/viewmodels/login_viewmodel.dart';
import 'package:ibivibe/features/auth/viewmodels/auth_viewmodel.dart';
import 'package:ibivibe/features/auth/login_state.dart';
import 'package:logger/logger.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

class MockAuthViewModel extends Mock implements AuthViewModel {}

class MockLogger extends Mock implements Logger {}

void main() {
  late MockAuthRepository mockRepository;
  late MockAuthViewModel mockAuthViewModel;
  late MockLogger mockLogger;
  late LoginViewModel sut;

  final mockAuthResult = AuthResult(
    accessToken: 'test_access_token',
    refreshToken: 'test_refresh_token',
    account: Account(
      id: '1',
      email: 'test@example.com',
      name: 'Test User',
      active: true,
      isVerified: true,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      slug: 'test-user',
      displayName: 'Test User',
      type: AccountType.personal,
    ),
  );

  setUpAll(() {
    registerFallbackValue(mockAuthResult);
  });

  setUp(() {
    mockRepository = MockAuthRepository();
    mockAuthViewModel = MockAuthViewModel();
    mockLogger = MockLogger();
    sut = LoginViewModel(
      repository: mockRepository,
      authState: mockAuthViewModel,
      logger: mockLogger,
    );
  });

  group('LoginViewModel', () {
    group('initial state', () {
      test('should start with LoginInitial state', () {
        expect(sut.state, isA<LoginInitial>());
      });

      test('should start with empty email', () {
        expect(sut.email, equals(''));
      });
    });

    group('setEmail', () {
      test('should update email value', () {
        const testEmail = 'test@example.com';
        sut.setEmail(testEmail);
        expect(sut.email, equals(testEmail));
      });
    });

    group('checkEmailAvailability', () {
      test('should return false', () async {
        final result = await sut.checkEmailAvailability('test@example.com');
        expect(result, false);
      });
    });

    group('isEmailAvailable', () {
      test('should return null', () {
        expect(sut.isEmailAvailable(), null);
      });
    });

    group('isEmailChecking', () {
      test('should return false', () {
        expect(sut.isEmailChecking(), false);
      });
    });

    group('login', () {
      const testEmail = 'test@example.com';
      const testPassword = 'password123';

      test('should emit LoginSuccess when login succeeds', () async {
        when(
          () => mockRepository.login(
            email: any(named: 'email'),
            password: any(named: 'password'),
          ),
        ).thenAnswer((_) async => mockAuthResult);
        when(() => mockAuthViewModel.initSession(any())).thenAnswer((_) async {});

        await sut.login(email: testEmail, password: testPassword);

        expect(sut.state, isA<LoginSuccess>());
        verify(() => mockAuthViewModel.initSession(any())).called(1);
      });

      test('should emit LoginError when login fails', () async {
        when(
          () => mockRepository.login(
            email: any(named: 'email'),
            password: any(named: 'password'),
          ),
        ).thenThrow(const ServerFailure('Invalid credentials'));

        await sut.login(email: testEmail, password: testPassword);

        expect(sut.state, isA<LoginError>());
        expect(
          (sut.state as LoginError).message,
          contains('Invalid credentials'),
        );
      });

      test('should call login with trimmed email', () async {
        const emailWithSpaces = '  test@example.com  ';
        when(
          () => mockRepository.login(
            email: any(named: 'email'),
            password: any(named: 'password'),
          ),
        ).thenAnswer((_) async => mockAuthResult);
        when(() => mockAuthViewModel.initSession(any())).thenAnswer((_) async {});

        await sut.login(email: emailWithSpaces, password: testPassword);

        verify(
          () => mockRepository.login(
            email: 'test@example.com',
            password: testPassword,
          ),
        ).called(1);
      });

      test('should not call initSession when login fails', () async {
        when(
          () => mockRepository.login(
            email: any(named: 'email'),
            password: any(named: 'password'),
          ),
        ).thenThrow(const ServerFailure('error'));

        await sut.login(email: testEmail, password: testPassword);

        verifyNever(() => mockAuthViewModel.initSession(any()));
      });
    });
  });
}
