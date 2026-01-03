import 'package:equatable/equatable.dart';

sealed class User extends Equatable {
  const User();
  factory User.fromJson(Map<String, dynamic> json) {
    if (json.containsKey('accessToken')) {
      return UserTokens.fromJson(json);
    } else if (json['id'] == null) {
      return const NotLoggedUser();
    } else {
      return LoggedUser.fromJson(json);
    }
  }
}

class NotLoggedUser extends User {
  const NotLoggedUser();
  @override
  List<Object?> get props => [];
}

class LoggedUser extends User {
  final int id;
  final String name;
  final String email;
  final DateTime? birthDate;
  final String? picture;
  final DateTime createdAt;
  final DateTime? updatedAt;
  const LoggedUser({
    required this.id,
    required this.name,
    required this.email,
    this.birthDate,
    this.picture,
    required this.createdAt,
    this.updatedAt,
  });
  factory LoggedUser.fromJson(Map<String, dynamic> json) {
    return LoggedUser(
      id: json['id'] as int,
      name: json['name'] as String,
      email: json['email'] as String,
      birthDate: json['birthDate'] != null
          ? DateTime.parse(json['birthDate'] as String)
          : null,
      picture: json['picture'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : null,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'birthDate': birthDate?.toIso8601String(),
      'picture': picture,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  @override
  List<Object?> get props => [
    id,
    name,
    email,
    birthDate,
    picture,
    createdAt,
    updatedAt,
  ];
}

class UserTokens extends User {
  final String accessToken;
  final String refreshToken;
  final String expiresIn;
  final String? sessionId;
  final int? biometricSessionId;
  final bool? hasBiometricEnabled;
  const UserTokens({
    required this.accessToken,
    required this.refreshToken,
    required this.expiresIn,
    this.sessionId,
    this.biometricSessionId,
    this.hasBiometricEnabled,
  });
  factory UserTokens.fromJson(Map<String, dynamic> json) {
    return UserTokens(
      accessToken: json['accessToken'] as String,
      refreshToken: json['refreshToken'] as String,
      expiresIn: json['expiresIn'] as String,
      sessionId: json['sessionId'] as String?,
      biometricSessionId: json['biometricSessionId'] as int?,
      hasBiometricEnabled: json['hasBiometricEnabled'] as bool?,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'accessToken': accessToken,
      'refreshToken': refreshToken,
      'expiresIn': expiresIn,
      'sessionId': sessionId,
      'biometricSessionId': biometricSessionId,
      'hasBiometricEnabled': hasBiometricEnabled,
    };
  }

  @override
  List<Object?> get props => [
    accessToken,
    refreshToken,
    expiresIn,
    sessionId,
    biometricSessionId,
    hasBiometricEnabled,
  ];
}
