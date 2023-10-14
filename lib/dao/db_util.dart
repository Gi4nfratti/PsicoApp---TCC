import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';

class DbUtil {
  static Future<Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(
      path.join(dbPath, 'psicoapp.db'),
      onCreate: (db, version) {
        db.execute(
            'CREATE TABLE IF NOT EXISTS register (id TEXT PRIMARY KEY, nome TEXT, genero TEXT, estCivil TEXT, idade TEXT, celular TEXT, email TEXT, senha TEXT, tratPsico TEXT, tratPsiq TEXT, buscaNoApp TEXT)');
        db.execute(
            'CREATE TABLE IF NOT EXISTS scale (id TEXT PRIMARY KEY, field1 TEXT, field2 TEXT, field3 TEXT, field4 TEXT, field5 TEXT, field6 TEXT, field7 TEXT, field8 TEXT, field9 TEXT, field10 TEXT, field11 TEXT, field12 TEXT, field13 TEXT, field14 TEXT, field15 TEXT)');
        db.execute(
            'CREATE TABLE IF NOT EXISTS photo (id TEXT PRIMARY KEY, imageBase64 TEXT)');
      },
      version: 1,
    );
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await DbUtil.database();
    await db.insert(table, data, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<void> update(String table, Map<String, Object> data) async {
    final db = await DbUtil.database();
    await db.update(table, data, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<void> delete(String table) async {
    final db = await DbUtil.database();
    await db.delete(table);
  }

  static Future<List<Map<String, dynamic>>> read(String table) async {
    final db = await DbUtil.database();
    return db.query(table);
  }
}
