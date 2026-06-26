import 'package:flutter_test/flutter_test.dart';
import 'package:ibiapabaapp/core/errors/failures/failures.dart';
import 'package:ibiapabaapp/shared/models/account.dart';
import 'package:ibiapabaapp/shared/models/account_type.dart';
import 'package:ibiapabaapp/features/auth/domain/entities/auth_result.dart';
import 'package:ibiapabaapp/features/auth/domain/repositories/auth_repository.dart';
import 'package:ibiapabaapp/features/auth/presentation/controllers/login_controller.dart';
import 'package:ibiapabaapp/features/auth/presentation/providers/auth_state_provider.dart';
import 'package:ibiapabaapp/features/auth/presentation/states/login_state.dart';
import 'package:logger/logger.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

class MockAuthState extends Mock implements AuthState {}

class MockLogger extends Mock implements Logger {}

void main() {
  late MockAuthRepository mockRepository;
  late MockAuthState mockAuthState;
  late MockLogger mockLogger;
  late LoginController sut;

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
    mockAuthState = MockAuthState();
    mockLogger = MockLogger();
    sut = LoginController(
      repository: mockRepository,
      authState: mockAuthState,
      logger: mockLogger,
    );
  });

  group('LoginController', () {
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
        when(() => mockAuthState.initSession(any())).thenAnswer((_) async {});

        await sut.login(email: testEmail, password: testPassword);

        expect(sut.state, isA<LoginSuccess>());
        verify(() => mockAuthState.initSession(any())).called(1);
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
        when(() => mockAuthState.initSession(any())).thenAnswer((_) async {});

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

        verifyNever(() => mockAuthState.initSession(any()));
      });
    });
  });
}
