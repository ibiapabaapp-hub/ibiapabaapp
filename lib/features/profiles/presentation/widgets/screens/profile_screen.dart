import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:ibiapabaapp/features/profiles/domain/entities/profile.dart';
import 'package:ibiapabaapp/features/profiles/presentation/providers/profile_state_provider.dart';
import 'package:ibiapabaapp/features/profiles/presentation/widgets/contents/business_profile_content.dart';
import 'package:ibiapabaapp/features/profiles/presentation/widgets/contents/personal_profile_content.dart';
import 'package:ibiapabaapp/features/profiles/presentation/widgets/profile_card.dart';
import 'package:ibiapabaapp/shared/ui/fragments/toast/show_app_toast.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileState = ref.watch(profileStateProvider);
    final profile = profileState.activeProfile;

    return SafeArea(
      top: true,
      child: FScaffold(
        child: SingleChildScrollView(
          child: Column(
            spacing: 12,
            children: [
              if (profile != null) ...[
                ProfileCard(profile: profile),
                const SizedBox(height: 16),
                if (profile.type == ProfileType.personal)
                  const PersonalProfileContent()
                else if (profile.type == ProfileType.business)
                  const BusinessProfileContent(),
              ] else ...[
                const Center(child: Text('Nenhum perfil ativo')),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

void showTodoToast(BuildContext context, String page) {
  // TODO: implementar a funcionalidade real de cada redirect
  showAppToast(
    context: context,
    title: Text(
      'TODO: redirecionar para $page',
      style: context.theme.typography.sm.copyWith(
        color: context.theme.colors.foreground,
      ),
    ),
  );
}
