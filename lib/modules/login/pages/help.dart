import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpPage extends StatefulWidget {
  const HelpPage({Key? key}) : super(key: key);

  @override
  State<HelpPage> createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  Widget popupMsg(String opt2){
    return AlertDialog(
          backgroundColor: const Color.fromARGB(255, 71, 71, 71),
          content: const Text('Contate um especialista de atendimento.', style: TextStyle(color: Colors.white, fontSize: 13),),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'CANCELAR'),
              child: const Text('CANCELAR', style: TextStyle(color: Colors.white, fontSize: 13),),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, opt2),
              child: Text(opt2, style: const TextStyle(color: Colors.white, fontSize: 13),),
            ),
          ],
    );
  }

  Future<void> _abrirLink(String link) async {
      if (!await launchUrl(Uri.parse(link))) {
        throw 'Não foi possível conectar a $link';
      }
    }

  Widget botao(String texto, IconData icone, String opt2){
    return Padding(
      padding: const EdgeInsets.fromLTRB(125, 0, 125, 0),
      child: ElevatedButton(
        onPressed: () {
          showDialog<String>(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) => popupMsg(opt2)
          );
        }, 
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icone),
            Text(texto,)
          ],
        ),
      ),
    );
  }
  
  Widget divisorBotao(){
    return const Divider(
                height: 0,
                indent: 20,
                endIndent: 20,
                color: Color.fromARGB(255, 136, 136, 136),
              );
  }

  Widget botaoTexto(String texto, IconData icone, String link){
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: TextButton.icon(
                  icon: Icon(icone, color: const Color.fromARGB(255, 15, 108, 184), size: 20,),
                  onPressed: () {
                    _abrirLink(link);
                  }, 
                  label: Row(
                    children: [
                      Expanded(
                        flex: 16,
                        child: Text(
                          texto, 
                          style: const TextStyle(
                            color: Color.fromARGB(255, 15, 108, 184),
                            fontSize: 12
                          ),),
                      ),
                      Expanded(flex: 1, child: Icon(Icons.chevron_right, color: Color.fromARGB(255, 15, 108, 184),))
                    ]
                  ),
                  style: TextButton.styleFrom(
                    fixedSize: Size(352, 10)
                  ),
                ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          leading: const BackButton(color: Colors.black),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: const [
              Image(
                image: AssetImage("assets/images/logo2.png"),
                width: 100,
              ),
            ]
          ),
          centerTitle: true,
          shadowColor: Colors.transparent,
          backgroundColor: Colors.white,
      ),
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 25),
            child: Text("Procurar ajuda online",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              divisorBotao(),
              botaoTexto("Centro de Ajuda", Icons.input, "https://help.netflix.com/pt?fromApp=true&netflixsource=android"),
              divisorBotao(),
              botaoTexto("Solicitar um título", Icons.adf_scanner, "https://help.netflix.com/pt/titlerequest?fromApp=true&netflixsource=android"),
              divisorBotao(),
              botaoTexto("Resolver problemas de conexão", Icons.build, "https://help.netflix.com/pt/troubleshooting?fromApp=true&netflixsource=android"),
              divisorBotao(),
              botaoTexto("Privacidade", Icons.verified_user, "https://help.netflix.com/legal/privacy?netflixsource=android&fromApp=true"),
              divisorBotao(),
              botaoTexto("Termos de uso", Icons.article, "https://help.netflix.com/legal/termsofuse?netflixsource=android&fromApp=true"),
              divisorBotao()
            ],
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(45, 80, 45, 20),
            child: Text(
              "Entrar em contato com o atendimento ao cliente da Netflix",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(65, 0, 65, 18),
            child: Text(
              "A chamada é grátis: usaremos sua conexão à internet.",
              style: TextStyle(
                fontSize: 12
              ),
              textAlign: TextAlign.center,
            ),
          ),
          botao("BATE-PAPO", Icons.chat,"BATER PAPO AGORA"),
          botao("LIGAR", Icons.phone, "LIGAR AGORA")
        ],
      ),
    );
  }
}
