import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import 'package:ibivibe/app/theme/custom_styles/fselect_item_style.dart';
import 'package:ibivibe/shared/models/gender.dart';
import 'package:ibivibe/features/onboarding/google_onboarding_viewmodel.dart';
import 'package:ibivibe/shared/ui/layout/beautiful_background_overlay.dart';

class GoogleSlugGenderScreen extends ConsumerStatefulWidget {
  const GoogleSlugGenderScreen({super.key});

  @override
  ConsumerState<GoogleSlugGenderScreen> createState() =>
      _GoogleSlugGenderScreenState();
}

class _GoogleSlugGenderScreenState
    extends ConsumerState<GoogleSlugGenderScreen> {
  final _formKey = GlobalKey<FormState>();

  

  void _submit() {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) return;

    final state = ref.read(googleOnboardingViewModelProvider);
    final controller = ref.read(googleOnboardingViewModelProvider.notifier);
    if (!controller.isSlugAvailable()!) return;
    if (state.gender == null) return;

    context.push('/onboarding/google-account-type');
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(googleOnboardingViewModelProvider);
    final controller = ref.read(googleOnboardingViewModelProvider.notifier);
    final isAvailable = controller.isSlugAvailable();
    final canContinue =
        isAvailable != null && isAvailable == true && state.gender != null;

    return SafeArea(
      child: FScaffold(
        header: const FHeader.nested(),
        footer: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
          child: FButton(
            onPress: canContinue ? _submit : null,
            child: const Text(
              'Continuar',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        child: BeautifulBackgroundOverlay(
          childBelow: true,
          opacity: 0.12,
          alignment: .bottomCenter,
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 24,
              children: [
                const _Heading(),
                
                _GenderSelection(
                  selectedGender: state.gender,
                  onGenderSelected: (gender) {
                    controller.setGender(gender);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
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
          'Complete seu perfil',
          style: theme.typography.xl2.copyWith(fontWeight: FontWeight.w600),
        ),
        Text(
          'Escolha um nome de usuário e informe seu gênero para continuar',
          style: theme.typography.base,
        ),
      ],
    );
  }
}

String _getGenderLabel(String value) {
  switch (value) {
    case 'male':
      return 'Masculino';
    case 'female':
      return 'Feminino';
    case 'non_binary':
      return 'Não-binário';
    case 'prefer_not_to_say':
      return 'Prefiro não dizer';
    default:
      return value;
  }
}

class _GenderSelection extends StatelessWidget {
  const _GenderSelection({
    required this.selectedGender,
    required this.onGenderSelected,
  });

  final Gender? selectedGender;
  final Function(Gender) onGenderSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 12,
      children: [
        FSelect.rich(
          format: (value) => _getGenderLabel(value),
          label: const Text('Gênero'),
          control: FSelectControl<String>.managed(
            initial: selectedGender?.name,
            onChange: (value) {
              onGenderSelected(
                Gender.values.firstWhere((g) => g.name == value),
              );
            },
          ),
          children: [
            .item(
              title: const Text('Masculino'),
              value: 'male',
              style: (style) => fSelectItemStyle(context, style),
            ),
            .item(
              title: const Text('Feminino'),
              value: 'female',
              style: (style) => fSelectItemStyle(context, style),
            ),
            .item(
              title: const Text('Não binário'),
              value: 'non_binary',
              style: (style) => fSelectItemStyle(context, style),
            ),
            .item(
              title: const Text('Prefiro não dizer'),
              value: 'prefer_not_to_say',
              style: (style) => fSelectItemStyle(context, style),
            ),
          ],
        ),
      ],
    );
  }
}
