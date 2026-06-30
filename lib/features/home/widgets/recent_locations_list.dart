import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

class RecentLocationsList extends StatelessWidget {
  const RecentLocationsList({super.key});

  static const _recentLocations = ['Tianguá', 'Ubajara', 'Croatá'];

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Container(
      decoration: BoxDecoration(
        color: theme.colors.background,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.colors.border, width: 1),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _recentLocations.length,
          separatorBuilder: (_, _) =>
              Divider(height: 1, thickness: 1, color: theme.colors.border),
          itemBuilder: (context, index) {
            final city = _recentLocations[index];
            return ListTile(
              leading: Icon(
                Icons.location_on_outlined,
                color: theme.colors.mutedForeground,
                size: 20,
              ),
              title: Text(
                city,
                style: theme.typography.sm.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              trailing: Icon(
                Icons.chevron_right,
                color: theme.colors.mutedForeground,
                size: 18,
              ),
              onTap: () {},
            );
          },
        ),
      ),
    );
  }
}
