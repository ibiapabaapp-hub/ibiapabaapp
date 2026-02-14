import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import 'package:ibiapabaapp/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:ibiapabaapp/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:ibiapabaapp/features/auth/domain/usecases/check_unique_availability.dart';
import 'package:ibiapabaapp/features/auth/domain/usecases/register_with_email.dart';
import 'package:ibiapabaapp/features/auth/presentation/controllers/register_controller.dart';
import 'package:ibiapabaapp/features/auth/presentation/states/register_state.dart';
import 'package:ibiapabaapp/features/auth/presentation/widgets/register/steps/birth_date_step.dart';
import 'package:ibiapabaapp/features/auth/presentation/widgets/register/steps/email_step.dart';
import 'package:ibiapabaapp/features/auth/presentation/widgets/register/steps/name_step.dart';
import 'package:ibiapabaapp/features/auth/presentation/widgets/register/steps/password_step.dart';
import 'package:ibiapabaapp/features/auth/presentation/widgets/register/steps/phone_step/phone_step.dart';
import 'package:ibiapabaapp/features/auth/presentation/widgets/register/steps/username_step.dart';
import 'package:ibiapabaapp/shared/ui/step_dots.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late final RegisterController controller;
  final pageController = PageController();
  int currentStep = 0;

  @override
  void initState() {
    super.initState();
    controller = RegisterController(
      RegisterWithEmail(AuthRepositoryImpl(AuthRemoteDatasourceImpl())),
      CheckUniqueAvailability(AuthRepositoryImpl(AuthRemoteDatasourceImpl())),
    );
    controller.addListener(_controllerListener);
  }

  @override
  void dispose() {
    super.dispose();
    controller.removeListener(_controllerListener);
  }

  void _controllerListener() {
    final state = controller.state;

    if (state is RegisterSuccess) {
      showFToast(
        context: context,
        icon: Icon(Icons.check),
        title: Text(
          "Bem vindo(a) ao IbiapabaApp!",
          style: TextStyle(color: context.theme.colors.foreground),
        ),
        alignment: FToastAlignment.bottomCenter,
        duration: const Duration(seconds: 4),
      );
      context.go('/app/home');
    }

    if (state is RegisterError) {
      showFToast(
        context: context,
        icon: const Icon(Icons.gpp_maybe_outlined),
        title: Text('Erro ao cadastrar'),
        description: Text(state.message),
        alignment: FToastAlignment.bottomCenter,
        duration: const Duration(seconds: 4),
      );
    }

    setState(() {});
  }

  void next() {
    setState(() => currentStep++);
    pageController.animateToPage(
      currentStep,
      duration: Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  void back() {
    if (currentStep > 0) {
      setState(() => currentStep--);
      pageController.animateToPage(
        currentStep,
        duration: Duration(milliseconds: 300),
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
    return PopScope(
      canPop: currentStep == 0,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop && currentStep > 0) {
          back();
        }
      },
      child: FScaffold(
        header: FHeader.nested(
          prefixes: [
            FButton.icon(
              style: FButtonStyle.ghost(),
              onPress: _handleBack,
              child: Icon(Icons.arrow_back, size: 24),
            ),
          ],
        ),
        child: SafeArea(
          child: Column(
            children: [
              StepDots(current: currentStep, total: 6),
              Expanded(
                child: PageView(
                  controller: pageController,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    BirthDateStep(controller: controller, onNext: next),
                    NameStep(controller: controller, onNext: next),
                    PhoneStep(controller: controller, onNext: next),
                    UsernameStep(controller: controller, onNext: next),
                    EmailStep(controller: controller, onNext: next),
                    PasswordStep(
                      controller: controller,
                      onSubmit: () async {
                        await controller.submit();
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
