import 'package:collection/collection.dart';
import 'package:ibivibe/core/errors/failures/failures.dart';
import 'package:ibivibe/core/logger/handlers/controller_log_handler.dart';
import 'package:ibivibe/core/logger/log_tags.dart';
import 'package:ibivibe/core/logger/logger.dart';
import 'package:ibivibe/shared/models/account.dart';
import 'package:ibivibe/features/accounts/models/account_interests.dart';
import 'package:ibivibe/features/accounts/accounts_logtags.dart';
import 'package:ibivibe/features/accounts/presentation/providers/accounts_providers.dart';
import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'accounts_state_provider.g.dart';

@Riverpod(keepAlive: true)
class AccountsState extends _$AccountsState with ControllerLogHandler {
  @override
  late final Logger logger = ref.read(loggerProvider);

  @override
  LogFeature get feature => LogFeature.accounts;

  @override
  AccountsData build() => const AccountsData();

  Future<void> onAuthSuccess(Account account) async {
    final repository = ref.read(accountsRepositoryProvider);
    final interests = await _getAccountInterests(account.id);

    Account composedAccount = account;

    if (interests != null) {
      composedAccount = Account(
        id: account.id,
        email: account.email,
        phoneNumber: account.phoneNumber,
        name: account.name,
        active: account.active,
        isVerified: account.isVerified,
        createdAt: account.createdAt,
        updatedAt: account.updatedAt,
        slug: account.slug,
        displayName: account.displayName,
        bio: account.bio,
        avatarUrl: account.avatarUrl,
        type: account.type,
        interests: interests,
        business: account.business,
        gender: account.gender,
      );
    }

    await repository.addCachedAccount(composedAccount);
    await repository.saveActiveAccountId(composedAccount.id);
    state = state.copyWith(
      activeAccountId: composedAccount.id,
      activeAccount: composedAccount,
    );
    await loadCachedAccounts();
  }

  Future<AccountInterests?> _getAccountInterests(String accountId) async {
    state = state.copyWith(isLoading: true);
    try {
      final repository = ref.read(accountsRepositoryProvider);
      final interests = await repository.getAccountInterests(accountId);
      state = state.copyWith(isLoading: false);
      logControllerSuccess(action: AccountsAction.getAccountInterests);
      return interests;
    } catch (e) {
      final failure = e is AppFailure ? e : InternalFailure(e.toString());
      state = state.copyWith(isLoading: false);
      logControllerError(
        action: AccountsAction.getAccountInterests,
        failure: failure,
      );
      return null;
    }
  }

  Future<String?> restoreFromCache() async {
    final cached = await ref
        .read(accountsLocalStorageProvider)
        .getCachedAccounts();
    final activeId = await ref
        .read(accountsLocalStorageProvider)
        .getActiveAccountId();
    if (!ref.mounted) return null;

    if (cached.isEmpty || activeId == null) {
      state = state.copyWith(isLoading: false);
      return null;
    }

    state = AccountsData(
      isLoading: false,
      cachedAccounts: cached,
      activeAccountId: activeId,
      activeAccount: cached.firstWhereOrNull((a) => a.id == activeId),
    );
    logControllerSuccess(action: AccountsAction.restoreFromCache);
    return activeId;
  }

  Future<void> onLogout(String accountId) async {
    final repository = ref.read(accountsRepositoryProvider);
    await repository.removeCachedAccount(accountId);
    await repository.clearActiveAccountId();
    await loadCachedAccounts();
  }

  Future<void> loadCachedAccounts() async {
    state = state.copyWith(isLoading: true);
    try {
      final repository = ref.read(accountsRepositoryProvider);
      final accounts = await repository.getCachedAccounts();
      if (!ref.mounted) return;

      final currentActiveId = state.activeAccountId;
      state = state.copyWith(
        isLoading: false,
        cachedAccounts: accounts,
        activeAccount: accounts.firstWhereOrNull(
          (a) => a.id == currentActiveId,
        ),
      );
      logControllerSuccess(action: AccountsAction.getCachedAccounts);
    } catch (e) {
      if (!ref.mounted) return;
      final failure = e is AppFailure ? e : InternalFailure(e.toString());
      logControllerError(
        action: AccountsAction.getCachedAccounts,
        failure: failure,
      );
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> switchAccount(String accountId) async {
    try {
      final repository = ref.read(accountsRepositoryProvider);
      await repository.saveActiveAccountId(accountId);
      if (!ref.mounted) return;

      state = state.copyWith(
        isLoading: false,
        activeAccountId: accountId,
        activeAccount: state.cachedAccounts.firstWhereOrNull(
          (a) => a.id == accountId,
        ),
      );
      logControllerSuccess(action: AccountsAction.switchAccount);
    } catch (e) {
      if (!ref.mounted) return;
      final failure = e is AppFailure ? e : InternalFailure(e.toString());
      logControllerError(
        action: AccountsAction.switchAccount,
        failure: failure,
      );
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> removeAccountFromCache(String accountId) async {
    state = state.copyWith(isLoading: true);
    try {
      final repository = ref.read(accountsRepositoryProvider);
      await repository.removeAccount(accountId);
      if (!ref.mounted) return;

      final updated = state.cachedAccounts
          .where((a) => a.id != accountId)
          .toList();
      state = state.copyWith(
        isLoading: false,
        cachedAccounts: updated,
        clearActiveAccount: state.activeAccount?.id == accountId,
      );
      logControllerSuccess(action: AccountsAction.removeCachedAccount);
    } catch (e) {
      if (!ref.mounted) return;
      final failure = e is AppFailure ? e : InternalFailure(e.toString());
      logControllerError(
        action: AccountsAction.removeCachedAccount,
        failure: failure,
      );
      state = state.copyWith(isLoading: false);
    }
  }

  void markLoadingDone() {
    state = state.copyWith(isLoading: false);
  }
}

class AccountsData {
  final Account? activeAccount;
  final String? activeAccountId;
  final List<Account> cachedAccounts;
  final bool isLoading;

  const AccountsData({
    this.activeAccount,
    this.activeAccountId,
    this.cachedAccounts = const [],
    this.isLoading = true,
  });

  bool get hasMultipleAccounts => cachedAccounts.length > 1;

  AccountsData copyWith({
    Account? activeAccount,
    String? activeAccountId,
    List<Account>? cachedAccounts,
    bool clearActiveAccount = false,
    bool? isLoading,
  }) {
    return AccountsData(
      activeAccount: clearActiveAccount
          ? null
          : (activeAccount ?? this.activeAccount),
      activeAccountId: clearActiveAccount
          ? null
          : (activeAccountId ?? this.activeAccountId),
      cachedAccounts: cachedAccounts ?? this.cachedAccounts,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
