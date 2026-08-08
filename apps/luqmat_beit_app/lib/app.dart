import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'di/injection.dart';
import 'l10n/generated/app_localizations.dart';
import 'router/app_router.dart';

/// One root widget for both the customer and cook experiences — which
/// screens are reachable is decided entirely by `router/app_router.dart`'s
/// `redirect`, gated on the logged-in account's role (see [SessionCubit]).
/// There is no in-app role switcher: role is fixed per account at
/// registration, this widget just renders whichever shell that account's
/// role resolves to.
class LuqmatBeitApp extends StatelessWidget {
  const LuqmatBeitApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<LocaleCubit>()..loadSavedLocale(),
      child: BlocBuilder<LocaleCubit, Locale>(
        builder: (context, locale) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'لُقمة بيت',
            locale: locale,
            supportedLocales: const [Locale('ar'), Locale('en')],
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            theme: AppTheme.light,
            routerConfig: appRouter,
          );
        },
      ),
    );
  }
}
