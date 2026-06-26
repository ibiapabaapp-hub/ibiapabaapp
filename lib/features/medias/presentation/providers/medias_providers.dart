import 'package:ibiapabaapp/core/network/dio_provider.dart';
import 'package:ibiapabaapp/features/medias/data/datasource/medias_remote_datasource.dart';
import 'package:ibiapabaapp/features/medias/data/repositories/medias_repository_impl.dart';
import 'package:ibiapabaapp/features/medias/domain/repositories/medias_repository.dart';
import 'package:ibiapabaapp/features/medias/infra/medias_remote_datasource_impl.dart';
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
