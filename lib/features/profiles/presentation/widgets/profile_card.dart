import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:ibiapabaapp/app/theme/custom_styles/inverted_badge.dart';
import 'package:ibiapabaapp/features/profiles/domain/entities/profile.dart';
import 'package:ibiapabaapp/features/profiles/presentation/dialogs/profile_switcher_dialog.dart';
import 'package:ibiapabaapp/features/profiles/presentation/widgets/profile_photo.dart';

class ProfileCard extends ConsumerWidget {
  final Profile profile;
  const ProfileCard({super.key, required this.profile});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisSize: .min,
      mainAxisAlignment: .start,
      crossAxisAlignment: .center,
      spacing: 12,
      children: [
        ProfilePhoto(profile: profile, imgSize: 48),
        _ProfileInfo(profile: profile),
        FButton.icon(
          style: FButtonStyle.ghost(),
          onPress: () {
            showProfileSwitcherSheet(context, ref);
          },
          child: const Icon(FIcons.chevronDown),
        ),
      ],
    );
  }
}

class _ProfileInfo extends StatelessWidget {
  final Profile profile;

  const _ProfileInfo({required this.profile});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisSize: .max,
        mainAxisAlignment: .start,
        crossAxisAlignment: .start,
        spacing: 4,
        children: [
          Text(
            profile.displayName,
            overflow: .ellipsis,
            textAlign: .start,
            style: TextStyle(
              color: context.theme.colors.foreground,
              fontSize: 16,
              fontWeight: .w400,
            ),
          ),
          if (profile.type == ProfileType.personal)
            Text(
              '@${profile.displayName}',
              textAlign: .start,
              overflow: .ellipsis,
              style: TextStyle(
                color: context.theme.colors.mutedForeground,
                fontSize: 14,
                fontWeight: .w400,
              ),
            ),
          if (profile.type == ProfileType.business)
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 8,
              runSpacing: 8,
              children: [
                FBadge(
                  style: getInvertedBadgeStyle(
                    context.theme.colors,
                    context.theme.typography,
                  ).call,
                  child: Text(
                    profile.businessRole!.name,
                    style: context.theme.typography.xs.copyWith(
                      color: context.theme.colors.primaryForeground,
                    ),
                  ),
                ),
                Text(
                  'via @${profile.slug}',
                  style: context.theme.typography.xs.copyWith(
                    color: context.theme.colors.mutedForeground,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
