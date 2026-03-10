import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ibiapabaapp/features/auth/presentation/providers/session_provider.dart';
import 'package:ibiapabaapp/features/companies/domain/entities/company.dart';
import 'package:ibiapabaapp/features/companies/presentation/providers/companies_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'companies_controller.g.dart';

@riverpod
class Companies extends _$Companies {
  @override
  Future<List<Company>> build() async {
    // Aguarda a sessão estar pronta antes de qualquer requisição remota
    final session = ref.watch(sessionProvider.select((s) => s));

    // Se não está autenticado, não tenta buscar remotamente
    if (session == null) {
      return [];
    }

    return _fetchRemote();
  }

  Future<List<Company>> _fetchRemote() async {
    final getAllCompaniesUsecase = ref.read(getAllCompaniesProvider);
    final result = await getAllCompaniesUsecase();
    return result.fold((failure) => throw Exception(failure.message), (
      companies,
    ) async {
      return companies;
    });
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _fetchRemote());
  }
}
