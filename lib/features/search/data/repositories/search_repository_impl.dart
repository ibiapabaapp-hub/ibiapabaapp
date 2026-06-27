import 'package:dio/dio.dart';
import 'package:ibivibe/core/errors/failures/failures.dart';
import 'package:ibivibe/features/search/data/datasources/search_remote_datasource.dart';
import 'package:ibivibe/features/search/domain/entities/search_result.dart';
import 'package:ibivibe/features/search/domain/repositories/search_repository.dart';

class SearchRepositoryImpl implements SearchRepository {
  final SearchRemoteDatasource remoteDataSource;

  SearchRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<SearchResult>> search(String query) async {
    try {
      final models = await remoteDataSource.search(query);
      return models.map((m) => m.toEntity()).toList();
    } on DioException catch (e) {
      throw ServerFailure(e.message ?? 'Erro na busca');
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }
}
