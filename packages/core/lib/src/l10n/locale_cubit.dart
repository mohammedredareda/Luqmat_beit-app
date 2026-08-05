import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';

/// Persists and restores the user's chosen app locale.
abstract class LocalePreferenceStorage {
  Future<Locale?> getLocale();
  Future<void> saveLocale(Locale locale);
}

/// Runtime-switchable app locale — independent of the device locale.
/// Arabic is the default/source locale.
class LocaleCubit extends Cubit<Locale> {
  LocaleCubit(this._storage) : super(const Locale('ar'));

  final LocalePreferenceStorage _storage;

  Future<void> loadSavedLocale() async {
    final saved = await _storage.getLocale();
    emit(saved ?? const Locale('ar'));
  }

  Future<void> setLocale(Locale locale) async {
    await _storage.saveLocale(locale);
    emit(locale);
  }
}
