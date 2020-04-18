import 'package:marvelcatalogo/models/usuario.dart';
import 'package:sqflite/sqflite.dart';

class UsuarioDao {
  Future<Database> createOrGetDatabase() async {
    String databasesPath = await getDatabasesPath();
    String dbPath = databasesPath + '/marvel_catalogo.db';
    var database = await openDatabase(
      dbPath,
      version: 1,
      onCreate: populateDb,
    );
    return database;
  }

  void populateDb(Database database, int version) async {
    await database.execute(
      '''
        CREATE TABLE usuario (
        id INTEGER PRIMARY KEY,
        userName TEXT,
        privateKey TEXT,
        publicKey TEXT)
      ''',
    );
  }

  Future<int> create(Usuario usuario) async {
    Database database = await createOrGetDatabase();
    var result = await database.insert('usuario', usuario.toJson());
    database.close();
    return result;
  }

  Future<Usuario> read() async {
    Database database = await createOrGetDatabase();
    var result = await database.query('usuario');
    if (result.length != 0) {
      return Usuario.fromJson(result.first);
    }
  }
}
