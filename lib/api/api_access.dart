import 'dart:convert';

import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart';
import 'package:projeto_final/model/city.dart';
import 'package:projeto_final/model/client.dart';
import 'package:projeto_final/pages/client_page.dart';

class Gateway_API {
  Future<List<ClientModel>> listaTodos() async {
    String url = "http://localhost:8080/cliente";
    Response resposta = await get(Uri.parse(url));
    String jsonUtf8 = (utf8.decode(resposta.bodyBytes));
    Iterable l = json.decode(jsonUtf8);
    List<ClientModel> lista =
        List<ClientModel>.from(l.map((e) => ClientModel.fromJson(e)));
    return lista;
  }

  Future<List<ClientModel>> buscarPorCidade(String cidade) async {
    String url = "http://localhost:8080/cliente/$cidade";
    Response reposta = await get(Uri.parse(url));
    String jsonFormatadoUft8 = (utf8.decode(reposta.bodyBytes));
    Iterable l = json.decode(jsonFormatadoUft8);
    List<ClientModel> clienteCidade =
        List<ClientModel>.from(l.map((c) => ClientModel.fromJson(c)));
    return clienteCidade;
  }

  Future<void> insereCliente(Map<String, dynamic> cliente) async {
    String url = "http://localhost:8080/cliente";
    Map<String, String> headers = {
      "Content-Type": "application/json; charset=UTF-8"
    };
    await post(Uri.parse(url), headers: headers, body: jsonEncode(cliente));
  }

  Future<void> alteraCliente(Map<String, dynamic> cliente) async {
    String url = "http://localhost:8080/cliente";
    Map<String, String> headers = {
      "Content-Type": "application/json; charset=UTF-8"
    };
    await put(Uri.parse(url), headers: headers, body: jsonEncode(cliente));
  }

  Future<void> excluirCliente(int id) async {
    String url = "http://localhost:8080/cliente/$id";
    await delete(Uri.parse(url));
  }

  Future<List<CityModel>> listaCidades() async {
    String url = 'http://localhost:8080/cidade';
    Response resposta = await get(Uri.parse(url));
    String jsonFormatadoUft8 = (utf8.decode(resposta.bodyBytes));
    Iterable l = json.decode(jsonFormatadoUft8);
    List<CityModel> cidades =
        List<CityModel>.from(l.map((c) => CityModel.fromJson(c)));
    return cidades;
  }

  Future<List<CityModel>> buscarPorUf(String uf) async {
    String url = "http://localhost:8080/cidade/$uf";
    Response reposta = await get(Uri.parse(url));
    String jsonFormatadoUft8 = (utf8.decode(reposta.bodyBytes));
    Iterable l = json.decode(jsonFormatadoUft8);
    List<CityModel> cidadeUf =
        List<CityModel>.from(l.map((c) => CityModel.fromJson(c)));
    return cidadeUf;
  }

  Future<void> insereCidade(Map<String, dynamic> cidade) async {
    String url = "http://localhost:8080/cidade";
    Map<String, String> headers = {
      "Content-Type": "application/json; charset=UTF-8"
    };
    await post(Uri.parse(url), headers: headers, body: jsonEncode(cidade));
  }

  Future<void> alteraCidade(Map<String, dynamic> cidade) async {
    String url = "http://localhost:8080/cidade";
    Map<String, String> headers = {
      "Content-Type": "application/json; charset=UTF-8"
    };
    await put(Uri.parse(url), headers: headers, body: jsonEncode(cidade));
  }

  Future<void> excluirCidade(int id) async {
    String url = 'http://localhost:8080/cidade/$id';
    await delete(Uri.parse(url));
  }
}
