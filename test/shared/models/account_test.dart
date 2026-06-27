import 'package:flutter_test/flutter_test.dart';
import 'package:ibiapabaapp/shared/models/account.dart';
import 'package:ibiapabaapp/shared/models/account_type.dart';
import 'package:ibiapabaapp/shared/models/gender.dart';

Account _createAccount({
  String id = '1',
  String email = 'test@test.com',
  String name = 'Test',
  String slug = 'test',
  String displayName = 'Test User',
  AccountType type = AccountType.personal,
}) {
  return Account(
    id: id,
    email: email,
    name: name,
    active: true,
    isVerified: true,
    createdAt: DateTime(2025),
    updatedAt: DateTime(2025),
    slug: slug,
    displayName: displayName,
    type: type,
  );
}

void main() {
  group('Account', () {
    group('constructor', () {
      test('should create account with required fields', () {
        final account = _createAccount();

        expect(account.id, '1');
        expect(account.email, 'test@test.com');
        expect(account.name, 'Test');
        expect(account.active, isTrue);
        expect(account.isVerified, isTrue);
        expect(account.slug, 'test');
        expect(account.displayName, 'Test User');
        expect(account.type, AccountType.personal);
      });

      test('should allow null optional fields', () {
        final account = _createAccount();

        expect(account.phoneNumber, isNull);
        expect(account.bio, isNull);
        expect(account.avatarUrl, isNull);
        expect(account.interests, isNull);
        expect(account.business, isNull);
        expect(account.gender, isNull);
      });

      test('should accept optional fields', () {
        final account = Account(
          id: '1',
          email: 'test@test.com',
          name: 'Test',
          active: true,
          isVerified: true,
          createdAt: DateTime(2025),
          updatedAt: DateTime(2025),
          slug: 'test',
          displayName: 'Test',
          type: AccountType.business,
          phoneNumber: '+5511999999999',
          bio: 'A bio',
          avatarUrl: 'https://example.com/avatar.png',
          gender: Gender.male,
        );

        expect(account.phoneNumber, '+5511999999999');
        expect(account.bio, 'A bio');
        expect(account.avatarUrl, 'https://example.com/avatar.png');
        expect(account.gender, Gender.male);
      });
    });

    group('equality', () {
      test('same instance should be equal to itself', () {
        final account = _createAccount();
        expect(account, equals(account));
      });

      test('different instances with same fields should not be equal (no Equatable)', () {
        final a = _createAccount();
        final b = _createAccount();
        expect(a, isNot(equals(b)));
      });

      test('different instances should have different hashCode', () {
        final a = _createAccount();
        final b = _createAccount();
        expect(a.hashCode, isNot(equals(b.hashCode)));
      });

      test('should not be equal when id differs', () {
        final a = _createAccount(id: '1');
        final b = _createAccount(id: '2');
        expect(a, isNot(equals(b)));
      });

      test('should not be equal when email differs', () {
        final a = _createAccount(email: 'a@test.com');
        final b = _createAccount(email: 'b@test.com');
        expect(a, isNot(equals(b)));
      });

      test('should not be equal when name differs', () {
        final a = _createAccount(name: 'Alice');
        final b = _createAccount(name: 'Bob');
        expect(a, isNot(equals(b)));
      });
    });
  });
}
