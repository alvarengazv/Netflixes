import 'package:flutter/material.dart';
import 'package:netflix/modules/login/controllers/loginController.dart';
import 'package:netflix/modules/usuario/controllers/userController.dart';
import 'package:netflix/modules/usuario/pages/register2.dart';
import 'package:netflix/shared/components/botao/botao.dart';
import 'package:netflix/shared/components/campo_formulario/campo_form.dart';
import 'package:page_transition/page_transition.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _controller = LoginController();
  final _controller2 = UserController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 27, 27, 27),
      appBar: AppBar(
        shadowColor: Colors.transparent,
        backgroundColor: const Color.fromARGB(255, 27, 27, 27),
        automaticallyImplyLeading: false,
        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: CloseButton(),
          )
        ],
      ),
      body: Form(
        autovalidateMode: AutovalidateMode.always,
        child: ListView(
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(40, 100, 40, 20),
              child: Text(
                "Tudo pronto para assistir?",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 31,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(50, 0, 50, 20),
              child: Text(
                "Informe seu email ou número de telefone para criar ou acessar sua conta.",
                style: TextStyle(
                    color: Color.fromARGB(255, 138, 138, 138), fontSize: 15),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
                padding: const EdgeInsets.fromLTRB(65, 10, 65, 0),
                child: CampoForm(
                  label: "Email ou número de telefone",
                  validator: (valor) => _controller.validarEmailETel(valor),
                  controller: _controller2.emailTel,
                  tipoTeclado: TextInputType.emailAddress,
                  validatemode: AutovalidateMode.onUserInteraction,
                  obscure: false,
                )),
            Padding(
              padding: const EdgeInsets.fromLTRB(65, 0, 65, 0),
              child: Botao(
                  texto: "VAMOS LÁ",
                  funcao: () =>
                     /* _controller.validarEmailETel(_controller.email.text) ==
                              null
                          ? */
                          Navigator.pushReplacement(
                              context,
                              PageTransition(
                                  type: PageTransitionType.rightToLeft,
                                  child: const Register2Page(),
                                  settings: RouteSettings(
                                    arguments: _controller2.emailTel.text,
                                  ),
                                  duration: const Duration(milliseconds: 400)),
                            ),
                         /* : null,*/
                  cor: Colors.red),
            )
          ],
        ),
      ),
    );
  }
}
