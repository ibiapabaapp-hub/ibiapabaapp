import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:ibivibe/shared/models/account_type.dart';
import 'package:ibivibe/features/onboarding/presentation/controllers/google_onboarding_controller.dart';
import 'package:ibivibe/features/onboarding/presentation/states/google_onboarding_state.dart';
import 'package:ibivibe/features/onboarding/presentation/widgets/profile_type_tile.dart';
import 'package:go_router/go_router.dart';
import 'package:ibivibe/core/preferences/user_preferences_state_provider.dart';
import 'package:ibivibe/shared/ui/fragments/toast/show_app_toast.dart';
import 'package:ibivibe/shared/ui/layout/beautiful_background_overlay.dart';
import 'package:ibivibe/shared/ui/layout/form_topbar.dart';

class GoogleAccountTypeScreen extends ConsumerStatefulWidget {
  const GoogleAccountTypeScreen({super.key});

  @override
  ConsumerState<GoogleAccountTypeScreen> createState() =>
      _GoogleAccountTypeScreenState();
}

class _GoogleAccountTypeScreenState
    extends ConsumerState<GoogleAccountTypeScreen> {
  AccountType _selected = AccountType.personal;

  @override
  void initState() {
    super.initState();
    // Initialize with the current account type from controller if available
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final state = ref.read(googleOnboardingControllerProvider);
      if (state.accountType != null) {
        setState(() {
          _selected = state.accountType!;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FScaffold(
        header: const FHeader.nested(),
        child: BeautifulBackgroundOverlay(
          childBelow: true,
          opacity: 0.12,
          alignment: .bottomCenter,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: 32,
              children: [
                const _Heading(),
                _buildProfileSelector(),
                FAlert(
                  style: (style) => style.copyWith(
                    decoration: style.decoration.copyWith(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  icon: const Icon(FIcons.info),
                  title: Text(
                    'Dica: Você pode alternar entre seus perfis a qualquer momento em "Perfil"',
                    style: context.theme.typography.sm.copyWith(
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileSelector() {
    final state = ref.watch(googleOnboardingControllerProvider);
    final isLoading = state.status == GoogleOnboardingStatus.loading;

    return LayoutBuilder(
      builder: (context, constraints) {
        final useHorizontalLayout = constraints.maxWidth >= 760;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (useHorizontalLayout)
              IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(child: _buildPersonalProfileTile()),
                    const SizedBox(width: 16),
                    Expanded(child: _buildBusinessProfileTile()),
                  ],
                ),
              )
            else ...[
              _buildPersonalProfileTile(),
              const SizedBox(height: 16),
              _buildBusinessProfileTile(),
            ],
            const SizedBox(height: 32),
            FButton(
              onPress: isLoading ? null : _handleContinue,
              child: isLoading
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('Continuar'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildPersonalProfileTile() {
    return ProfileTypeTile(
      icon: Icons.hail,
      title: 'Sou turista ou morador da Ibiapaba',
      subtitle:
          'Quero descobrir empresas e eventos, mas também criar eventos simples',
      isSelected: _selected == AccountType.personal,
      onTap: () {
        setState(() => _selected = AccountType.personal);
        ref
            .read(googleOnboardingControllerProvider.notifier)
            .setAccountType(AccountType.personal);
      },
    );
  }

  Widget _buildBusinessProfileTile() {
    return ProfileTypeTile(
      icon: Icons.business_center_outlined,
      title: 'Sou empresário ou funcionário',
      subtitle: 'Quero anunciar uma empresa e criar eventos',
      isSelected: _selected == AccountType.business,
      onTap: () {
        setState(() => _selected = AccountType.business);
        ref
            .read(googleOnboardingControllerProvider.notifier)
            .setAccountType(AccountType.business);
      },
    );
  }

  Future<void> _handleContinue() async {
    await ref.read(googleOnboardingControllerProvider.notifier).submit();

    if (!mounted) return;

    final state = ref.read(googleOnboardingControllerProvider);
    if (state.status == GoogleOnboardingStatus.error) {
      showAppToast(
        context: context,
        title: state.errorMessage ?? 'Erro ao completar registro',
      );
      return;
    }

    if (state.status == GoogleOnboardingStatus.success) {
      ref.read(userPreferencesStateProvider.notifier).setNeedsOnboarding(false);
      context.go('/app/home');
    }
  }
}

class _Heading extends StatelessWidget {
  const _Heading();

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 12,
      children: [
        FormTopbar(
          invertColumn: true,
          title: 'Tipo de conta',
          subtitle: 'Como você quer usar sua conta?',
        ),
      ],
    );
  }
}
