import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:greengrocer/src/models/user_model.dart';
// Classe responsável por conter os resultados
// Data Matching” (Pattern Matching) com Freezed
// Classe responsável por conter os dois possíveis resultados
// para o método "signIn()" da classe auth_repository.dart

// Classe auto gerada
part 'auth_result.freezed.dart';

// Comando para executar: flutter pub run build_runner build

@freezed
class AuthResult with _$AuthResult {
  factory AuthResult.success(UserModel user) = Success;
  factory AuthResult.error(String message) = Error;
}
