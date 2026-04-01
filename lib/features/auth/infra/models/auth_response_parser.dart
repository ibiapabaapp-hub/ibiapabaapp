import 'package:ibiapabaapp/features/auth/domain/entities/auth_result.dart';
import 'package:ibiapabaapp/features/auth/domain/entities/user.dart';

// TODO: refatorar Parsers para Models para que todo modelo estenda entidade e cada uma tenha seu modelo
// class UserModel extends User {
//   UserModel({
//     required super.id,
//     required super.name,
//     // ... outros campos
//   });

//   // 1. De JSON para Objeto Único
//   factory UserModel.fromJson(Map<String, dynamic> json) {
//     return UserModel(
//       id: json['id'] as String,
//       name: json['name'] as String,
//     );
//   }

//   // 2. De Lista de JSON para Lista de Objetos
//   static List<UserModel> fromJsonList(List<dynamic> jsonList) {
//     return jsonList.map((item) => UserModel.fromJson(item as Map<String, dynamic>)).toList();
//   }

//   // 3. De Objeto para Map (Útil para salvar no Banco ou enviar no Body da API)
//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'name': name,
//     };
//   }
// }

class AuthResponseParser {
  static AuthResult fromJson(Map<String, dynamic> json) {
    return AuthResult(
      accessToken: json['accessToken'] as String,
      refreshToken: json['refreshToken'] as String,
      user: userFromJson(json['user'] as Map<String, dynamic>),
    );
  }

  static User userFromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      username: json['username'] as String,
      role: json['role'] as String,
      active: json['active'] as bool,
    );
  }
}
