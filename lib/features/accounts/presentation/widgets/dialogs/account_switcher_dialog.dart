import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import 'package:ibivibe/app/theme/custom_styles/inverted_badge.dart';
import 'package:ibivibe/shared/models/account.dart';
import 'package:ibivibe/shared/models/account_type.dart';
import 'package:ibivibe/shared/providers/accounts_state_provider.dart';
import 'package:ibivibe/features/accounts/presentation/widgets/account_photo/account_photo.dart';
import 'package:ibivibe/shared/ui/layout/sheet_drag_indicator.dart';

void showAccountSwitcherSheet(BuildContext context, WidgetRef ref) {
  showModalBottomSheet(
    context: context,
    useRootNavigator: true,
    backgroundColor: Colors.transparent,
    enableDrag: true,
    isDismissible: true,
    isScrollControlled: true,
    builder: (context) => const _AccountSwitcherSheetContent(),
  );
}

// ─── Sheet ────────────────────────────────────────────────────────────────────
class _AccountSwitcherSheetContent extends ConsumerWidget {
  const _AccountSwitcherSheetContent();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accountsState = ref.watch(accountsStateProvider);
    final activeAccount = accountsState.activeAccount;
    final cachedAccounts = accountsState.cachedAccounts;

    if (cachedAccounts.isEmpty) {
      return const SafeArea(child: Center(child: CircularProgressIndicator()));
    }

    final personalAccounts = cachedAccounts.where(
      (a) => a.type == AccountType.personal,
    );

    final businessAccounts = cachedAccounts.where(
      (a) => a.type == AccountType.business,
    );

    return SafeArea(
      child: Container(
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height * 0.7,
          maxHeight: MediaQuery.of(context).size.height * 0.8,
        ),
        decoration: BoxDecoration(
          color: context.theme.colors.background,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SheetDragIndicator(),
              const SizedBox(height: 16),
              Text(
                'Alternar conta',
                style: context.theme.typography.sm.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),

              // ─── Contas pessoais ────────────────────────────────────────────
              if (personalAccounts.isNotEmpty) ...[
                _buildSectionHeader(context, 'Contas pessoais'),
                ...personalAccounts.map(
                  (account) => _AccountTile(
                    account: account,
                    name: account.displayName,
                    subtitle: '@${account.slug}',
                    isSelected: activeAccount?.id == account.id,
                    onTap: () {
                      ref
                          .read(accountsStateProvider.notifier)
                          .switchAccount(account.id);
                      context.pop();
                    },
                  ),
                ),
              ],

              // ─── Contas empresariais ───────────────────────────────────────
              if (businessAccounts.isNotEmpty) ...[
                _buildSectionHeader(context, 'Contas empresariais'),
                ...businessAccounts.map(
                  (account) => _AccountTile(
                    account: account,
                    name: account.displayName,
                    subtitle: account.business?.document != null
                        ? 'CNPJ: ${_formatCnpj(account.business!.document!)}'
                        : 'Conta empresarial',
                    isSelected: activeAccount?.id == account.id,
                    onTap: () {
                      ref
                          .read(accountsStateProvider.notifier)
                          .switchAccount(account.id);
                      context.pop();
                    },
                  ),
                ),
              ],

              const SizedBox(height: 16),
              const FDivider(),

              // ─── Adicionar nova conta ──────────────────────────────────────
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
                  context.push('/auth/login');
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
                  'Adicionar conta',
                  style: context.theme.typography.sm.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              // ─── Gerenciar contas ──────────────────────────────────────────
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
                  context.push('/app/accounts/manage');
                  context.pop();
                },
                prefix: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: context.theme.colors.muted,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    FIcons.settings,
                    color: context.theme.colors.foreground,
                  ),
                ),
                title: Text(
                  'Gerenciar contas',
                  style: context.theme.typography.sm.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 16, 12, 8),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: context.theme.typography.xs.copyWith(
            color: context.theme.colors.mutedForeground,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  String _formatCnpj(String cnpj) {
    if (cnpj.length != 14) return cnpj;
    return '${cnpj.substring(0, 2)}.${cnpj.substring(2, 5)}.${cnpj.substring(5, 8)}/${cnpj.substring(8, 12)}-${cnpj.substring(12, 14)}';
  }
}

// ─── Tile ────────────────────────────────────────────────────────────────────
class _AccountTile extends StatelessWidget {
  final Account account;
  final String name;
  final String subtitle;
  final bool isSelected;
  final VoidCallback onTap;

  const _AccountTile({
    required this.account,
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
            borderRadius: BorderRadius.circular(12),
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
      prefix: AccountPhoto(key: ValueKey(account.id), account: account, size: 40, isSelected: isSelected),
      title: Text(
        name,
        style: context.theme.typography.sm.copyWith(
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: account.type == AccountType.personal
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
                'Empresa',
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
