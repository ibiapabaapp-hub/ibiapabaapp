import 'package:ibivibe/core/preferences/user_preferences_state_provider.dart';
import 'package:ibivibe/shared/providers/accounts_viewmodel.dart';
import 'package:ibivibe/features/auth/auth_viewmodel.dart';
import 'package:ibivibe/features/auth/google_oauth_viewmodel.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_router_redirect_provider.g.dart';

enum RedirectTarget { loading, welcome, onboarding, home, none }

@riverpod
RedirectTarget routerRedirect(Ref ref) {
  final googleOAuthState = ref.watch(googleOAuthViewModelProvider);

  // OAuth flow em andamento — não interferir
  if (googleOAuthState.tempToken != null) return RedirectTarget.none;

  final isAuthenticated = ref.watch(isAuthenticatedProvider);

  // Aguarda carregamento antes de decidir destino
  if (!isAuthenticated) {
    final isLoading =
        googleOAuthState.isLoading ||
        ref.watch(accountsViewModelProvider).isLoading;

    if (isLoading) return RedirectTarget.loading;

    return RedirectTarget.welcome;
  }

  // Usuário autenticado: verifica se precisa de onboarding
  final needsOnboarding = ref
      .watch(userPreferencesStateProvider)
      .needsOnboarding;
  final hasAccounts = ref
      .watch(accountsViewModelProvider)
      .cachedAccounts
      .isNotEmpty;

  if (needsOnboarding && !hasAccounts) return RedirectTarget.onboarding;

  return RedirectTarget.home;
}
