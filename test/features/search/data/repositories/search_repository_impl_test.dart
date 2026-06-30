import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ibivibe/core/errors/failures/failures.dart';
import 'package:ibivibe/features/search/search_repository_impl.dart';
import 'package:ibivibe/features/search/models/search_result.dart';
import 'package:ibivibe/features/search/models/search_result_model.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../mocks/mocks.dart';

void main() {
  late MockSearchRemoteDatasource mockRemoteDataSource;
  late SearchRepositoryImpl sut;

  setUp(() {
    mockRemoteDataSource = MockSearchRemoteDatasource();
    sut = SearchRepositoryImpl(mockRemoteDataSource);
  });

  group('search', () {
    test('returns list of search results on success', () async {
      final models = <SearchResultModel>[];
      when(() => mockRemoteDataSource.search('test'))
          .thenAnswer((_) async => models);

      final result = await sut.search('test');

      expect(result, isA<List<SearchResult>>());
      verify(() => mockRemoteDataSource.search('test')).called(1);
    });

    test('returns empty list when no results', () async {
      when(() => mockRemoteDataSource.search('empty'))
          .thenAnswer((_) async => []);

      final result = await sut.search('empty');

      expect(result, isEmpty);
    });

    test('throws ServerFailure on DioException', () async {
      when(() => mockRemoteDataSource.search('error')).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: '/search'),
          response: Response(
            requestOptions: RequestOptions(path: '/search'),
            statusCode: 500,
            data: {'message': 'Server error'},
          ),
        ),
      );

      expect(
        () => sut.search('error'),
        throwsA(isA<ServerFailure>()),
      );
    });

    test('throws ServerFailure on generic exception', () async {
      when(() => mockRemoteDataSource.search('error'))
          .thenThrow(Exception('unexpected'));

      expect(
        () => sut.search('error'),
        throwsA(isA<ServerFailure>()),
      );
    });
  });
}
