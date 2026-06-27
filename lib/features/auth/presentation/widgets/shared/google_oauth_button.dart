import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:ibivibe/app/router/app_router_provider.dart';
import 'package:ibivibe/features/auth/presentation/providers/google_oauth_state_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GoogleOAuthButton extends ConsumerWidget {
  const GoogleOAuthButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final googleOAuthState = ref.watch(googleOAuthStateProvider);
    final isLoading = googleOAuthState.isLoading;
    final theme = context.theme;

    return FButton(
      onPress: isLoading
          ? null
          : () async {
              final router = ref.read(appRouterProvider);
              final shouldRedirect = await ref
                  .read(googleOAuthStateProvider.notifier)
                  .signInWithGoogle();

              if (shouldRedirect) {
                router.go('/onboarding/google-slug-and-gender');
              }
            },
      style: FButtonStyle.outline(),
      prefix: isLoading
          ? SizedBox(
              height: 14,
              width: 14,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: theme.colors.primaryForeground,
              ),
            )
          : Image.asset('assets/images/google-g-logo.webp', width: 18),
      child: Text(isLoading ? "Carregando..." : "Entrar com Google"),
    );
  }
}
