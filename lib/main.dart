import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';

import 'package:forui/forui.dart';
import 'package:ibiapabaapp/screens/onboarding/company_onboarding_screen.dart';
import 'package:ibiapabaapp/screens/onboarding/user_onboarding_screen.dart';

import 'package:ibiapabaapp/screens/home/home_screen.dart';
import 'package:ibiapabaapp/screens/login/login_screen.dart';
import 'package:ibiapabaapp/screens/register/register_screen.dart';
import 'package:ibiapabaapp/screens/welcome/welcome_screen.dart';
import 'package:ibiapabaapp/theme/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  static final GoRouter _router = GoRouter(
    routes: [
      // Welcome & Onboarding
      GoRoute(path: '/', redirect: (_, _) => '/welcome'),
      GoRoute(
        path: '/welcome',
        builder: (context, state) => const WelcomeScreen(),
      ),
      GoRoute(
        path: '/onboarding/user',
        builder: (context, state) => const UserOnboardingScreen(),
      ),
      GoRoute(
        path: '/onboarding/company',
        builder: (context, state) => const CompanyOnboardingScreen(),
      ),

      // Authentication
      GoRoute(
        path: '/auth/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/auth/register',
        builder: (context, state) => const RegisterScreen(),
      ),

      // Application
      GoRoute(
        path: '/app/home',
        builder: (context, state) => const HomeScreen(),
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    final customLightTheme = customZincLight();
    final customDarkTheme = customZincDark();

    return MaterialApp.router(
      routerConfig: _router,
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
