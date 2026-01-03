import 'package:encrypt/encrypt.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:result_dart/result_dart.dart';
import 'package:marshaller/data/exceptions/exceptions.dart';

class SecureLocalStorage {
  final FlutterSecureStorage _storage;
  static const _keyStorageKey = 'encryption_key';
  SecureLocalStorage(this._storage);
  Future<Encrypter> _getEncrypter() async {
    String? keyString = await _storage.read(key: _keyStorageKey);
    if (keyString == null) {
      final key = Key.fromSecureRandom(32);
      await _storage.write(key: _keyStorageKey, value: key.base64);
      keyString = key.base64;
    }
    final key = Key.fromBase64(keyString);
    final encrypter = Encrypter(AES(key, mode: AESMode.cbc));
    return encrypter;
  }

  Future<IV> _generateIV() async {
    return IV.fromSecureRandom(16);
  }

  AsyncResult<String> save(String key, String value) async {
    try {
      final encrypter = await _getEncrypter();
      final iv = await _generateIV();
      final encrypted = encrypter.encrypt(value, iv: iv);
      await _storage.write(key: key, value: '${iv.base64}:${encrypted.base64}');
      return Success(value);
    } catch (e, s) {
      return Failure(LocalStorageException(e.toString(), s));
    }
  }

  AsyncResult<String> get(String key) async {
    try {
      final encrypter = await _getEncrypter();
      final storedValue = await _storage.read(key: key);
      if (storedValue == null) {
        return Failure(LocalStorageNotFoundException('Key not found'));
      }
      final parts = storedValue.split(':');
      if (parts.length != 2) {
        return Failure(
          LocalStorageException('Invalid encrypted format', StackTrace.current),
        );
      }
      final iv = IV.fromBase64(parts[0]);
      final encrypted = Encrypted.fromBase64(parts[1]);
      final decrypted = encrypter.decrypt(encrypted, iv: iv);
      return Success(decrypted);
    } catch (e, s) {
      return Failure(LocalStorageException(e.toString(), s));
    }
  }

  AsyncResult<Unit> delete(String key) async {
    try {
      await _storage.delete(key: key);
      return Success(unit);
    } catch (e, s) {
      return Failure(LocalStorageException(e.toString(), s));
    }
  }

  AsyncResult<Unit> clearAll() async {
    try {
      await _storage.deleteAll();
      return Success(unit);
    } catch (e, s) {
      return Failure(LocalStorageException(e.toString(), s));
    }
  }
}
