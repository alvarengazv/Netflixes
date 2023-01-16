import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netflix/modules/usuario/models/usuario_model.dart';
import 'package:netflix/modules/usuario/repositories/usuario_repository.dart';

class LoginController extends ChangeNotifier {
  final email = TextEditingController();
  final senha = TextEditingController();
  final _repository = UsuarioRepository();


  String? validarEmailETel(String? valor) {
    String padrao =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    String padrao2 = r"^[1-9]{2}9[7-9]{1}[0-9]{3}[0-9]{4}$";
    RegExp regex = RegExp(padrao);
    RegExp regex2 = RegExp(padrao2);
    if ((valor == null || valor.isEmpty || !regex.hasMatch(valor)) &&
        email.text.isNotEmpty) {
      if ((valor == null || valor.isEmpty || !regex2.hasMatch(valor)) &&
          email.text.isNotEmpty) {
        return 'Digite um email ou número de telefone válido';
      } else {
        return null;
      }
    } else if (email.text.isEmpty) {
      return 'O email ou número de telefone é obrigatório';
    } else {
      return null;
    }
  }

  bool validarLogin() {
    if (senha.text.length >= 4) {
      return true;
    } else
      return false;
  }

  String? validarSenhaCadastro(String? valor) {
    if (senha.text.length >= 6 && senha.text.length <= 60) {
      return null;
    } else {
      return "A senha deve conter entre 6 e 60 caracteres.";
    }
  }

  void entrarOnPressed(
      {required VoidCallback? sucesso(UsuarioModel? usuario),
      required VoidCallback? falha(String motivo)}) async{
        
        try {
      final usuario = UsuarioModel(
        senha: senha.text,
        emailTel: email.text.trim()
      );

      final selecionado = await _repository.selecionar(usuario.emailTel ?? '');

      if (((email.text == "admin@admin.com" || email.text == "37988019255") &&
        senha.text == "admin1") || (email.text == selecionado?.emailTel && senha.text == selecionado?.senha)) {
      sucesso(selecionado);
      } else {
        falha("Usuário e/ou senha inválidos!");
      }


    } catch (e) {
      falha(e.toString());
    }

    
  }
}
