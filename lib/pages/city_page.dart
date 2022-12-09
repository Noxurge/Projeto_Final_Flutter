import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:projeto_final/api/api_access.dart';
import 'package:projeto_final/model/city.dart';
import 'package:projeto_final/model/client.dart';
import 'package:projeto_final/util/components.dart';

class City_Register extends StatefulWidget {
  const City_Register({Key? key}) : super(key: key);

  @override
  State<City_Register> createState() => _CityRegisterState();
}

class _CityRegisterState extends State<City_Register> {
  GlobalKey<FormState> formController = GlobalKey<FormState>();
  TextEditingController txtId = TextEditingController();
  TextEditingController txtName = TextEditingController();
  TextEditingController txtUf = TextEditingController();

  @override
  Widget build(BuildContext context) {
    dynamic args = {};
    if (ModalRoute.of(context)?.settings.arguments != null) {
      args = ModalRoute.of(context)?.settings.arguments as CityModel;
      if (args.id > -1) {
        txtName.text = args.nome;
        txtUf.text = args.uf;
      }
    }

    register() async {
      if (args is CityModel) {
        CityModel c = CityModel(args.id, txtName.text, txtUf.text);
        await Gateway_API().alteraCidade(c.toJson());
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: Text('Cadastro alterado com sucesso!'),
          ),
        );
      } else {
        CityModel c = CityModel(0, txtName.text, txtUf.text);
        await Gateway_API().insereCidade(c.toJson());
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
      appBar: Components().createAppBar("Cadastro de Cidade", home),
      body: Form(
          key: formController,
          child: Column(
            children: [
              SizedBox(height: 20),
              Divider(color: Colors.black),
              Components().createInputText(
                  TextInputType.name, 'Cidade', txtName, 'Informe o nome'),
              Components().createInputText(
                  TextInputType.name, 'UF', txtUf, 'Informe a UF'),
              SizedBox(height: 20),
              Components().createButton(formController, register, 'Cadastrar'),
            ],
          )),
    );
  }
}
