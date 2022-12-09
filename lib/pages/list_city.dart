import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:projeto_final/api/api_access.dart';
import 'package:projeto_final/model/city.dart';
import 'package:projeto_final/model/client.dart';
import 'package:projeto_final/util/components.dart';

class City_Search extends StatefulWidget {
  const City_Search({Key? key}) : super(key: key);

  @override
  State<City_Search> createState() => _CitySearchState();
}

class _CitySearchState extends State<City_Search> {
  GlobalKey<FormState> formController = GlobalKey<FormState>();
  List<CityModel> lista = [];
  TextEditingController txtUf = TextEditingController();
  bool checkSpecialField = false;

  @override
  Widget build(BuildContext context) {
    home() {
      Navigator.of(context).pushReplacementNamed('/home');
    }

    listAll() async {
      List<CityModel> cidades = await Gateway_API().listaCidades();
      setState(() {
        lista = cidades;
      });
    }

    listForUF() async {
      List<CityModel> cidade = await Gateway_API().buscarPorUf(txtUf.text);
      setState(() {
        lista = cidade;
      });
    }

    notifyChange(String value) {
      if (value != '') {
        setState(() {
          checkSpecialField = true;
        });
      } else {
        setState(() {
          checkSpecialField = false;
        });
      }
    }

    return Scaffold(
      appBar: Components().createAppBar("Lista de Cidades", home),
      body: Form(
        key: formController,
        child: Column(
          children: [
            SizedBox(height: 20),
            Divider(color: Colors.black),
            Components().dynamicInputText(TextInputType.text, 'Informe a UF:',
                txtUf, 'O campo não pode ficar vazio!', notifyChange),
            Components().dynamicButton(
                formController, listForUF, 'Filtro por UF', checkSpecialField),
            Components().createButton(formController, listAll, 'Listar Todas'),
            Expanded(
              child: Container(
                child: ListView.builder(
                    itemCount: lista.length,
                    itemBuilder: (context, indice) {
                      return Card(
                        elevation: 6,
                        margin: const EdgeInsets.all(5),
                        child:
                            Components().cityItem(lista[indice], context, null),
                      );
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
