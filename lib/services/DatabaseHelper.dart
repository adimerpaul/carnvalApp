import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;
class DatabaseHelper{
  static final DatabaseHelper _instance = DatabaseHelper.internal();
  static Database? _database;
  factory DatabaseHelper() => _instance;
  DatabaseHelper.internal();
  Future<Database?> get db async {
    if (_database != null) {
      return _database;
    }
    _database = await initDb();
    return _database;
  }
  Future<Database> initDb() async {
    String path = join(await getDatabasesPath(), 'database.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }
  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users(
        id INTEGER,
        user_id INTEGER,
        name TEXT,
        email TEXT,
        dancer_id INTEGER,
        token TEXT
      )
    ''');
  }
  Future login(username,password) async {
    Database? db = await this.db;
    var url = dotenv.env['API_URL']! + '/login';
    var response = await http.post(Uri.parse(url,), body: {
      'nickname': username,
      'password': password
    });
    if (response.statusCode == 200) {
      var res = response.body;
      print(res);
      return res;
    } else {
      print(response.statusCode);
    }
    // var res = await db!.query('users', where: 'id = ?', whereArgs: [1]);
    // if (res.isNotEmpty) {
    //   return await db.update('users', row, where: 'id = ?', whereArgs: [1]);
    // }else{
    //   row['id'] = 1;
    //   return await db.insert('users', row);
    // }
  }
  Future getUser() async {
    Database? db = await this.db;
    var res = await db!.query('users', where: 'id = ?', whereArgs: [1]);
    return res.isNotEmpty ? res.first : null;
  }
  Future deleteUser() async {
    Database? db = await this.db;
    return await db!.delete('users', where: 'id = ?', whereArgs: [1]);
  }
}