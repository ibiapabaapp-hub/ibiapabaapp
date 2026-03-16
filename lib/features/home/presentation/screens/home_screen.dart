import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:ibiapabaapp/features/home/presentation/widgets/companies_section.dart';
import 'package:ibiapabaapp/features/home/presentation/widgets/explore_cities_section.dart';
import 'package:ibiapabaapp/features/home/presentation/widgets/now_happening_section.dart';
import 'package:ibiapabaapp/features/home/presentation/widgets/sheets/change_location_sheet.dart';
import 'package:ibiapabaapp/features/home/presentation/widgets/quick_categories.dart';
import 'package:ibiapabaapp/features/home/presentation/widgets/sponsored_highlights.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: SingleChildScrollView(
        child: Column(
          children: [
            _HomeHeader(),
            QuickCategoriesList(),
            const SizedBox(height: 24),

            SponsoredHighlights(),
            const SizedBox(height: 32),

            NowHappeningSection(),
            const SizedBox(height: 32),

            CompaniesSection(),
            const SizedBox(height: 32),

            ExploreCitiesSection(),
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
      toolbarHeight: 64,
      elevation: 0,
      scrolledUnderElevation: 0,
      backgroundColor: Colors.transparent,
      titleSpacing: 24,
      automaticallyImplyLeading: false,

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

class _ActualCityButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
              'Ubajara, CE',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: context.theme.colors.foreground,
              ),
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
          onPress: () {},
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
