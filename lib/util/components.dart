import 'dart:io';
import 'package:flutter/material.dart';
import 'package:projeto_final/api/api_access.dart';
import 'package:projeto_final/model/city.dart';
import 'package:projeto_final/model/client.dart';
import 'package:projeto_final/pages/city_page.dart';
import 'package:projeto_final/pages/client_page.dart';
import 'package:projeto_final/pages/home.dart';
import 'package:projeto_final/pages/list_city.dart';
import 'package:projeto_final/pages/list_client.dart';

class Components {
  // Criação da AppBar
  createAppBar(text, action) {
    return AppBar(
      bottom: PreferredSize(
          child: Container(
            color: Colors.lightBlueAccent[400],
            height: 4.0,
          ),
          preferredSize: Size.fromHeight(4.0)),
      backgroundColor: Colors.indigo.shade800,
      title: createText(text, Colors.white),
      centerTitle: true,
      actions: <Widget>[
        IconButton(onPressed: action, icon: const Icon(Icons.home_outlined)),
      ],
    );
  }

  // Criação de texto
  createText(text, [color]) {
    if (color != null) {
      return Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 45,
        ),
      );
    }
    return Text(
      text,
      style: TextStyle(
        fontSize: 15,
      ),
    );
  }

  // Criação para um input de texto
  createInputText(keyboardType, textTag, controller, txtValidation) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        keyboardType: keyboardType,
        decoration: InputDecoration(
            labelText: textTag,
            labelStyle: const TextStyle(
              fontSize: 20,
            )),
        textAlign: TextAlign.left,
        style: const TextStyle(fontSize: 30),
        controller: controller,
        validator: (value) {
          if (value!.isEmpty) {
            return txtValidation;
          }
        },
      ),
    );
  }

  // Criação para um input de texto porém dinâmico
  dynamicInputText(
      keyboardType, textTag, controller, txtValidation, notifyChanged) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        onChanged: ((value) => notifyChanged(value)),
        keyboardType: keyboardType,
        decoration: InputDecoration(
            labelText: textTag,
            labelStyle: const TextStyle(
              fontSize: 20,
            )),
        textAlign: TextAlign.left,
        style: const TextStyle(fontSize: 30),
        controller: controller,
        validator: (value) {
          if (textTag != 'Informe a UF:' &&
              textTag != 'Informe a cidade:' &&
              value!.isEmpty) {
            return txtValidation;
          }
        },
      ),
    );
  }

  // Criação de botão
  createButton(controllerForm, function, title) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            padding: const EdgeInsets.fromLTRB(50, 10, 50, 10),
            height: 70,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.teal.shade400,
              ),
              onPressed: () {
                if (controllerForm.currentState!.validate()) {
                  function();
                }
              },
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 30.0,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Criação de botão porém dinâmico
  dynamicButton(controllerForm, function, title, condition) {
    enabled() {
      if (controllerForm.currentState!.validate()) {
        function();
      }
    }

    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            padding: const EdgeInsets.fromLTRB(50, 10, 50, 10),
            height: 70,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.teal.shade400,
              ),
              onPressed: condition ? enabled : null,
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 30.0,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Criação de um item para o Cliente
  clientItem(ClientModel p, context) {
    Widget cancel = FloatingActionButton(
        child: Icon(Icons.close),
        onPressed: () {
          Navigator.pop(context);
        });

    Widget confirm = FloatingActionButton(
        child: Icon(Icons.check),
        onPressed: () {
          Gateway_API().excluirCliente(p.id);
          Navigator.pop(context);
        });

    String sexo = p.sexo == 'M' ? "Masculino" : "Feminino";
    String textoIdade = '';
    if (p.idade <= 1) {
      textoIdade = ' ano';
    } else {
      textoIdade = ' anos';
    }

    return ListTile(
      title: createText("ID: ${p.id}" +
          "\n" +
          "Nome: ${p.nome} - Idade: ${p.idade}" +
          textoIdade +
          " - Sexo: ${p.sexo}"),
      subtitle: createText("${p.cidade.nome} - (${p.cidade.uf})"),
      trailing: FittedBox(
        fit: BoxFit.fill,
        child: Row(
          children: [
            IconButton(
                icon: Icon(Icons.edit),
                onPressed: (() {
                  Navigator.pushNamed(context, '/client_page', arguments: p);
                })),
            IconButton(
                onPressed: () async {
                  AlertDialog a = AlertDialog(
                    title: Text('Excluir'),
                    content: Text('Deseja realmente excluir?'),
                    actions: [
                      confirm,
                      cancel,
                    ],
                  );
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return a;
                    },
                  );
                },
                icon: Icon(Icons.delete_forever))
          ],
        ),
      ),
    );
  }

  // Criação de um item para a Cidade
  cityItem(CityModel c, context, action) {
    Widget cancel = FloatingActionButton(
        child: Icon(Icons.close),
        onPressed: () {
          Navigator.pop(context);
        });

    Widget confirm = FloatingActionButton(
        child: Icon(Icons.check),
        onPressed: () {
          Gateway_API().excluirCidade(c.id);
          Navigator.pop(context);
        });

    return ListTile(
      title: createText("ID: ${c.id}"),
      subtitle: createText("Cidade: ${c.nome} - UF: ${c.uf}"),
      trailing: FittedBox(
        fit: BoxFit.fill,
        child: Row(
          children: [
            IconButton(
                icon: Icon(Icons.edit),
                onPressed: (() {
                  Navigator.pushNamed(context, '/city_page', arguments: c);
                })),
            IconButton(
                onPressed: () async {
                  AlertDialog a = AlertDialog(
                    title: Text('Excluir'),
                    content: Text('Deseja realmente excluir?'),
                    actions: [
                      confirm,
                      cancel,
                    ],
                  );
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return a;
                    },
                  );
                },
                icon: Icon(Icons.delete_forever))
          ],
        ),
      ),
    );
  }

  // Animação para mudança de tela
  Route path(route) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => route,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
