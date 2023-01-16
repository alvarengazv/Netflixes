import 'package:netflix/modules/usuario/repositories/datasources/datasource_ds.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

String tabelaUsuario = 'tabelaUsuario';
String nomeUsuario = 'nomeUsuario';
String emailUsuario = 'emailUsuario';
String senhaUsuario = 'senhaUsuario';
String idUsuario = 'idUsuario';

class SqfliteDataSource extends DataSourceBase {
  static final SqfliteDataSource _instance = SqfliteDataSource.internal();

  factory SqfliteDataSource() => _instance;
  SqfliteDataSource.internal();

  Database? _db;

  Future<Database> initDb() async {
    final caminhosDb = await getDatabasesPath();
    final path = join(caminhosDb, "usuario_netflix_pdm.db");

    return await openDatabase(path, version: 1,
        onCreate: (Database db, int newerVersion) async {
      await db.execute(
          "CREATE TABLE $tabelaUsuario ($idUsuario INTEGER PRIMARY KEY, $nomeUsuario TEXT, $emailUsuario TEXT, $nomeUsuario TEXT, $senhaUsuario TEXT)");
    });
  }

  Future<Database?> get db async {
    if (_db == null) {
      _db = await initDb();
    }
    return _db;
  }

  @override
  Future<void> alterar(Map<String, dynamic> usuario) async {
    await db;
  }

  @override
  Future<void> excluir(Map<String, dynamic> usuario) async {
    await db;
  }

  @override
  Future<void> incluir(Map<String, dynamic> usuario) async {
    var banco = await db;
    if (banco != null) {
      usuario['id'] = await banco.insert(tabelaUsuario, usuario);
    }
  }

  @override
  Future<Map<String, dynamic>?> selecionar(int id) async {
    var banco = await db;
    List<Map<String, dynamic>> maps = [];
    if (banco != null) {
      maps = await banco.query(tabelaUsuario,
          columns: [idUsuario, nomeUsuario, emailUsuario, emailUsuario],
          where: '$idUsuario = ?',
          whereArgs: [id]);
    }

    if (maps.length > 0) {
      return maps.first;
    } else {
      return null;
    }
  }

  @override
  Future<List<Map<String, dynamic>>> selecionarTodos() async {
    return [];
  }
}
