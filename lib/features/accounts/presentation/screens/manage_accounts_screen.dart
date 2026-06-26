import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import 'package:ibiapabaapp/shared/models/account.dart';
import 'package:ibiapabaapp/features/accounts/presentation/providers/accounts_state_provider.dart';
import 'package:ibiapabaapp/shared/ui/layout/beautiful_background_overlay.dart';

class ManageAccountsScreen extends ConsumerWidget {
  const ManageAccountsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accountsState = ref.watch(accountsStateProvider);
    final accounts = accountsState.cachedAccounts;
    final activeAccountId = accountsState.activeAccountId;
    final isLoading = accountsState.isLoading;

    return SafeArea(
      child: FScaffold(
        header: _getHeader(context),
        child: BeautifulBackgroundOverlay(
          opacity: .12,
          childBelow: true,
          child: Column(
            crossAxisAlignment: .start,
            spacing: 16,
            children: [
              FButton(
                style: FButtonStyle.outline(),
                onPress: () {
                  context.push('/app/auth/register');
                },
                child: const Text('Adicionar conta'),
              ),
              Expanded(
                child: isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : accounts.isEmpty
                    ? const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.account_circle, size: 64),
                            SizedBox(height: 16),
                            Text('Nenhuma conta encontrada'),
                          ],
                        ),
                      )
                    : ListView.builder(
                        itemCount: accounts.length,
                        itemBuilder: (context, index) {
                          final account = accounts[index];
                          final isActive = account.id == activeAccountId;

                          return Card(
                            margin: const EdgeInsets.only(bottom: 12),
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundImage: account.avatarUrl != null
                                    ? NetworkImage(account.avatarUrl!)
                                    : null,
                                child: account.avatarUrl == null
                                    ? Text(account.displayName[0].toUpperCase())
                                    : null,
                              ),
                              title: Text(account.displayName),
                              subtitle: Text(account.email),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  if (isActive)
                                    FBadge(child: const Text('Ativa')),
                                  if (!isActive)
                                    IconButton(
                                      icon: const Icon(Icons.delete_outline),
                                      onPressed: () {
                                        _showDeleteConfirmation(
                                          context,
                                          ref,
                                          account,
                                        );
                                      },
                                    ),
                                ],
                              ),
                              onTap: () {
                                if (!isActive) {
                                  ref
                                      .read(accountsStateProvider.notifier)
                                      .switchAccount(account.id);
                                  context.pop();
                                }
                              },
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getHeader(BuildContext context) {
    return FHeader.nested(
      prefixes: [
        FButton.icon(
          style: FButtonStyle.ghost(),
          onPress: () => context.pop(),
          child: const Icon(Icons.arrow_back, size: 24),
        ),
      ],
      titleAlignment: .centerStart,
      title: Text('Minhas contas', style: context.theme.typography.xl),
    );
  }

  void _showDeleteConfirmation(
    BuildContext context,
    WidgetRef ref,
    Account account,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Remover conta'),
        content: Text(
          'Deseja remover a conta ${account.displayName}? Esta ação não pode ser desfeita.',
        ),
        actions: [
          TextButton(
            onPressed: () => context.pop(),
            child: const Text('Cancelar'),
          ),
          FButton(
            style: FButtonStyle.destructive(),
            onPress: () {
              ref
                  .read(accountsStateProvider.notifier)
                  .removeAccountFromCache(account.id);
              context.pop();
            },
            child: const Text('Remover'),
          ),
        ],
      ),
    );
  }
}
