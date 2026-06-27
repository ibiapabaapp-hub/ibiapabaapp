import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import 'package:ibivibe/features/auth/presentation/providers/auth_providers.dart';
import 'package:ibivibe/features/auth/presentation/widgets/login/login_form.dart';
import 'package:ibivibe/features/auth/presentation/widgets/shared/google_oauth_button.dart';
import 'package:ibivibe/features/auth/presentation/widgets/shared/text_between_dividers.dart';
import 'package:ibivibe/shared/ui/layout/beautiful_background_overlay.dart';
import 'package:ibivibe/shared/ui/layout/form_topbar.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(loginControllerProvider);
    return SafeArea(
      child: FScaffold(
        header: FHeader.nested(
          prefixes: [
            FButton.icon(
              style: FButtonStyle.ghost(),
              onPress: () => context.pop(),
              child: const Icon(Icons.arrow_back, size: 24),
            ),
          ],
        ),
        child: BeautifulBackgroundOverlay(
          childBelow: true,
          opacity: 0.12,
          alignment: .bottomCenter,
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 16,
              children: [
                const FormTopbar(
                  subtitle: 'Bem vindo(a) de volta!',
                  title: 'Entrar',
                ),
                LoginForm(controller: controller),
                FButton(
                  style: FButtonStyle.ghost(),
                  onPress: () => context.push('/auth/register'),
                  child: const Text('Ainda não tenho conta'),
                ),
                const TextBetweenDividers(text: 'ou'),
                const GoogleOAuthButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
