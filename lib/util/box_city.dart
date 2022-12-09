import 'dart:html';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:projeto_final/api/api_access.dart';
import 'package:projeto_final/model/city.dart';

class Combo_City extends StatefulWidget {
  TextEditingController? controller;

  Combo_City({Key? key, this.controller}) : super(key: key);

  @override
  State<Combo_City> createState() => _ComboCidadeState();
}

class _ComboCidadeState extends State<Combo_City> {
  int? cidadesel;

  @override
  Widget build(BuildContext context) {
    if (widget.controller?.text != null) {
      String text = widget.controller!.text;
      if (text != '') {
        cidadesel = int.parse(text);
      }
    }

    return FutureBuilder(
        future: Future.delayed(const Duration(seconds: 1))
            .then((value) => Gateway_API().listaCidades()),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            List<CityModel> cidades = snapshot.data;
            return Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButton(
                  isExpanded: true,
                  value: cidadesel,
                  icon: const Icon(Icons.arrow_downward),
                  hint: const Text('Selecione uma cidade......'),
                  elevation: 16,
                  onChanged: (int? value) {
                    setState(() {
                      cidadesel = value;
                      widget.controller?.text = "$value";
                    });
                  },
                  items: cidades.map<DropdownMenuItem<int>>((CityModel cid) {
                    return DropdownMenuItem<int>(
                        value: cid.id, child: Text(cid.nome));
                  }).toList(),
                ));
          } else {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                Text('Carregando Cidades'),
              ],
            );
          }
        });
  }
}
