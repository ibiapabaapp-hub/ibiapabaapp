import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

class SearchFieldShell extends StatelessWidget {
  const SearchFieldShell({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(color: theme.colors.muted.withAlpha(200)),
      padding: const .fromLTRB(16, 16, 16, 16),
      child: child,
    );
  }
}
