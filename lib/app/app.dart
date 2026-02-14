import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:forui/forui.dart';
import 'package:ibiapabaapp/app/router/app_router.dart';
import 'package:ibiapabaapp/app/theme/theme.dart';

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    final customLightTheme = customZincLight();
    final customDarkTheme = customZincDark();

    return MaterialApp.router(
      title: 'IbiapabaApp',
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        FLocalizations.delegate,
      ],
      supportedLocales: [Locale('pt', 'BR')],
      locale: Locale('pt', 'BR'),
      routerConfig: AppRouter().getRouterInstance,
      themeMode: ThemeMode.system,
      theme: customLightTheme.toApproximateMaterialTheme(),
      darkTheme: customDarkTheme.toApproximateMaterialTheme(),

      builder: (context, child) {
        final brightness = MediaQuery.of(context).platformBrightness;
        final foruiTheme = brightness == Brightness.dark
            ? customDarkTheme
            : customLightTheme;

        return FAnimatedTheme(
          data: foruiTheme,
          child: FToaster(child: child!, style: (style) => style),
        );
      },
    );
  }
}
