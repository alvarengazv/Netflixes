import 'package:flutter/cupertino.dart';
import 'package:netflix/modules/usuario/models/usuario_model.dart';
import 'package:netflix/modules/usuario/repositories/usuario_repository.dart';

class ListaPageController extends ChangeNotifier {
  final _usuarioRepository = UsuarioRepository();

  ValueNotifier<List<UsuarioModel>> usuarioDataSourceNotifier =
      ValueNotifier<List<UsuarioModel>>([]);

  set usuarioDataSource(value) => usuarioDataSourceNotifier.value = value;
  List<UsuarioModel> get usuarioDataSource => usuarioDataSourceNotifier.value;

  Future<void> carregaDados() async {
    await _usuarioRepository
        .selecionarTodos()
        .then((value) => usuarioDataSource = value);
  }

  Future<void> excluiUsuario(
      UsuarioModel usuario, VoidCallback sucesso, VoidCallback erro) async {
    try {
      await _usuarioRepository.excluir(usuario);
      sucesso();
    } catch (e) {
      erro();
    }
  }

  Future<void> alteraUsuario(UsuarioModel usuario) async {
    await _usuarioRepository.alterar(usuario);
  }
}
