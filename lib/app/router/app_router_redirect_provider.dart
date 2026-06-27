import 'package:ibiapabaapp/core/preferences/user_preferences_state_provider.dart';
import 'package:ibiapabaapp/shared/providers/accounts_state_provider.dart';
import 'package:ibiapabaapp/features/auth/presentation/providers/auth_state_provider.dart';
import 'package:ibiapabaapp/features/auth/presentation/providers/google_oauth_state_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_router_redirect_provider.g.dart';

enum RedirectTarget { loading, welcome, onboarding, home, none }

@riverpod
RedirectTarget routerRedirect(Ref ref) {
  final googleOAuthState = ref.watch(googleOAuthStateProvider);

  // OAuth flow em andamento — não interferir
  if (googleOAuthState.tempToken != null) return RedirectTarget.none;

  final isAuthenticated = ref.watch(isAuthenticatedProvider);

  // Aguarda carregamento antes de decidir destino
  if (!isAuthenticated) {
    final isLoading =
        googleOAuthState.isLoading ||
        ref.watch(accountsStateProvider).isLoading;

    if (isLoading) return RedirectTarget.loading;

    return RedirectTarget.welcome;
  }

  // Usuário autenticado: verifica se precisa de onboarding
  final needsOnboarding = ref
      .watch(userPreferencesStateProvider)
      .needsOnboarding;
  final hasAccounts = ref
      .watch(accountsStateProvider)
      .cachedAccounts
      .isNotEmpty;

  if (needsOnboarding && !hasAccounts) return RedirectTarget.onboarding;

  return RedirectTarget.home;
}
