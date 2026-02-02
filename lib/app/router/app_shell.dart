import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ibiapabaapp/shared/ui/exit_app_dialog.dart';
import 'package:ibiapabaapp/shared/ui/navbar.dart';

class AppShell extends StatelessWidget {
  final Widget child;
  const AppShell({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    final locationIsHome = location == '/app/home';

    return PopScope(
      canPop: !locationIsHome,
      onPopInvokedWithResult: (didPop, _) {
        if (locationIsHome && !didPop) {
          showExitAppDialog(context);
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Expanded(child: child),
              const Navbar(),
            ],
          ),
        ),
      ),
    );
  }
}
