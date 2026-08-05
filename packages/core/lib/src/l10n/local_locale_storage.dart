import 'dart:ui';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'locale_cubit.dart';

/// [LocalePreferenceStorage] backed by secure storage — the locale choice
/// isn't sensitive, but this keeps every persisted user preference behind
/// one storage mechanism instead of introducing a second one just for this.
class SecureLocaleStorage implements LocalePreferenceStorage {
  SecureLocaleStorage(this._storage);

  static const _key = 'locale_language_code';

  final FlutterSecureStorage _storage;

  @override
  Future<Locale?> getLocale() async {
    final code = await _storage.read(key: _key);
    if (code == null || code.isEmpty) return null;
    return Locale(code);
  }

  @override
  Future<void> saveLocale(Locale locale) {
    return _storage.write(key: _key, value: locale.languageCode);
  }
}
