import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:ibivibe/shared/models/account.dart';
import 'package:ibivibe/features/accounts/presentation/widgets/account_photo/get_account_icon.dart';

class AccountPhoto extends StatelessWidget {
  final Account? account;
  final double size;
  final bool isSelected;
  final Color? borderColor;

  const AccountPhoto({
    required this.account,
    super.key,
    required this.size,
    this.isSelected = false,
    this.borderColor,
  });

  Widget _getAccountPhoto(BuildContext context, Account? account, double size) {
    if (account == null) {
      return getUnknownAccountTypeIcon(context, size);
    }

    if (account.avatarUrl == null) {
      return getAccountIcon(account.type, context, size);
    }

    return ClipOval(
      child: Image.network(
        errorBuilder: (context, error, stackTrace) {
          return getAccountIcon(account.type, context, size);
        },
        account.avatarUrl!,
        width: size,
        height: size,
        cacheWidth: (size * 2).toInt(),
        cacheHeight: (size * 2).toInt(),
        fit: BoxFit.cover,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final child = Container(
      width: size,
      height: size,
      decoration: ShapeDecoration(
        color: context.theme.colors.secondary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      ),
      child: _getAccountPhoto(context, account, size),
    );

    if (!isSelected) return child;

    return Container(
      width: size + 3,
      height: size + 3,
      alignment: Alignment.center,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
          side: BorderSide(
            color: borderColor ?? context.theme.colors.primary,
            width: 2,
          ),
        ),
      ),
      child: child,
    );
  }
}
