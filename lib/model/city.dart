class CityModel {
  int id;
  String nome;
  String uf;

  CityModel(this.id, this.nome, this.uf);

  factory CityModel.fromJson(dynamic json) {
    return CityModel(
        json["id"] as int, json["nome"] as String, json["uf"] as String);
  }
  Map<String, dynamic> toJson() =>
      {if (id != 0) 'id': id, 'nome': nome, 'uf': uf};
}
