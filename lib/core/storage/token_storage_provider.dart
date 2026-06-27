import 'package:ibivibe/core/storage/token_storage_impl.dart';
import 'package:ibivibe/core/storage/token_storage_strategy.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'token_storage_provider.g.dart';

@riverpod
TokenStorageStrategy tokenStorage(Ref ref) {
  return TokenStorageImpl.instance;
}
