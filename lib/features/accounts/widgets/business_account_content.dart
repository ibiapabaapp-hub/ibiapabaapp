import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:ibivibe/core/beta/presentation/screens/under_development_screen.dart';
import 'package:ibivibe/shared/models/account.dart';
import 'package:ibivibe/features/accounts/widgets/business_sections.dart';
import 'package:ibivibe/shared/ui/layout/section_header.dart';

class BusinessAccountContent extends StatelessWidget {
  final Account account;
  const BusinessAccountContent({super.key, required this.account});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 16,
      children: [
        SectionHeader(
          title: 'Dados da Empresa',
          seeAllText: 'Editar',
          onSeeAllTap: () =>
              redirectToUnderDevelopment(context, 'Dados da Empresa'),
        ),
        BusinessDataSection(account: account),

        const FDivider(),
        SectionHeader(
          title: 'Gerenciamento',
          seeAllText: 'Ajuda',
          onSeeAllTap: () =>
              redirectToUnderDevelopment(context, 'Gerenciamento'),
        ),
        const BusinessManagementSection(),

        const FDivider(),
        SectionHeader(
          title: 'Configurações rápidas',
          seeAllText: 'Ajuda',
          onSeeAllTap: () =>
              redirectToUnderDevelopment(context, 'Configurações'),
        ),
        const QuickSettingsSection(),

        const FDivider(),
        SectionHeader(
          title: 'Informações do Aplicativo',
          seeAllText: 'Ajuda',
          onSeeAllTap: () => redirectToUnderDevelopment(context, 'Informações'),
        ),
        const AppInfoSection(),
      ],
    );
  }
}
