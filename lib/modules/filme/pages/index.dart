import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class FilmesPage extends StatefulWidget {
  const FilmesPage({Key? key}) : super(key: key);

  @override
  State<FilmesPage> createState() => _FilmesPageState();
}

class _FilmesPageState extends State<FilmesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("FILMES"),
        ),
        body: ListView.builder(
          itemBuilder: (context, indice){
            return Container();
          }
        )
      );
  }
}
