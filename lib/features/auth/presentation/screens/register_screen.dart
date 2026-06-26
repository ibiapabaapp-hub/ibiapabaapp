import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import 'package:ibiapabaapp/features/auth/presentation/controllers/register_controller.dart';
import 'package:ibiapabaapp/features/auth/presentation/states/register_state.dart';
import 'package:ibiapabaapp/features/auth/presentation/widgets/register/steps/basic_info_step.dart';
import 'package:ibiapabaapp/features/auth/presentation/widgets/register/steps/credentials_step.dart';
import 'package:ibiapabaapp/shared/ui/fragments/toast/show_app_toast.dart';
import 'package:ibiapabaapp/shared/ui/layout/beautiful_background_overlay.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  late final pageController = PageController();
  int currentStep = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void next() {
    setState(() => currentStep++);
    pageController.animateToPage(
      currentStep,
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  void back() {
    if (currentStep > 0) {
      setState(() => currentStep--);
      pageController.animateToPage(
        currentStep,
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    }
  }

  void _handleBack() {
    if (currentStep > 0) {
      back();
    } else {
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(registerControllerProvider, (previous, nextState) {
      if (nextState.status == RegisterStatus.success) {
        showAppToast(
          context: context,
          icon: const Icon(Icons.check),
          title: "Bem vindo(a) ao IbiapabaApp!",
          alignment: FToastAlignment.bottomCenter,
          duration: const Duration(seconds: 4),
        );
        context.go('/onboarding');
      }

      if (nextState.status == RegisterStatus.error &&
          nextState.errorMessage != null) {
        showAppToast(
          context: context,
          icon: const Icon(Icons.gpp_maybe_outlined),
          title: 'Erro ao cadastrar',
          description: nextState.errorMessage!,
          alignment: FToastAlignment.bottomCenter,
          duration: const Duration(seconds: 4),
        );
      }
    });

    return PopScope(
      canPop: currentStep == 0,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop && currentStep > 0) {
          back();
        }
      },
      child: SafeArea(
        top: false,
        child: FScaffold(
          header: FHeader.nested(
            prefixes: [
              FButton.icon(
                style: FButtonStyle.ghost(),
                onPress: _handleBack,
                child: const Icon(Icons.arrow_back, size: 24),
              ),
            ],
          ),
          child: Column(
            children: [
              Expanded(
                child: BeautifulBackgroundOverlay(
                  childBelow: true,
                  opacity: 0.1,
                  child: PageView(
                    controller: pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      CredentialsStep(onNext: next),
                      BasicInfoStep(onNext: next),
                      // AccountTypeStep(onSubmit: _submit)
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
