import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:projeto_final/model/city.dart';
import 'package:projeto_final/model/client.dart';
import 'package:projeto_final/pages/city_page.dart';
import 'package:projeto_final/pages/client_page.dart';
import 'package:projeto_final/pages/list_city.dart';
import 'package:projeto_final/pages/list_client.dart';
import 'package:projeto_final/util/components.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GlobalKey<FormState> formController = GlobalKey<FormState>();
  home() {
    Navigator.of(context).pushReplacementNamed('/home');
  }

  client() {
    Navigator.of(context).push(Components().path(Client_Register()));
  }

  city() {
    Navigator.of(context).push(Components().path(City_Register()));
  }

  citysearch() {
    Navigator.of(context).push(Components().path(City_Search()));
  }

  clientsearch() {
    Navigator.of(context).push(Components().path(Client_Search()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Components().createAppBar("Cadastre-se", home),
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: Form(
          key: formController,
          child: Container(
            margin: EdgeInsets.fromLTRB(40, 60, 40, 0),
            child: Column(
              children: [
                Divider(color: Colors.black),
                Components()
                    .createButton(formController, city, "Cadastro de Cidade"),
                Components().createButton(
                    formController, citysearch, "Consulta Cidade"),
                Components().createButton(
                    formController, client, "Cadastro de Cliente"),
                Components().createButton(
                    formController, clientsearch, "Consulta Cliente"),
                Divider(
                  color: Colors.black,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
