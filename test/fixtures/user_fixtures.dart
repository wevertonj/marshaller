import 'package:marshaller/domain/entities/user.dart';

class UserFixtures {
  static final testUser = LoggedUser(
    id: 1,
    name: 'Test User',
    email: 'test@example.com',
    createdAt: DateTime(2024, 1, 1),
  );

  static const testTokens = UserTokens(
    accessToken: 'test_access_token',
    refreshToken: 'test_refresh_token',
    expiresIn: '3600',
  );

  static const notLoggedUser = NotLoggedUser();

  static Map<String, dynamic> get loggedUserJson => {
    'id': 1,
    'name': 'Test User',
    'email': 'test@example.com',
    'createdAt': '2024-01-01T00:00:00.000',
  };

  static Map<String, dynamic> get tokensJson => {
    'accessToken': 'test_access_token',
    'refreshToken': 'test_refresh_token',
    'expiresIn': '3600',
  };
}
