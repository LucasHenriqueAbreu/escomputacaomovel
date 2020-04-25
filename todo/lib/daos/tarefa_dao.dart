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
}
