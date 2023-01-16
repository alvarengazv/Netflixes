import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:netflix/modules/usuario/models/usuario_model.dart';
import 'package:netflix/shared/components/botao/botao2.dart';

import '../../../shared/components/botao/botao.dart';
import '../../../shared/components/campo_formulario/campo_form.dart';
import '../../login/controllers/loginController.dart';
import '../../login/pages/help.dart';
import '../../login/pages/index.dart';
import 'package:page_transition/page_transition.dart';

import '../controllers/userController.dart';

class Register2Page extends StatefulWidget {
  final UsuarioModel? usuario;

  const Register2Page({Key? key, this.usuario}) : super(key: key);

  @override
  State<Register2Page> createState() => _Register2PageState();
}

class _Register2PageState extends State<Register2Page> {
  final _controller = LoginController();
  final _controller2 = UserController();

  @override
  void initState() {
    super.initState();
    if (widget.usuario != null) {
      _controller2.emailTel.text = widget.usuario!.emailTel ?? '';
      _controller2.senha.text = widget.usuario!.senha ?? '';
      _controller2.nome.text = widget.usuario!.nome ?? '';
    }
  }

  @override
  void dispose() {
    _controller2.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final valorInicial = ModalRoute.of(context)!.settings.arguments as String;
    _controller2.emailTel.text = valorInicial;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 27, 27, 27),
      appBar: AppBar(
          shadowColor: Colors.transparent,
          backgroundColor: const Color.fromARGB(255, 27, 27, 27),
          automaticallyImplyLeading: false,
          title: Align(
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  const Expanded(
                    flex: 1,
                    child: Image(
                      image: AssetImage("assets/images/logo2.png"),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: const [
                        Botao2(page: HelpPage(), texto: "AJUDA"),
                        Botao2(page: LoginPage(), texto: "ENTRAR"),
                      ],
                    ),
                  ),
                ],
              ))),
      body: Form(
        autovalidateMode: AutovalidateMode.always,
        child: ListView(
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(65, 50, 65, 20),
              child: Text(
                "Um mundo de séries e filmes ilimitados espera por você.",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.justify,
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(65, 0, 65, 15),
              child: Text(
                "Crie uma conta para saber mais sobre a Netflix.",
                style: TextStyle(
                    color: Color.fromARGB(255, 218, 217, 217), fontSize: 15),
                textAlign: TextAlign.justify,
              ),
            ),
            Padding(
                padding: const EdgeInsets.fromLTRB(65, 0, 65, 0),
                child: CampoForm(
                  label: "Nome",
                  // validator: (valor) => _controller2.validarNome(valor),
                  controller: _controller2.nome,
                  tipoTeclado: TextInputType.name,
                  validatemode: AutovalidateMode.onUserInteraction,
                  obscure: false,
                )),
            Padding(
                padding: const EdgeInsets.fromLTRB(65, 0, 65, 5),
                child: CampoForm(
                  label: "Email ou número de telefone",
                  // validator: (valor) => _controller.validarEmailETel(valor),
                  controller: _controller2.emailTel,
                  tipoTeclado: TextInputType.emailAddress,
                  validatemode: AutovalidateMode.onUserInteraction,
                  obscure: false,
                )),
            Padding(
                padding: const EdgeInsets.fromLTRB(65, 0, 65, 20),
                child: CampoForm(
                  label: "Senha",
                  // validator: (valor) => _controller.validarSenhaCadastro(valor),
                  controller: _controller2.senha,
                  tipoTeclado: TextInputType.visiblePassword,
                  validatemode: AutovalidateMode.onUserInteraction,
                  obscure: true,
                )),
            Padding(
              padding: const EdgeInsets.fromLTRB(65, 0, 65, 0),
              child: Botao(
                texto: "CONTINUAR",
                funcao: () {
                  /*_controller.validarEmailETel(_controller.email.text) ==
                              null &&
                          _controller.validarSenhaCadastro(
                                  _controller.email.text) ==
                              null &&
                          _controller2.validarNome(_controller2.nome.text) ==
                              null
                      ? */_controller2.salvarUsuario(sucesso: () {
                          Navigator.pop(context);
                        }, falha: (motivo) {
                          MotionToast.error(
                            title: const Text(
                              'Erro',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            description: Text(motivo),
                            animationType: AnimationType.fromLeft,
                            position: MotionToastPosition.top,
                            barrierColor: Colors.black.withOpacity(0.3),
                            width: 300,
                            height: 80,
                            dismissable: true,
                          ).show(context);
                        },
                        alteracao: widget.usuario != null);
                      /*: null;*/
                },
                cor: Colors.red,
              ),
            )
          ],
        ),
      ),
    );
  }
}
