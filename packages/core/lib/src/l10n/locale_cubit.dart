import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../storage/local_cache_box.dart';

/// Runtime, in-app language switch, independent of device locale — Arabic
/// is the default/source locale (CLAUDE.md §RTL & i18n).
class LocaleCubit extends Cubit<Locale> {
  LocaleCubit() : super(const Locale('ar'));

  static const _key = 'locale_code';

  Box get _box => LocalCacheBox.box(LocalCacheBoxNames.localePreference);

  Future<void> loadSavedLocale() async {
    final saved = _box.get(_key) as String?;
    if (saved != null) emit(Locale(saved));
  }

  Future<void> setLocale(Locale locale) async {
    await _box.put(_key, locale.languageCode);
    emit(locale);
  }
}
