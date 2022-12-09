import 'package:projeto_final/model/city.dart';

class ClientModel {
  int id;
  String nome;
  String sexo;
  int idade;
  CityModel cidade;

  ClientModel(this.id, this.nome, this.sexo, this.idade, this.cidade);

  factory ClientModel.fromJson(dynamic json) {
    return ClientModel(
        json["id"] as int,
        json["nome"] as String,
        json["sexo"] as String,
        json["idade"] as int,
        CityModel.fromJson(json["cidade"]));
  }

  Map<String, dynamic> toJson() => {
        if (id != 0) 'id': id,
        'nome': nome,
        'sexo': sexo,
        'idade': idade,
        'cidade': cidade.toJson()
      };
}
