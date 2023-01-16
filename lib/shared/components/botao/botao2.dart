import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class Botao2 extends StatefulWidget {
  final Widget page;
  final String texto;

  const Botao2({Key? key, 
  required this.page, 
  required this.texto})
      : super(key: key);

  @override
  State<Botao2> createState() => _Botao2State();
}

class _Botao2State extends State<Botao2> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.rightToLeft,
                child: widget.page,
                duration: Duration(milliseconds: 400)));
      },
      child: Text(
        widget.texto,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
