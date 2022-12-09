import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:projeto_final/api/api_access.dart';
import 'package:projeto_final/model/city.dart';
import 'package:projeto_final/model/client.dart';
import 'package:projeto_final/util/box_city.dart';
import 'package:projeto_final/util/components.dart';
import 'package:projeto_final/util/radio_sexo.dart';

class Client_Register extends StatefulWidget {
  const Client_Register({Key? key}) : super(key: key);

  @override
  State<Client_Register> createState() => _ClientRegisterState();
}

class _ClientRegisterState extends State<Client_Register> {
  GlobalKey<FormState> formController = GlobalKey<FormState>();
  TextEditingController txtNome = TextEditingController();
  TextEditingController txtSexo = TextEditingController(text: 'Masculino');
  TextEditingController txtIdade = TextEditingController();
  TextEditingController txtCidade = TextEditingController();

  @override
  Widget build(BuildContext context) {
    dynamic args = {};
    if (ModalRoute.of(context)?.settings.arguments != null) {
      args = ModalRoute.of(context)?.settings.arguments as ClientModel;
      if (args.id > -1) {
        CityModel s = args.cidade as CityModel;
        txtNome.text = args.nome;
        txtIdade.text = '${args.idade}';
        txtCidade.text = '${s.id}';
        txtSexo.text = args.sexo;
      }
    }

    cadastrar() async {
      if (args is ClientModel) {
        ClientModel c = ClientModel(
            args.id,
            txtNome.text,
            txtSexo.text,
            int.parse(txtIdade.text),
            CityModel(int.parse(txtCidade.text), "", ""));
        await Gateway_API().alteraCliente(c.toJson());
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: Text('Cadastro alterado com sucesso!'),
          ),
        );
      } else {
        ClientModel c = ClientModel(
            0,
            txtNome.text,
            txtSexo.text,
            int.parse(txtIdade.text),
            CityModel(int.parse(txtCidade.text), "", ""));
        await Gateway_API().insereCliente(c.toJson());
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: Text('Cadastro realizado com sucesso!'),
          ),
        );
      }
    }

    home() {
      Navigator.of(context).pushReplacementNamed('/home');
    }

    return Scaffold(
      appBar: Components().createAppBar("Cadastro de Cliente", home),
      body: Form(
          key: formController,
          child: Column(
            children: [
              SizedBox(height: 20),
              Divider(color: Colors.black),
              Components().createInputText(
                  TextInputType.name, 'Nome', txtNome, 'Informe o nome'),
              Components().createInputText(
                  TextInputType.number, 'Idade', txtIdade, 'Informe a idade'),
              Center(child: RadioSexo(controller: txtSexo)),
              Center(child: Combo_City(controller: txtCidade)),
              SizedBox(height: 50),
              Components().createButton(formController, cadastrar, 'Cadastrar'),
            ],
          )),
    );
  }
}
