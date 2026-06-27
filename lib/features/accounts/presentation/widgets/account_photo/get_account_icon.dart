import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:ibiapabaapp/shared/models/account_type.dart';

Icon getAccountIcon(AccountType type, BuildContext context, double size) {
  switch (type) {
    case AccountType.personal:
      return Icon(
        Icons.person_rounded,
        size: size / 1.5,
        color: context.theme.colors.secondaryForeground,
      );
    case AccountType.business:
      return Icon(
        Icons.business_rounded,
        size: size / 1.5,
        color: context.theme.colors.secondaryForeground,
      );
  }
}

Icon getUnknownAccountTypeIcon(BuildContext context, double size) {
  return Icon(
    Icons.device_unknown_rounded,
    size: size / 1.5,
    color: context.theme.colors.secondaryForeground,
  );
}
