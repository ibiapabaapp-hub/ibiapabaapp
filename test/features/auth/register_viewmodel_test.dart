import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ibivibe/core/errors/failures/failures.dart';
import 'package:ibivibe/core/logger/log_tags.dart';
import 'package:ibivibe/core/logger/logger.dart';
import 'package:ibivibe/core/preferences/user_preferences_state_provider.dart';
import 'package:ibivibe/features/auth/models/auth_result.dart';
import 'package:ibivibe/features/auth/models/check_availability.dart';
import 'package:ibivibe/features/auth/models/register_form_data.dart';
import 'package:ibivibe/features/auth/viewmodels/register_viewmodel.dart';
import 'package:ibivibe/features/auth/providers/auth_providers.dart';
import 'package:ibivibe/features/auth/viewmodels/auth_viewmodel.dart';
import 'package:ibivibe/features/auth/register_state.dart';
import 'package:logger/logger.dart';
import 'package:mocktail/mocktail.dart';
import '../../mocks/mocks.dart';
import '../../factories/model_factories.dart';

class StubAuthViewModel extends AuthViewModel {
  bool initSessionCalled = false;
  AuthResult? lastInitSessionResult;

  @override
  Logger get logger => Logger();

  @override
  LogFeature get feature => LogFeature.auth;

  @override
  AuthData build() => const AuthData();

  @override
  Future<void> initSession(AuthResult result) async {
    initSessionCalled = true;
    lastInitSessionResult = result;
  }
}

void main() {
  late MockAuthRepository mockAuthRepository;
  late MockLogger mockLogger;
  late StubAuthViewModel stubAuthState;
  late ProviderContainer container;

  final mockAuthResult = makeAuthResult();

  const mockCheckAvailabilityEmail = CheckAvailability(
    field: AvailabilityField.email,
    value: 'test@example.com',
    available: true,
  );

  const mockCheckAvailabilitySlug = CheckAvailability(
    field: AvailabilityField.slug,
    value: 'johndoe',
    available: true,
  );

  setUpAll(() {
    registerFallbackValue(mockAuthResult);
    registerFallbackValue(RegisterFormData());
  });

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    mockLogger = MockLogger();
    stubAuthState = StubAuthViewModel();

    container = ProviderContainer(
      overrides: [
        authRepositoryProvider.overrideWithValue(mockAuthRepository),
        authViewModelProvider.overrideWith(() => stubAuthState),
        userPreferencesStateProvider.overrideWith(() => _StubUserPrefsState()),
        loggerProvider.overrideWithValue(mockLogger),
      ],
    );
  });

  tearDown(() {
    container.dispose();
  });

  RegisterViewModel createSut() {
    return container.read(registerViewModelProvider.notifier);
  }

  group('RegisterViewModel', () {
    group('initial state', () {
      test('should start with RegisterStatus.initial', () {
        final sut = createSut();
        expect(sut.state.status, RegisterStatus.initial);
      });

      test('should start with empty form data', () {
        final sut = createSut();
        expect(sut.state.formData.email, '');
        expect(sut.state.formData.name, '');
        expect(sut.state.formData.slug, '');
        expect(sut.state.formData.password, '');
        expect(sut.state.formData.confirmPassword, '');
      });

      test('should start with null availability for all fields', () {
        final sut = createSut();
        expect(sut.state.availability[AvailabilityField.slug]!.available, null);
        expect(sut.state.availability[AvailabilityField.email]!.available, null);
      });

      test('should start with no error message', () {
        final sut = createSut();
        expect(sut.state.errorMessage, null);
      });
    });

    group('setName', () {
      test('should update name in form data', () {
        final sut = createSut();
        sut.setName('John Doe');
        expect(sut.state.formData.name, 'John Doe');
      });
    });

    group('setSlug', () {
      test('should reset slug availability', () {
        final sut = createSut();
        sut.setSlug('johndoe');
        expect(sut.state.availability[AvailabilityField.slug]!.available, null);
        expect(sut.state.availability[AvailabilityField.slug]!.error, null);
        expect(sut.state.availability[AvailabilityField.slug]!.isChecking, false);
      });
    });

    group('setEmail', () {
      test('should update email in form data', () {
        final sut = createSut();
        sut.setEmail('test@example.com');
        expect(sut.state.formData.email, 'test@example.com');
      });

      test('should reset email availability', () {
        final sut = createSut();
        sut.setEmail('test@example.com');
        expect(sut.state.availability[AvailabilityField.email]!.available, null);
        expect(sut.state.availability[AvailabilityField.email]!.error, null);
        expect(sut.state.availability[AvailabilityField.email]!.isChecking, false);
      });
    });

    group('setPassword', () {
      test('should update password in form data', () {
        final sut = createSut();
        sut.setPassword('SecurePass1!');
        expect(sut.state.formData.password, 'SecurePass1!');
      });
    });

    group('setConfirmPassword', () {
      test('should update confirm password in form data', () {
        final sut = createSut();
        sut.setConfirmPassword('SecurePass1!');
        expect(sut.state.formData.confirmPassword, 'SecurePass1!');
      });
    });

    group('checkSlugAvailability', () {
      test('should set available true on success', () async {
        when(
          () => mockAuthRepository.checkAvailability(
            field: AvailabilityField.slug,
            value: 'johndoe',
          ),
        ).thenAnswer((_) async => mockCheckAvailabilitySlug);

        final sut = createSut();
        final result = await sut.checkSlugAvailability('johndoe');

        expect(result, true);
        expect(sut.state.availability[AvailabilityField.slug]!.available, true);
        expect(sut.state.availability[AvailabilityField.slug]!.isChecking, false);
        verify(
          () => mockAuthRepository.checkAvailability(
            field: AvailabilityField.slug,
            value: 'johndoe',
          ),
        ).called(1);
      });

      test('should set available false when slug is taken', () async {
        const takenResult = CheckAvailability(
          field: AvailabilityField.slug,
          value: 'takenslug',
          available: false,
        );
        when(
          () => mockAuthRepository.checkAvailability(
            field: AvailabilityField.slug,
            value: 'takenslug',
          ),
        ).thenAnswer((_) async => takenResult);

        final sut = createSut();
        final result = await sut.checkSlugAvailability('takenslug');

        expect(result, false);
        expect(sut.state.availability[AvailabilityField.slug]!.available, false);
      });

      test('should handle AppFailure on error', () async {
        when(
          () => mockAuthRepository.checkAvailability(
            field: AvailabilityField.slug,
            value: 'johndoe',
          ),
        ).thenThrow(const ServerFailure('Server error'));

        final sut = createSut();
        final result = await sut.checkSlugAvailability('johndoe');

        expect(result, false);
        expect(sut.state.availability[AvailabilityField.slug]!.available, false);
        expect(sut.state.availability[AvailabilityField.slug]!.error, 'Server error');
      });

      test('should handle unexpected error', () async {
        when(
          () => mockAuthRepository.checkAvailability(
            field: AvailabilityField.slug,
            value: 'johndoe',
          ),
        ).thenThrow(Exception('unexpected'));

        final sut = createSut();
        final result = await sut.checkSlugAvailability('johndoe');

        expect(result, false);
        expect(sut.state.availability[AvailabilityField.slug]!.available, false);
        expect(sut.state.availability[AvailabilityField.slug]!.error, 'Erro inesperado');
      });
    });

    group('checkEmailAvailability', () {
      test('should set available true on success', () async {
        when(
          () => mockAuthRepository.checkAvailability(
            field: AvailabilityField.email,
            value: 'test@example.com',
          ),
        ).thenAnswer((_) async => mockCheckAvailabilityEmail);

        final sut = createSut();
        final result = await sut.checkEmailAvailability('test@example.com');

        expect(result, true);
        expect(sut.state.availability[AvailabilityField.email]!.available, true);
        verify(
          () => mockAuthRepository.checkAvailability(
            field: AvailabilityField.email,
            value: 'test@example.com',
          ),
        ).called(1);
      });

      test('should handle AppFailure on error', () async {
        when(
          () => mockAuthRepository.checkAvailability(
            field: AvailabilityField.email,
            value: 'test@example.com',
          ),
        ).thenThrow(const ServerFailure('Server error'));

        final sut = createSut();
        final result = await sut.checkEmailAvailability('test@example.com');

        expect(result, false);
        expect(sut.state.availability[AvailabilityField.email]!.available, false);
        expect(sut.state.availability[AvailabilityField.email]!.error, 'Server error');
      });
    });

    group('submit', () {
      test('should emit success on successful registration', () async {
        when(
          () => mockAuthRepository.register(
            registerFormData: any(named: 'registerFormData'),
          ),
        ).thenAnswer((_) async => mockAuthResult);

        final sut = createSut();
        sut.setName('John Doe');
        sut.setEmail('test@example.com');
        sut.setPassword('SecurePass1!');

        await sut.submit();

        expect(sut.state.status, RegisterStatus.success);
        expect(stubAuthState.initSessionCalled, true);
      });

      test('should emit error on registration failure', () async {
        when(
          () => mockAuthRepository.register(
            registerFormData: any(named: 'registerFormData'),
          ),
        ).thenThrow(const ServerFailure('Email already exists'));

        final sut = createSut();
        await sut.submit();

        expect(sut.state.status, RegisterStatus.error);
        expect(sut.state.errorMessage, 'Email already exists');
      });

      test('should handle unexpected error on submit', () async {
        when(
          () => mockAuthRepository.register(
            registerFormData: any(named: 'registerFormData'),
          ),
        ).thenThrow(Exception('unexpected'));

        final sut = createSut();
        await sut.submit();

        expect(sut.state.status, RegisterStatus.error);
        expect(sut.state.errorMessage, 'Erro inesperado');
      });

      test('should not call initSession when registration fails', () async {
        when(
          () => mockAuthRepository.register(
            registerFormData: any(named: 'registerFormData'),
          ),
        ).thenThrow(const ServerFailure('error'));

        final sut = createSut();
        await sut.submit();

        expect(stubAuthState.initSessionCalled, false);
      });

      test('should pass form data to repository', () async {
        when(
          () => mockAuthRepository.register(
            registerFormData: any(named: 'registerFormData'),
          ),
        ).thenAnswer((_) async => mockAuthResult);

        final sut = createSut();
        sut.setName('Jane Doe');
        sut.setEmail('jane@example.com');
        sut.setPassword('Password1!');

        await sut.submit();

        final captured = verify(
          () => mockAuthRepository.register(
            registerFormData: captureAny(named: 'registerFormData'),
          ),
        ).captured.single;

        expect(captured.name, 'Jane Doe');
        expect(captured.email, 'jane@example.com');
        expect(captured.password, 'Password1!');
      });
    });

    group('helpers', () {
      test('isSlugAvailable should return null initially', () {
        final sut = createSut();
        expect(sut.isSlugAvailable(), null);
      });

      test('isSlugChecking should return false initially', () {
        final sut = createSut();
        expect(sut.isSlugChecking(), false);
      });

      test('isEmailAvailable should return null initially', () {
        final sut = createSut();
        expect(sut.isEmailAvailable(), null);
      });

      test('isEmailChecking should return false initially', () {
        final sut = createSut();
        expect(sut.isEmailChecking(), false);
      });

      test('getError should return null initially', () {
        final sut = createSut();
        expect(sut.getError(AvailabilityField.slug), null);
        expect(sut.getError(AvailabilityField.email), null);
      });
    });
  });
}

class _StubUserPrefsState extends UserPreferencesState {
  _StubUserPrefsState();

  @override
  Future<void> setNeedsOnboarding(bool value) async {}
}
