import 'package:netflix/modules/usuario/models/usuario_model.dart';
import 'package:netflix/modules/usuario/repositories/datasources/datasource_ds.dart';
import 'package:netflix/modules/usuario/repositories/datasources/memoria_datasource.dart';

class UsuarioRepository{

  final DataSourceBase? _db = MemoriaDataSource();

  Future<void> incluir(UsuarioModel usuario) async{
    //Validações
    usuario.isValid();
    //Persistência
    _db!.incluir(usuario.toMap());
  }

  Future<void> excluir(UsuarioModel usuario) async{
    _db!.excluir(usuario.toMap());
  }

  Future<void> alterar(UsuarioModel usuario) async{
    usuario.isValid();
    _db!.alterar(usuario.toMap());
  }

  Future<UsuarioModel?> selecionar(String emailTel) async{
    final map = await _db!.selecionar(emailTel);
    if(map == null){
      return null;
    }
    return UsuarioModel.fromMap(map);
  }

  Future<List<UsuarioModel>> selecionarTodos() async{
    final maps = await _db!.selecionarTodos();
    var retorno = <UsuarioModel>[];
    for (var map in maps) {
      final usuario = UsuarioModel.fromMap(map);
      retorno.add(usuario);
    }
    
    return retorno;
  }
}