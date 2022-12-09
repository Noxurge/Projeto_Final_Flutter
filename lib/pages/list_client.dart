import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:projeto_final/api/api_access.dart';
import 'package:projeto_final/model/city.dart';
import 'package:projeto_final/model/client.dart';
import 'package:projeto_final/util/box_city.dart';
import 'package:projeto_final/util/components.dart';

class Client_Search extends StatefulWidget {
  const Client_Search({Key? key}) : super(key: key);

  @override
  State<Client_Search> createState() => _ClientSearchState();
}

class _ClientSearchState extends State<Client_Search> {
  GlobalKey<FormState> formController = GlobalKey<FormState>();
  List<ClientModel> lista = [];
  TextEditingController txtNome = TextEditingController();
  bool checkSpecialField = false;

  @override
  Widget build(BuildContext context) {
    home() {
      Navigator.of(context).pushReplacementNamed('/home');
    }

    listAll() async {
      List<ClientModel> pessoas = await Gateway_API().listaTodos();
      setState(() {
        lista = pessoas;
      });
    }

    listForCity() async {
      List<ClientModel> cliente =
          await Gateway_API().buscarPorCidade(txtNome.text);
      setState(() {
        lista = cliente;
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
      appBar: Components().createAppBar("Lista de Clientes", home),
      body: Form(
        key: formController,
        child: Column(
          children: [
            SizedBox(height: 20),
            Divider(color: Colors.black),
            Components().dynamicInputText(
                TextInputType.text,
                'Informe a cidade:',
                txtNome,
                'O campo não pode ficar vazio!',
                notifyChange),
            Components().dynamicButton(formController, listForCity,
                'Filtro por cidade', checkSpecialField),
            Components().createButton(formController, listAll, "Listar Todas"),
            Expanded(
              child: Container(
                child: ListView.builder(
                    itemCount: lista.length,
                    itemBuilder: (context, indice) {
                      return Card(
                        elevation: 6,
                        margin: const EdgeInsets.all(5),
                        child: Components().clientItem(lista[indice], context),
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
