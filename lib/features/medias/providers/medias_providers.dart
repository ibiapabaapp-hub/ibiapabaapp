import 'package:ibivibe/core/network/dio_provider.dart';
import 'package:ibivibe/features/medias/medias_remote_datasource.dart';
import 'package:ibivibe/features/medias/medias_repository_impl.dart';
import 'package:ibivibe/features/medias/medias_repository.dart';
import 'package:ibivibe/features/medias/medias_remote_datasource_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'medias_providers.g.dart';

@riverpod
MediasRemoteDatasource mediasRemoteDatasource(Ref ref) {
  final dio = ref.watch(dioProvider);
  return MediasRemoteDatasourceImpl(dio);
}

@riverpod
MediasRepository mediasRepository(Ref ref) {
  final datasource = ref.watch(mediasRemoteDatasourceProvider);
  return MediasRepositoryImpl(remoteDatasource: datasource);
}
