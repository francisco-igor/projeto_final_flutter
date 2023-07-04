import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

Future<Database> generateDatabase() async {
  return await openDatabase(
    join(await getDatabasesPath(), 'database.db'),
    version: 1,
    onCreate: (db, versaoRecente) async {
      String sql = '''CREATE TABLE IF NOT EXISTS users (
          id INTEGER PRIMARY KEY AUTOINCREMENT, 
          name TEXT, number TEXT, location TEXT
          )''';
      await db.execute(sql);
    },
  );
}
