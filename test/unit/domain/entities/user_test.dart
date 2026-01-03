import 'package:flutter_test/flutter_test.dart';
import 'package:marshaller/domain/entities/user.dart';

import '../../../fixtures/user_fixtures.dart';

void main() {
  group('User', () {
    group('LoggedUser', () {
      test('should be equal when all properties match', () {
        final user1 = LoggedUser(
          id: 1,
          name: 'Test',
          email: 'test@example.com',
          createdAt: DateTime(2024, 1, 1),
        );
        final user2 = LoggedUser(
          id: 1,
          name: 'Test',
          email: 'test@example.com',
          createdAt: DateTime(2024, 1, 1),
        );

        expect(user1, equals(user2));
      });

      test('should not be equal when id differs', () {
        final user1 = LoggedUser(
          id: 1,
          name: 'Test',
          email: 'test@example.com',
          createdAt: DateTime(2024, 1, 1),
        );
        final user2 = LoggedUser(
          id: 2,
          name: 'Test',
          email: 'test@example.com',
          createdAt: DateTime(2024, 1, 1),
        );

        expect(user1, isNot(equals(user2)));
      });

      test('should create from JSON correctly', () {
        final user = LoggedUser.fromJson(UserFixtures.loggedUserJson);

        expect(user.id, 1);
        expect(user.name, 'Test User');
        expect(user.email, 'test@example.com');
      });

      test('should convert to JSON correctly', () {
        final json = UserFixtures.testUser.toJson();

        expect(json['id'], 1);
        expect(json['name'], 'Test User');
        expect(json['email'], 'test@example.com');
      });
    });

    group('UserTokens', () {
      test('should be equal when all properties match', () {
        const tokens1 = UserTokens(
          accessToken: 'token',
          refreshToken: 'refresh',
          expiresIn: '3600',
        );
        const tokens2 = UserTokens(
          accessToken: 'token',
          refreshToken: 'refresh',
          expiresIn: '3600',
        );

        expect(tokens1, equals(tokens2));
      });

      test('should create from JSON correctly', () {
        final tokens = UserTokens.fromJson(UserFixtures.tokensJson);

        expect(tokens.accessToken, 'test_access_token');
        expect(tokens.refreshToken, 'test_refresh_token');
        expect(tokens.expiresIn, '3600');
      });
    });

    group('NotLoggedUser', () {
      test('should be equal to another NotLoggedUser', () {
        const user1 = NotLoggedUser();
        const user2 = NotLoggedUser();

        expect(user1, equals(user2));
      });
    });

    group('User.fromJson', () {
      test('should return LoggedUser when json has id', () {
        final user = User.fromJson(UserFixtures.loggedUserJson);

        expect(user, isA<LoggedUser>());
      });

      test('should return UserTokens when json has accessToken', () {
        final user = User.fromJson(UserFixtures.tokensJson);

        expect(user, isA<UserTokens>());
      });
    });
  });
}
