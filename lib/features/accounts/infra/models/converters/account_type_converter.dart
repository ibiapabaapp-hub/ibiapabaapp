import 'package:json_annotation/json_annotation.dart';
import '../../../domain/entities/account_type.dart';

class AccountTypeConverter implements JsonConverter<AccountType, String> {
  const AccountTypeConverter();

  @override
  AccountType fromJson(String json) {
    return AccountType.fromString(json);
  }

  @override
  String toJson(AccountType object) {
    return object.value;
  }
}
