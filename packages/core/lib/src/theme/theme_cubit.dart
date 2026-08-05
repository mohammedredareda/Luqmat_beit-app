import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Persists and restores the user's chosen theme mode.
abstract class ThemePreferenceStorage {
  Future<ThemeMode?> getThemeMode();
  Future<void> saveThemeMode(ThemeMode mode);
}

/// Runtime-switchable light/dark mode — independent of the device's
/// system brightness. Light is the default.
class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit(this._storage) : super(ThemeMode.light);

  final ThemePreferenceStorage _storage;

  Future<void> loadSavedThemeMode() async {
    final saved = await _storage.getThemeMode();
    emit(saved ?? ThemeMode.light);
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    await _storage.saveThemeMode(mode);
    emit(mode);
  }
}
