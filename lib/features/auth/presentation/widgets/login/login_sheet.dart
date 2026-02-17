import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:ibiapabaapp/features/auth/presentation/controllers/login_controller.dart';
import 'package:ibiapabaapp/features/auth/presentation/widgets/login/login_form.dart';
import 'package:ibiapabaapp/features/auth/presentation/widgets/login/login_header.dart';

void showLoginSheet({
  required LoginController controller,
  required BuildContext context,
}) {
  final double screenHeight = MediaQuery.of(context).size.height;

  showModalBottomSheet(
    context: context,
    barrierColor: Colors.black45,
    enableDrag: true,
    isDismissible: true,
    isScrollControlled: true,
    builder: (context) => SizedBox(
      height: screenHeight * 0.85,
      child: Container(
        decoration: BoxDecoration(
          color: context.theme.colors.background,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const LoginHeader(),
                const SizedBox(height: 16),
                const FDivider(),
                const SizedBox(height: 16),
                LoginForm(controller: controller),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
