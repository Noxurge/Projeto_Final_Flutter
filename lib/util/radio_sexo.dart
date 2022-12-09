import 'package:flutter/material.dart';

enum sexoEnum { masculino, feminino }

class RadioSexo extends StatefulWidget {
  TextEditingController? controller;
  RadioSexo({Key? key, this.controller}) : super(key: key);

  @override
  State<RadioSexo> createState() => _RadioSexoState();
}

class _RadioSexoState extends State<RadioSexo> {
  sexoEnum? _escolha = sexoEnum.masculino;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
            child: ListTile(
          title: const Text('Masculino'),
          leading: Radio<sexoEnum>(
            value: sexoEnum.masculino,
            groupValue: _escolha,
            onChanged: (sexoEnum? value) {
              setState(() {
                _escolha = value;
                widget.controller?.text = 'Masculino';
              });
            },
          ),
        )),
        Expanded(
          child: ListTile(
            title: const Text('Feminino'),
            leading: Radio<sexoEnum>(
              value: sexoEnum.feminino,
              groupValue: _escolha,
              onChanged: (sexoEnum? value) {
                setState(() {
                  _escolha = value;
                  widget.controller?.text = 'Feminino';
                });
              },
            ),
          ),
        ),
      ],
    );
  }
}
