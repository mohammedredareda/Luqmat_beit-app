import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'di/injection.dart';
import 'l10n/generated/app_localizations.dart';
import 'router/app_router.dart';

class CookApp extends StatelessWidget {
  CookApp({super.key});

  final _router = buildRouter();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<LocaleCubit>()..loadSavedLocale()),
        BlocProvider(create: (_) => getIt<ThemeCubit>()..loadSavedThemeMode()),
      ],
      child: BlocBuilder<LocaleCubit, Locale>(
        builder: (context, locale) => BlocBuilder<ThemeCubit, ThemeMode>(
          builder: (context, themeMode) => MaterialApp.router(
            debugShowCheckedModeBanner: false,
            locale: locale,
            supportedLocales: const [Locale('ar'), Locale('en')],
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode: themeMode,
            routerConfig: _router,
          ),
        ),
      ),
    );
  }
}
