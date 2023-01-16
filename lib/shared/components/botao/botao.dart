import 'package:flutter/material.dart';

class Botao extends StatefulWidget {
  final String texto;
  final Function()? funcao;
  final Color? cor;

  Botao({ Key? key, required this.texto, this.funcao, this.cor }) : super(key: key);

  @override
  State<Botao> createState() => _BotaoState();
}

class _BotaoState extends State<Botao> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
                onPressed: widget.funcao,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, 13, 0, 13),
                  child: Text(widget.texto),
                ),
                style: ElevatedButton.styleFrom(
                    primary: widget.cor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(2),
                    )),
              );
  }
}