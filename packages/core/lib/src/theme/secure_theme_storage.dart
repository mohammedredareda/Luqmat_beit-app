import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'theme_cubit.dart';

/// [ThemePreferenceStorage] backed by secure storage — the theme choice
/// isn't sensitive, but this keeps every persisted user preference behind
/// one storage mechanism, matching [SecureLocaleStorage]'s reasoning.
class SecureThemeStorage implements ThemePreferenceStorage {
  SecureThemeStorage(this._storage);

  static const _key = 'theme_mode';

  final FlutterSecureStorage _storage;

  @override
  Future<ThemeMode?> getThemeMode() async {
    final value = await _storage.read(key: _key);
    return switch (value) {
      'dark' => ThemeMode.dark,
      'light' => ThemeMode.light,
      _ => null,
    };
  }

  @override
  Future<void> saveThemeMode(ThemeMode mode) {
    return _storage.write(key: _key, value: mode == ThemeMode.dark ? 'dark' : 'light');
  }
}
