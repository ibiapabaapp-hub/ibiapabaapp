import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

class ProfileTypeTile extends StatelessWidget {
  const ProfileTypeTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.isSelected,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? colors.primary.withAlpha(32) : colors.secondary,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? colors.primary : colors.border,
            width: isSelected ? 1.4 : 1,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: .start,
          spacing: 6,
          children: [
            Row(
              mainAxisAlignment: .spaceBetween,
              crossAxisAlignment: .start,
              children: [
                Icon(
                  icon,
                  color: isSelected ? colors.primary : colors.mutedForeground,
                  size: 24,
                ),
                _SelectionIndicator(isSelected: isSelected),
              ],
            ),
            const SizedBox(height: 12),
            _Information(title: title, subtitle: subtitle),
          ],
        ),
      ),
    );
  }
}

class _Information extends StatelessWidget {
  final String title;
  final String subtitle;
  const _Information({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 4,
      children: [
        Text(
          title,
          style: context.theme.typography.base.copyWith(fontWeight: .w500),
        ),
        Text(
          subtitle,
          style: context.theme.typography.sm.copyWith(
            color: context.theme.colors.foreground.withAlpha(172),
          ),
        ),
      ],
    );
  }
}

class _SelectionIndicator extends StatelessWidget {
  const _SelectionIndicator({required this.isSelected});

  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 200),
      child: isSelected
          ? Icon(
              Icons.check_circle,
              key: const ValueKey('checked'),
              color: context.theme.colors.primary,
              size: 20,
            )
          : Container(
              key: const ValueKey('unchecked'),
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: context.theme.colors.border,
                  width: 1,
                ),
              ),
            ),
    );
  }
}
