import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  bool _teste1 = true;
  bool _teste2 = true;

  @override
  void initState() {
    _teste1 = true;
    _teste2 = true;
    super.initState();
  }

  void mudaSwitch(IconData icone){
    setState(() {
      icone == Icons.queue_play_next
          ? _teste1 = !_teste1
          : icone == Icons.play_circle
              ? _teste2 = !_teste2
              : null;
    });
  }

  Widget botaoEdit(String titulo, IconData icone, String legenda,
      {IconData? icone2}) {
    
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 5),
      child: TextButton.icon(
        style: TextButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 41, 41, 41)),
        label: Row(
          children: [
            Expanded(
              flex: 12,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    titulo,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 13),
                  ),
                  Text(
                    legenda,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 184, 184, 184),
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
                flex: 1,
                child: icone2 != null
                    ? Icon(
                        icone2,
                        color: const Color.fromARGB(255, 161, 161, 161),
                        size: 20,
                      )
                    : Padding(
                        padding: const EdgeInsets.only(right: 5.0),
                        child: Transform.scale(
                          scale: 0.8,
                          child: Switch(
                            value: icone == Icons.queue_play_next
                                ? _teste1
                                : _teste2,
                            onChanged: (bool teste) {mudaSwitch(icone);},
                            activeTrackColor:
                                const Color.fromARGB(255, 45, 111, 235),
                            activeColor: Colors.white,
                            inactiveTrackColor:
                                const Color.fromARGB(255, 78, 78, 78),
                            inactiveThumbColor:
                                const Color.fromARGB(255, 192, 192, 192),
                          ),
                        ),
                      ))
          ],
        ),
        icon: Icon(
          icone,
          size: 20,
          color: const Color.fromARGB(255, 161, 161, 161),
        ),
        onPressed: () {mudaSwitch(icone);},
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final asset = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        title: Row(mainAxisAlignment: MainAxisAlignment.start, children: const [
          Text(
            "Editar Perfil",
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.start,
          )
        ]),
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        shadowColor: Colors.transparent,
      ),
      body: Center(
        child: Column(
          children: [
            IconButton(
              iconSize: 110,
              onPressed: () {},
              icon: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      image: DecorationImage(
                          image: AssetImage(ModalRoute.of(context)!
                              .settings
                              .arguments as String)))),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(90, 20, 90, 20),
              child: TextFormField(
                initialValue: asset.contains("geralt1")
                    ? "Perfil 1"
                    : asset.contains("professor1")
                        ? "Perfil 2"
                        : asset.contains("nancy1")
                            ? "Perfil 3"
                            : null,
                cursorColor: const Color.fromARGB(255, 197, 197, 197),
                style: const TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255), fontSize: 14),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color.fromARGB(255, 53, 53, 53),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(color: Colors.transparent)),
                ),
              ),
            ),
            botaoEdit(
                "Classificação de Maturidade", Icons.report, "Sem restrições.",
                icone2: Icons.login),
            botaoEdit("Idioma de exibição", Icons.translate,
                "Altere o idioma do texto que você vê na Netflix em todos os aparelhos.",
                icone2: Icons.chevron_right),
            botaoEdit("Idiomas de áudio e legendas", Icons.comment,
                "Escolha seus idiomas preferidos para assistir a séries e filmes.",
                icone2: Icons.chevron_right),
            botaoEdit("Reprodução automática do próximo episódio",
                Icons.queue_play_next, "Em todos os aparelhos."),
            botaoEdit("Reprodução automática das prévias", Icons.play_circle,
                "Em todos os aparelhos."),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 50),
                child: TextButton.icon(
                  icon: const Icon(
                    Icons.delete,
                    color: Color.fromARGB(255, 161, 161, 161),
                  ),
                  label: const Text(
                    "Excluir perfil",
                    style: TextStyle(color: Color.fromARGB(255, 161, 161, 161)),
                  ),
                  onPressed: () {},
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
