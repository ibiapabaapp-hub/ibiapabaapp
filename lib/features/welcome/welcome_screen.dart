import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:ibiapabaapp/features/welcome/widgets/welcome_actions.dart';
import 'package:ibiapabaapp/features/welcome/widgets/welcome_header.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FScaffold(
        child: SingleChildScrollView(
          child: Column(
            spacing: 32,
            children: [WelcomeHeader(), WelcomeActions()],
          ),
        ),
      ),
    );
  }
}
