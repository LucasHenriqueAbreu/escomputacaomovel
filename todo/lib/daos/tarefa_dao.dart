import 'package:sqflite/sqflite.dart';
import 'package:todo/models/tarefa.dart';

class TarefaDao {
  Future<Database> _criaOuIniciaBancoDeDados() async {
    String databasesPath = await getDatabasesPath();
    String dbPath = databasesPath + '/tarefas.db';
    var database = await openDatabase(dbPath, version: 1, onCreate: _onCreate);
    return database;
  }

  void _onCreate(Database database, int versao) async {
    await database.execute('''
          CREATE TABLE tarefa (
            id INTEGER PRIMARY KEY,
            descricao TEXT,
            pronta INTEGER
          );
      ''');
  }

  Future<int> create(Tarefa tarefa) async {
    var dataBase = await _criaOuIniciaBancoDeDados();
    return dataBase.insert('tarefa', tarefa.toJson());
  }

  Future<List<Tarefa>> list() async {
    var dataBase = await _criaOuIniciaBancoDeDados();
    var result = await dataBase.query('tarefa');
    List<Tarefa> tarefas = List<Tarefa>();
    for (var i = 0; i < result.length; i++) {
      tarefas.add(Tarefa.fromJson(result[i]));
    }
    return tarefas;
  }

  Future<int> update(Tarefa tarefa) async {
    var dataBase = await _criaOuIniciaBancoDeDados();
    return await dataBase.update('tarefa', tarefa.toJson(),
        where: 'id = ? ', whereArgs: [tarefa.id]);
  }

  Future<dynamic> delete(int idTarefa) async {
    var dataBase = await _criaOuIniciaBancoDeDados();
    return await dataBase
        .delete('tarefa', where: 'id = ?', whereArgs: [idTarefa]);
  }
}
