import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import 'package:ibivibe/core/session/app_session_notifier_provider.dart';
import 'package:ibivibe/features/home/widgets/businesses_section.dart';
import 'package:ibivibe/features/home/widgets/explore_cities_section.dart';
import 'package:ibivibe/features/home/widgets/now_happening_section.dart';
import 'package:ibivibe/features/home/widgets/quick_categories.dart';
import 'package:ibivibe/features/home/widgets/change_location_sheet.dart';
import 'package:ibivibe/features/home/widgets/sponsored_highlights.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            _HomeHeader(),
            const SizedBox(height: 8),

            const SponsoredHighlights(),
            const SizedBox(height: 24),

            const QuickCategoriesList(),
            const SizedBox(height: 16),

            const NowHappeningSection(),
            const SizedBox(height: 24),

            const CompaniesSection(),
            const SizedBox(height: 24),

            const ExploreCitiesSection(),
          ],
        ),
      ),
    );
  }
}

class _HomeHeader extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 16);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 56,
      elevation: 0,
      scrolledUnderElevation: 0,
      backgroundColor: Colors.transparent,
      titleSpacing: 24,
      title: _ActualCityButton(),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 24),
          child: _NotificationButton(),
        ),
      ],
    );
  }
}

class _ActualCityButton extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = ref.watch(appSessionProvider);
    return FTooltip(
      tipAnchor: Alignment.topLeft,
      spacing: const FPortalSpacing(12),
      childAnchor: Alignment.bottomLeft,
      hover: true,
      longPress: true,
      tipBuilder: (context, _) =>
          const Text('Localização atual, toque para mudar'),
      child: InkWell(
        onTap: () => showChangeLocationSheet(context: context),
        borderRadius: BorderRadius.circular(8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              session.currentCity?.name ?? 'Selecione uma cidade',
              overflow: .ellipsis,
              style: context.theme.typography.lg.copyWith(fontWeight: .w600),
            ),
            const SizedBox(width: 4),
            Icon(
              Icons.keyboard_arrow_down_rounded,
              size: 18,
              color: context.theme.colors.secondaryForeground,
            ),
          ],
        ),
      ),
    );
  }
}

class _NotificationButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        FButton.icon(
          onPress: () {
            context.push('/app/settings');
          },
          style: FButtonStyle.ghost(),
          child: const Icon(Icons.notifications_outlined, size: 24),
        ),
        Positioned(
          top: 6,
          right: 3,
          child: Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: context.theme.colors.primary,
              shape: BoxShape.circle,
              border: Border.all(
                color: context.theme.colors.background,
                width: 2,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
