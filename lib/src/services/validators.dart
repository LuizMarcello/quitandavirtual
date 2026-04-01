import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/string_extensions.dart';

// Validação do campo do email, para os formulários
String? emailValidator(String? email) {
  if (email == null || email.isEmpty) {
    return 'Digite seu email!';
  }
  // Usando expressão regular ".isEmail" do GetX.
  if (!email.isEmail) {
    return 'Digite um email válido';
  }
  // Está tudo OK
  return null;
}

// Validação do campo da senha, para os formulários
String? passwordValidator(String? password) {
  if (password == null || password.isEmpty) {
    return 'Digite sua senha!';
  }
  if (password.length < 8) {
    return 'Digite uma senha com mínimo de 8 caracteres!';
  }
  // Está tudo OK
  return null;
}

// Validação do campo do nome, para os formulários
String? nameValidator(String? name) {
  if (name == null || name.isEmpty) {
    return 'Digite seu nome!';
  }
  // Verificando se não é nome simples,
  // dois nomes, nome completo
  final names = name.split(' ');

  if (names.length == 1) return 'Digite seu nome completo!';
  // Está tudo OK
  return null;
}

// Validação do campo do phone, para os formulários
String? phoneValidator(String? phone) {
  if (phone == null || phone.isEmpty) {
    return 'Digite seu celular!';
  }

  if (phone.length < 14 || !phone.isPhoneNumber) {
    return 'Digite um número válido!';
  }
  // Está tudo OK
  return null;
}

// Validação do campo do cpf, para os formulários
String? cpfValidator(String? cpf) {
  if (cpf == null || cpf.isEmpty) {
    return 'Digite seu CPF';
  }

  if (!cpf.isCpf) return 'Digite um CPF válido!';
  // Está tudo OK
  return null;
}
