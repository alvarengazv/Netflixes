import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netflix/modules/usuario/models/usuario_model.dart';
import 'package:netflix/modules/usuario/repositories/usuario_repository.dart';

class UserController extends ChangeNotifier {
  final nome = TextEditingController();
  final senha = TextEditingController();
  final emailTel = TextEditingController();
  final _repository = UsuarioRepository();

  void salvarUsuario(
    {required VoidCallback sucesso,
    required VoidCallback? falha(String motivo),
    bool alteracao = false}) async{
    
    try {
      final usuario = UsuarioModel(
        nome: nome.text,
        senha: senha.text,
        emailTel: emailTel.text
      );
      usuario.isValid();
      if (!alteracao) {
        await _repository.incluir(usuario);
      } else {
        await _repository.alterar(usuario);
      }   
      

      sucesso();

    } catch (e) {
      falha(e.toString().substring(11));
    }
  }

  String? validarNome(String? valor) {
    String padrao = r"^[a-zA-Z][a-zA-Z\s]{0,30}[a-zA-Z]$";
    RegExp regex = RegExp(padrao);
    if ((valor == null || valor.isEmpty || !regex.hasMatch(valor)) &&
        nome.text.isNotEmpty) {
      return 'Digite um nome válido';
    } else if (nome.text.isEmpty) {
      return 'O campo nome é obrigatório';
    } else {
      return null;
    }
  }
}
