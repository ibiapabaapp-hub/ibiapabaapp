import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import 'package:ibivibe/shared/providers/accounts_state_provider.dart';
import 'package:ibivibe/features/accounts/presentation/widgets/account_photo/account_photo.dart';
import 'package:ibivibe/features/accounts/presentation/widgets/dialogs/account_switcher_dialog.dart';

class DestinationItem {
  final String label;
  final IconData icon;
  final IconData selectedIcon;

  const DestinationItem({
    required this.label,
    required this.icon,
    required this.selectedIcon,
  });
}

const List<DestinationItem> _destinations = [
  DestinationItem(
    label: 'Início',
    icon: Icons.home_outlined,
    selectedIcon: Icons.home_rounded,
  ),
  DestinationItem(
    label: 'Buscar',
    icon: Icons.search_rounded,
    selectedIcon: Icons.search_rounded,
  ),
  DestinationItem(
    label: 'Favoritos',
    icon: Icons.favorite_outline_rounded,
    selectedIcon: Icons.favorite_rounded,
  ),
  DestinationItem(
    label: 'Conta',
    icon: Icons.person_outline_rounded,
    selectedIcon: Icons.person_rounded,
  ),
];

class Navbar extends ConsumerWidget {
  const Navbar({super.key});

  int _locationToIndex(String location) {
    if (location.startsWith('/app/search')) return 1;
    if (location.startsWith('/app/favorites')) return 2;
    if (location.startsWith('/app/accounts')) return 3;
    return 0;
  }

  NavigationBarThemeData _getNavbarThemeData(FThemeData theme) {
    return NavigationBarThemeData(
      backgroundColor: theme.colors.background,
      indicatorColor: Colors.transparent,
      overlayColor: WidgetStateProperty.all(Colors.transparent),
      iconTheme: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return IconThemeData(color: theme.colors.foreground);
        }
        return IconThemeData(
          color: theme.colors.mutedForeground.withAlpha(156),
        );
      }),
      labelTextStyle: WidgetStateProperty.resolveWith((states) {
        final style = TextStyle(
          fontSize: 12,
          color: states.contains(WidgetState.selected)
              ? theme.colors.foreground
              : theme.colors.mutedForeground,
        );
        return style;
      }),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final location = GoRouterState.of(context).uri.toString();
    final index = _locationToIndex(location);
    final theme = context.theme;
    final accountsState = ref.watch(accountsStateProvider);
    final activeAccount = accountsState.activeAccount;

    return NavigationBarTheme(
      data: _getNavbarThemeData(theme),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: theme.colors.border.withAlpha(72),
              width: 0.7,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: NavigationBar(
            selectedIndex: index,
            height: 60,
            labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
            onDestinationSelected: (i) {
              if (i == index) return;

              final routes = [
                '/app/home',
                '/app/search',
                '/app/favorites',
                '/app/accounts',
              ];

              i == 0 ? context.go(routes[i]) : context.push(routes[i]);
            },
            destinations: [
              ..._destinations.asMap().entries.map((entry) {
                final i = entry.key;
                final dest = entry.value;
                final isProfile = i == 3;

                Widget wrapSpecialGestures(Widget child) {
                  if (!isProfile) return child;
                  return GestureDetector(
                    onLongPress: () => showAccountSwitcherSheet(context, ref),
                    onDoubleTap: () => showAccountSwitcherSheet(context, ref),
                    behavior: HitTestBehavior.opaque,
                    child: child,
                  );
                }

                return NavigationDestination(
                  icon: wrapSpecialGestures(
                    isProfile
                        ? AccountPhoto(
                            key: ValueKey(activeAccount?.id),
                            account: activeAccount,
                            size: 28,
                          )
                        : Icon(dest.icon, size: 28),
                  ),
                  selectedIcon: wrapSpecialGestures(
                    isProfile
                        ? AccountPhoto(
                            key: ValueKey(activeAccount?.id),
                            account: activeAccount,
                            size: 28,
                            borderColor: context.theme.colors.foreground,
                            isSelected: true,
                          )
                        : Icon(dest.selectedIcon, size: 28),
                  ),
                  label: dest.label,
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
