import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:netflix/modules/home/controllers/netflixController.dart';

class AddProfilePage extends StatefulWidget {
  const AddProfilePage({Key? key}) : super(key: key);

  @override
  State<AddProfilePage> createState() => _AddProfilePageState();
}

class _AddProfilePageState extends State<AddProfilePage> {
  final _controller = NetflixController(); 
  bool _teste1 = false;

  @override
  void initState() {
    _teste1 = false;
    super.initState();
  }

  void mudaSwitch(){
    setState(() {
      _teste1 = !_teste1;
    });
  }

  Widget botaoEdit(String titulo, String legenda) {
    
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 5),
      child: TextButton(
        style: TextButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 41, 41, 41)),
        child: Row(
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
                child: Padding(
                        padding: const EdgeInsets.only(right: 5.0),
                        child: Transform.scale(
                          scale: 0.8,
                          child: Switch(
                            value: _teste1,
                            onChanged: (bool teste) {mudaSwitch();},
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
        onPressed: () {mudaSwitch();},
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: TextButton(
                child: Text(
                  "Salvar",
                  style: TextStyle(
                    color: _controller.isValidNome() ? Colors.green : Color.fromARGB(255, 66, 66, 66)
                  ),
                ),
                onPressed: () {},
              ),
            )
          ],
          title:
              Row(mainAxisAlignment: MainAxisAlignment.start, children: const [
            Text(
              "Adicionar Perfil",
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
          child: Column(children: [
            IconButton(
              iconSize: 110,
              onPressed: () {},
              icon: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      image: const DecorationImage(
                          image: AssetImage('assets/images/default.jpg')
                      )
                  )
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(90, 20, 90, 20),
              child: TextFormField(
                onChanged: (_) => setState(() {}),
                autovalidateMode: AutovalidateMode.always,
                controller: _controller.addNomePerfil,
                cursorColor: const Color.fromARGB(255, 197, 197, 197),
                style: const TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255), fontSize: 14),
                decoration: InputDecoration(
                  hintText: 'Nome do perfil',
                  hintStyle: const TextStyle(color: Color.fromARGB(255, 197, 197, 197)),
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
                "Perfil para crianças", "Feito para crianças de até 12 anos, mas com o controle total dos pais."),
        ])));
  }
}
