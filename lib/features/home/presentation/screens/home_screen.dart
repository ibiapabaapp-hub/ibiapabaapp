import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:ibiapabaapp/features/home/presentation/widgets/explore_cities_section.dart';
import 'package:ibiapabaapp/features/home/presentation/widgets/sheets/change_location_sheet.dart';
import 'package:ibiapabaapp/features/home/presentation/widgets/now_happening_section.dart';
import 'package:ibiapabaapp/features/home/presentation/widgets/quick_categories.dart';
import 'package:ibiapabaapp/features/home/presentation/widgets/sponsored_highlights.dart';
import 'package:ibiapabaapp/shared/ui/main_wrapper.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        spacing: 16,
        children: [
          _HomeHeader(),
          QuickCategoriesList(),
          MainWrapper(
            children: [
              SponsoredHighlights(),
              NowHappeningSection(),
              ExploreCitiesSection(),
            ],
          ),
        ],
      ),
    );
  }
}

class _HomeHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const .fromLTRB(24, 16, 24, 0),
      child: Row(
        mainAxisSize: .max,
        mainAxisAlignment: .spaceBetween,
        children: [
          Column(
            crossAxisAlignment: .start,
            spacing: 8,
            children: [
              FTooltip(
                tipAnchor: Alignment.topLeft,
                spacing: FPortalSpacing(12),
                childAnchor: Alignment.bottomLeft,
                hover: true,
                longPress: true,
                tipBuilder: (context, _) =>
                    const Text('Localização atual, toque para mudar'),
                child: FButton.raw(
                  onPress: () => showChangeLocationSheet(context: context),
                  style: FButtonStyle.ghost(),
                  child: Row(
                    mainAxisAlignment: .center,
                    crossAxisAlignment: .center,
                    spacing: 4,
                    children: [
                      const Text(
                        'Ubajara, CE',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Icon(
                        Icons.keyboard_arrow_down_rounded,
                        weight: 2,
                        size: 16,
                        color: context.theme.colors.secondaryForeground,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          Stack(
            children: [
              FButton.icon(
                onPress: () {},
                style: FButtonStyle.ghost(),
                child: Icon(Icons.notifications_outlined, size: 24),
              ),

              Positioned(
                top: 6,
                right: 4,
                child: Container(
                  width: 8,
                  height: 8,
                  padding: EdgeInsets.all(4),
                  alignment: .center,
                  decoration: BoxDecoration(
                    color: context.theme.colors.primary,
                    borderRadius: BorderRadius.all(.circular(24)),
                  ),
                  child: FittedBox(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
