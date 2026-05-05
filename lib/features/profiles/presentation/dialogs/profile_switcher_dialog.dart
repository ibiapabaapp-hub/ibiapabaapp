import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import 'package:ibiapabaapp/app/theme/custom_styles/inverted_badge.dart';
import 'package:ibiapabaapp/features/profiles/domain/entities/profile.dart';
import 'package:ibiapabaapp/features/profiles/domain/entities/profile_extensions.dart';
import 'package:ibiapabaapp/features/profiles/presentation/providers/profile_state_provider.dart';
import 'package:ibiapabaapp/features/profiles/presentation/widgets/profile_photo.dart';
import 'package:ibiapabaapp/features/profiles/presentation/widgets/screens/profile_screen.dart';
import 'package:ibiapabaapp/shared/ui/layout/sheet_drag_indicator.dart';

void showProfileSwitcherSheet(BuildContext context, WidgetRef ref) {
  showModalBottomSheet(
    context: context,
    useRootNavigator: true,
    backgroundColor: Colors.transparent,
    enableDrag: true,
    isDismissible: true,
    isScrollControlled: true,
    builder: (context) => const _ProfileSwitcherSheetContent(),
  );
}

// ─── Sheet ────────────────────────────────────────────────────────────────────
class _ProfileSwitcherSheetContent extends ConsumerWidget {
  const _ProfileSwitcherSheetContent();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeProfile = ref.watch(profileStateProvider).activeProfile;
    final profiles = ref.watch(profileStateProvider).profiles;

    final personalProfile = profiles.firstWhereOrNull(
      (p) => p.type == ProfileType.personal,
    );

    final businessProfiles = profiles.where(
      (p) => p.type == ProfileType.business && p.business != null,
    );

    // guard: sheet não renderiza enquanto perfis não estiverem prontos
    if (personalProfile == null) {
      return const SafeArea(child: Center(child: CircularProgressIndicator()));
    }

    return SafeArea(
      child: Container(
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height * 0.64,
        ),
        decoration: BoxDecoration(
          color: context.theme.colors.background,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SheetDragIndicator(),
            const SizedBox(height: 16),
            Text(
              'Alternar perfil',
              style: context.theme.typography.sm.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const FDivider(),

            // ─── Perfil pessoal ───────────────────────────────────────────
            _ProfileTile(
              profile: personalProfile,
              name: personalProfile.displayName,
              subtitle: '@${personalProfile.slug}',
              isSelected: activeProfile == personalProfile,
              onTap: () {
                ref
                    .read(profileStateProvider.notifier)
                    .switchToProfile(personalProfile);
                context.pop();
              },
            ),

            // ─── Perfis de empresa ────────────────────────────────────────
            ...businessProfiles.map((b) {
              final business = b.toBusiness();
              return _ProfileTile(
                profile: b,
                name: business!.name,
                subtitle: b.businessRole!.name,
                isSelected: activeProfile == b,
                onTap: () {
                  ref.read(profileStateProvider.notifier).switchToProfile(b);
                  context.pop();
                },
              );
            }),

            FTile(
              style: (style) => style.copyWith(
                decoration: FWidgetStateMap.all(
                  BoxDecoration(color: context.theme.colors.background),
                ),
                contentStyle: (style) => style.copyWith(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 16,
                  ),
                ),
              ),
              onPress: () {
                showTodoToast(context, 'Criar perfil');
              },
              prefix: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: context.theme.colors.secondary,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  FIcons.plus,
                  color: context.theme.colors.secondaryForeground,
                ),
              ),
              title: Text(
                'Criar perfil',
                style: context.theme.typography.sm.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

// ─── Tile ────────────────────────────────────────────────────────────────────
class _ProfileTile extends StatelessWidget {
  final Profile? profile;
  final String name;
  final String subtitle;
  final bool isSelected;
  final VoidCallback onTap;

  const _ProfileTile({
    this.profile,
    required this.name,
    required this.subtitle,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return FTile(
      style: (style) => style.copyWith(
        decoration: FWidgetStateMap.all(
          BoxDecoration(
            borderRadius: .circular(12),
            color: isSelected
                ? context.theme.colors.primary.withAlpha(16)
                : context.theme.colors.background,
          ),
        ),
        contentStyle: (style) => style.copyWith(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        ),
      ),
      onPress: onTap,
      prefix: ProfilePhoto(
        profile: profile,
        imgSize: 40,
        isSelected: isSelected,
      ),
      title: Text(
        name,
        style: context.theme.typography.sm.copyWith(
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: profile!.type == ProfileType.personal
          ? Text(
              subtitle,
              style: context.theme.typography.xs.copyWith(
                color: context.theme.colors.mutedForeground,
              ),
            )
          : FBadge(
              style: getInvertedBadgeStyle(
                context.theme.colors,
                context.theme.typography,
              ).call,
              child: Text(
                subtitle,
                style: context.theme.typography.xs.copyWith(
                  color: context.theme.colors.background,
                ),
              ),
            ),
      suffix: isSelected
          ? Icon(FIcons.check, color: context.theme.colors.primary, size: 24)
          : null,
    );
  }
}
