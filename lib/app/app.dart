// ignore_for_file: experimental_member_use

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:ibiapabaapp/app/router/app_router_provider.dart';
import 'package:ibiapabaapp/app/theme/adapted_styles/theme.dart';
import 'package:ibiapabaapp/core/preferences/user_preferences_state_provider.dart';

class App extends ConsumerWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    final favoriteThemeMode = ref.watch(
      userPreferencesStateProvider.select((s) => s.themeMode),
    );

    final customLightTheme = customZincLight();
    final customDarkTheme = customZincDark();

    return MaterialApp.router(
      title: 'IbiapabaApp',
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        FLocalizations.delegate,
      ],
      supportedLocales: const [Locale('pt', 'BR')],
      locale: const Locale('pt', 'BR'),
      routerConfig: router,
      themeMode: favoriteThemeMode,
      theme: customLightTheme.toApproximateMaterialTheme().copyWith(
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          },
        ),
      ),
      darkTheme: customDarkTheme.toApproximateMaterialTheme().copyWith(
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          },
        ),
      ),

      builder: (context, child) {
        final brightness = switch (favoriteThemeMode) {
          ThemeMode.dark => Brightness.dark,
          ThemeMode.light => Brightness.light,
          ThemeMode.system => MediaQuery.of(context).platformBrightness,
        };
        final foruiTheme = brightness == Brightness.dark
            ? customDarkTheme
            : customLightTheme;

        return FAnimatedTheme(
          data: foruiTheme,
          child: FToaster(style: (style) => style, child: child!),
        );
      },
    );
  }
}
