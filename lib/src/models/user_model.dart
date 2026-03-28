import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

// Classe userModel mapeada pelo json_serializable

// @JsonSerializable(createJsonSchema: true)
@JsonSerializable()
class UserModel {
  // Recurso do JsonSerializable
  // Mudando o nome no momento da conversão
  // Nome presente no Map<>{} (fullname) que será
  // jogado para o atributo "name" da classe
  @JsonKey(name: 'fullname')
  String? name;
  String? email;
  String? phone;
  String? cpf;
  String? password;
  String? id;
  String? token;

  UserModel({
    this.name,
    this.email,
    this.phone,
    this.cpf,
    this.password,
    this.id,
    this.token,
  });

  // plugin "build_runner"
  // Este comando constrói(gera) os fromJson e toJson abaixo
  // e contrói(gera) também o arquivo "user_model.g.dart"
  // flutter pub run build_runner build

  // MAPEAENDO PELO JSON_SERIALIZABLE
  /// Connect the generated [_$PersonFromJson] function to the `fromJson`
  /// factory.
  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  // MAPEAENDO PELO JSON_SERIALIZABLE
  /// Connect the generated [_$UserModelToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$UserModelToJson(this);

// FAZENDO MANUALMENTE
  // Convertendo o Map<>{} da resposta, com todos os
  // atributos do usuário, para esta classe. A cada
  // um dos atributos deste Map<> da resposta,
  // será atribuido um dos atributos desta classe
  // Um factory:
  // fromMap(): Converte de um Map<>{}, para um objeto
  // (de uma determinada classe)
  // factory UserModel.fromMap(Map<String, dynamic> map) {
  // Este factory retorna um objeto "UserModel"
  // return UserModel(
  // Esquerda: Os atributos desta classe
  // Da direita: Os atributos vindos do map<> do parâmetro
  // cpf: map['cpf'],
  // email: map['email'],
  // id: map['id'],
  // name: map['fullname'],
  // password: map['password'],
  // phone: map['phone'],
  // token: map['token'],
  // );

// FAZENDO MANUALMENTE
// toMap():Convertendo de um objeto(de uma
// determinada classe), para um Map<>{}
// Retorna um Map<String, dynamic>
// Map<String, dynamic> toMap() {
// return
// Abrindo e fechando o Map<>{} retornado
// Esquerda: Os atributos do Map<>{} a ser retornado
// Da direita: Os atributos desta class
// {
//   'cpf': cpf,
//   'email': email,
//   'id': id,
//   'fullname': name,
//   'password': password,
//   'phone': phone,
//   'token': token,
// };
// }

// Isso aqui vai printar sempre que pedir-mos
// para printar o objeto "UserModel" desta classe
// No caso, vai imprimir todos os atributos do usuário
// Está subscrevendo o toString original da classe
  @override
  String toString() {
    return 'UserModel(name: $name, email: $email, phone: $phone, cpf: $cpf, password: $password, id: $id, token: $token)';
  }
}
