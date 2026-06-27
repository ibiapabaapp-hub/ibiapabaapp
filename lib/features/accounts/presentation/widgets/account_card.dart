import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:ibivibe/app/theme/custom_styles/inverted_badge.dart';
import 'package:ibivibe/shared/models/account.dart';
import 'package:ibivibe/shared/models/account_type.dart';
import 'package:ibivibe/features/accounts/presentation/widgets/account_photo/account_photo.dart';
import 'package:ibivibe/features/accounts/presentation/widgets/dialogs/account_switcher_dialog.dart';

class AccountCard extends ConsumerWidget {
  final Account account;
  const AccountCard({super.key, required this.account});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: 12,
      children: [
        AccountPhoto(key: ValueKey(account.id), account: account, size: 48),
        _AccountInfo(account: account),
        FButton.icon(
          style: FButtonStyle.ghost(),
          onPress: () {
            showAccountSwitcherSheet(context, ref);
          },
          child: const Icon(FIcons.chevronDown),
        ),
      ],
    );
  }
}

class _AccountInfo extends StatelessWidget {
  final Account account;

  const _AccountInfo({required this.account});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 4,
        children: [
          Text(
            account.displayName,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.start,
            style: TextStyle(
              color: context.theme.colors.foreground,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
          if (account.type == AccountType.personal)
            Text(
              '@${account.slug}',
              textAlign: TextAlign.start,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: context.theme.colors.mutedForeground,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          if (account.type == AccountType.business)
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
                    'Empresa',
                    style: context.theme.typography.xs.copyWith(
                      color: context.theme.colors.primaryForeground,
                    ),
                  ),
                ),
                Text(
                  'via @${account.slug}',
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
