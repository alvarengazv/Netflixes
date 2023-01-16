import 'package:netflix/modules/usuario/models/usuario_model.dart';
import 'package:netflix/modules/usuario/repositories/datasources/datasource_ds.dart';

class MemoriaDataSource extends DataSourceBase{
  static List<Map<String, dynamic>> tabelaUsuario = [];

  static void init(){
    for (var i = 0; i < 100; i++) {
      var usu = UsuarioModel(
        emailTel: 'email$i@gmail.com',
        nome: 'Fulano 00$i',
        senha: 's$i'
      ).toMap();
      tabelaUsuario.add(usu);
    }
  }

  @override
  Future<void> alterar(Map<String, dynamic> usuario) async{
    for(var i = 0; i < tabelaUsuario.length; i++){
      if(tabelaUsuario[i]['emailTel'] == usuario['emailTel']){
        tabelaUsuario[i]['nome'] = usuario['nome'];
        tabelaUsuario[i]['senha'] = usuario['senha'];
        break;
      }
    }
  }

  @override
  Future<void> excluir(Map<String, dynamic> usuario) async{
    tabelaUsuario.removeWhere((element) => element['emailTel'] == usuario['emailTel']);
  }

  @override
  Future<void> incluir(Map<String, dynamic> usuario) async{
    tabelaUsuario.add(usuario);    
  }

  @override
  Future<Map<String, dynamic>?> selecionar(String email) async{
    for(var usuario in tabelaUsuario){
      if(usuario['emailTel'] == email){
        return usuario;
      }
    }
    return null;
  }

  @override
  Future<List<Map<String, dynamic>>> selecionarTodos() async{
    return tabelaUsuario;
  }

}