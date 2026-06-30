import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:ibivibe/shared/models/account_type.dart';
import 'package:ibivibe/shared/providers/accounts_viewmodel.dart';
import 'package:ibivibe/features/accounts/presentation/widgets/account_card.dart';
import 'package:ibivibe/features/accounts/presentation/widgets/contents/business_account_content.dart';
import 'package:ibivibe/features/accounts/presentation/widgets/contents/personal_account_content.dart';

class AccountScreen extends ConsumerWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final account = ref.watch(accountsViewModelProvider).activeAccount;

    return SafeArea(
      child: FScaffold(
        child: SingleChildScrollView(
          child: Column(
            spacing: 12,
            children: [
              if (account != null) ...[
                AccountCard(account: account),
                const SizedBox(height: 16),
                if (account.type == AccountType.personal)
                  PersonalAccountContent(account: account)
                else if (account.type == AccountType.business)
                  BusinessAccountContent(account: account),
              ] else ...[
                const Center(child: Text('Nenhuma conta ativa')),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
