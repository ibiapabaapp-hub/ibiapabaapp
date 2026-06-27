import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

import '../widgets/profile_type_tile.dart';

enum ProfileType { user, business }

class OnboardingProfileScreen extends StatefulWidget {
  const OnboardingProfileScreen({super.key, this.onProfileSelected});

  final void Function(ProfileType)? onProfileSelected;

  @override
  State<OnboardingProfileScreen> createState() =>
      _OnboardingProfileScreenState();
}

class _OnboardingProfileScreenState extends State<OnboardingProfileScreen> {
  ProfileType _selected = ProfileType.user;

  @override
  Widget build(BuildContext context) {
    return FScaffold(
      header: const FHeader.nested(),
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
                  borderRadius: .circular(16),
                ),
              ),
              icon: const Icon(FIcons.info),
              title: Text(
                'Dica: Você pode alternar entre seus perfis a qualquer momento em "Perfil"',
                style: context.theme.typography.sm.copyWith(
                  fontWeight: .normal,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileSelector() {
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
                    Expanded(child: _buildUserProfileTile()),
                    const SizedBox(width: 16),
                    Expanded(child: _buildBusinessProfileTile()),
                  ],
                ),
              )
            else ...[
              _buildUserProfileTile(),
              const SizedBox(height: 16),
              _buildBusinessProfileTile(),
            ],
            const SizedBox(height: 32),
            FButton(onPress: _handleContinue, child: const Text('Continuar')),
          ],
        );
      },
    );
  }

  Widget _buildUserProfileTile() {
    return ProfileTypeTile(
      icon: Icons.hail,
      title: 'Sou turista ou morador da Ibiapaba',
      subtitle:
          'Quero descobrir empresas e eventos, mas também criar eventos simples',
      isSelected: _selected == ProfileType.user,
      onTap: () => setState(() => _selected = ProfileType.user),
    );
  }

  Widget _buildBusinessProfileTile() {
    return ProfileTypeTile(
      icon: Icons.business_center_outlined,
      title: 'Sou empresário ou funcionário',
      subtitle: 'Quero anunciar uma empresa e criar eventos',
      isSelected: _selected == ProfileType.business,
      onTap: () => setState(() => _selected = ProfileType.business),
    );
  }

  void _handleContinue() {
    widget.onProfileSelected?.call(_selected);
  }
}

class _Heading extends StatelessWidget {
  const _Heading();

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 12,
      children: [
        Text(
          'Seu perfil',
          style: theme.typography.xl2.copyWith(fontWeight: FontWeight.w600),
        ),
        Text(
          'Permitimos um único perfil de turista/morador e vários perfis de empresa/funcionário na mesma conta',
          style: theme.typography.base,
        ),
      ],
    );
  }
}
