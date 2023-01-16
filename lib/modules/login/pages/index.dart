import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:netflix/modules/home/pages/index.dart';
import 'package:netflix/modules/login/controllers/loginController.dart';
import 'package:netflix/modules/usuario/models/usuario_model.dart';
import 'package:netflix/modules/usuario/pages/register.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:page_transition/page_transition.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _controller = LoginController();
  bool _isObscure = true;
  bool _ativo = false;
  final Uri _url = Uri.parse('https://www.netflix.com/br-en/loginhelp');

  @override
  void initState() {
    super.initState();
    _isObscure = true;
  }

  @override
  Widget build(BuildContext context) {
    Future<void> _launchUrl() async {
      if (!await launchUrl(_url)) {
        throw 'Não foi possível conectar a $_url';
      }
    }

    return Scaffold(
        appBar: AppBar(
            title: const Align(
                alignment: Alignment.centerLeft,
                child: Image(
                  image: AssetImage("assets/images/logo2.png"),
                  width: 100,
                ))),
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Form(
            autovalidateMode: AutovalidateMode.always,
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(5, 120, 5, 10),
                  child: TextFormField(
                    controller: _controller.email,
                    validator: (valor) => _controller.validarEmailETel(valor),
                    keyboardType: TextInputType.emailAddress,
                    cursorColor: const Color.fromARGB(255, 197, 197, 197),
                    style: const TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255)),
                    decoration: InputDecoration(
                      errorStyle: const TextStyle(fontSize: 12),
                      focusColor: Colors.blue,
                      filled: true,
                      fillColor: const Color.fromARGB(255, 91, 90, 90),
                      labelText: "Email ou número de telefone",
                      labelStyle: const TextStyle(
                          color: Color.fromARGB(255, 197, 197, 197),
                          fontSize: 16,
                          height: 4,
                          backgroundColor: Colors.transparent),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide:
                              const BorderSide(color: Colors.transparent)),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide:
                              const BorderSide(color: Colors.transparent)),
                      focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide:
                              const BorderSide(color: Colors.transparent)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.always,
                    maxLength: 60,
                    controller: _controller.senha,
                    obscureText: _isObscure,
                    keyboardType: TextInputType.visiblePassword,
                    cursorColor: const Color.fromARGB(255, 197, 197, 197),
                    style: const TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255)),
                    onChanged: (_) => setState(() {}),
                    decoration: InputDecoration(
                      errorStyle: const TextStyle(fontSize: 12),
                      suffixIcon: _controller.senha.value.text.isNotEmpty
                          ? Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: TextButton(
                                child: _isObscure
                                    ? const Text(
                                        "MOSTRAR",
                                        style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 141, 141, 141)),
                                      )
                                    : const Text(
                                        "OCULTAR",
                                        style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 141, 141, 141)),
                                      ),
                                onPressed: () {
                                  setState(() {
                                    _isObscure = !_isObscure;
                                  });
                                },
                                onFocusChange: (_) {},
                              ),
                            )
                          : null,
                      filled: true,
                      fillColor: const Color.fromARGB(255, 91, 90, 90),
                      labelText: "Senha",
                      labelStyle: const TextStyle(
                          color: Color.fromARGB(255, 197, 197, 197),
                          height: 4,
                          fontSize: 15),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            width: 2, color: Color.fromARGB(255, 91, 90, 90)),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide:
                              const BorderSide(color: Colors.transparent)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(5, 0, 5, 10),
                  child: ElevatedButton(
                    onPressed: () {
                      _controller.entrarOnPressed(sucesso: (usuario) {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomePage(usuario: usuario ?? UsuarioModel())),
                            (route) => false);
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                          'Bem vindo ${usuario?.nome}!',
                          textAlign: TextAlign.center,
                        )));
                      }, falha: (motivo) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                          motivo,
                          textAlign: TextAlign.center,
                        )));
                      });
                    },
                    child: const Padding(
                      padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                      child: Text("Entrar",
                          style: TextStyle(
                              color: Color.fromARGB(255, 237, 236, 236))),
                    ),
                    style: ElevatedButton.styleFrom(
                        primary: _controller.validarLogin() &&
                                _controller.validarEmailETel(
                                        _controller.email.text.trim()) ==
                                    null
                            ? Colors.red
                            : null,
                        shape: RoundedRectangleBorder(
                            side: BorderSide(
                                width: 2.0,
                                color: _controller.validarLogin() &&
                                        _controller.validarEmailETel(
                                                _controller.email.text.trim()) ==
                                            null
                                    ? Colors.red
                                    : const Color.fromARGB(255, 172, 172, 172)),
                            borderRadius: BorderRadius.circular(5))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(5, 0, 5, 5),
                  child: ElevatedButton(
                    onPressed: () => _launchUrl(),
                    child: const Padding(
                      padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                      child: Text("Precisa de ajuda?",
                          style: TextStyle(
                              color: Color.fromARGB(255, 190, 190, 190))),
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: const RoundedRectangleBorder(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(5, 0, 5, 15),
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.bottomToTop,
                                child: RegisterPage(),
                                duration: Duration(milliseconds: 400)));
                      },
                      child: const Padding(
                        padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                        child: Text("Novo por aqui? Inscreva-se agora.",
                            style: TextStyle(
                                color: Color.fromARGB(255, 190, 190, 190),
                                fontWeight: FontWeight.bold)),
                      )),
                ),
                RichText(
                  text: TextSpan(
                      style: const TextStyle(
                        fontSize: 10,
                        color: Color.fromARGB(255, 190, 190, 190),
                      ),
                      children: [
                        const TextSpan(
                            text:
                                "O acesso está protegido pelo Google reCAPTCHA para garantir que você não é um robô. "),
                        _ativo
                            ? TextSpan(children: [
                                const TextSpan(
                                    text:
                                        "\n\nAs informações recolhidas pelo Google reCAPTCHA estão sujeitas à "),
                                TextSpan(
                                    text: "Política de Privacidade ",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () async {
                                        await launch(
                                            "https://policies.google.com/privacy");
                                      }),
                                const TextSpan(
                                  text: "e aos ",
                                ),
                                TextSpan(
                                    text: "Termos de Uso ",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () async {
                                        await launch(
                                            "https://policies.google.com/terms");
                                      }),
                                const TextSpan(
                                  text:
                                      "do Google e são usadas para oferecer, manter e melhorar o serviço reCAPTCHA e por questões de segurança (não são usadas para exibir anúncios personalizados pelo Google).",
                                )
                              ])
                            : TextSpan(
                                text: "Saiba mais.",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () async {
                                    setState(() {
                                      _ativo = !_ativo;
                                    });
                                  })
                      ]),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ));
  }
}
