import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'database.dart';
import 'models.dart';

class UserDatabase {
  static final UserDatabase _instance = UserDatabase._internal();

  factory UserDatabase() {
    return _instance;
  }

  UserDatabase._internal();

  late Database _users;

  Future<void> createDatabase() async {
    _users = await generateDatabase();
  }

  Future<void> addUser(User user) async {
    await _users.insert('users', user.toMap());
  }

  Future<List<Map<String, dynamic>>> getUsers() async {
    return await _users.query('users');
  }

  Future<void> eraseDatabase() async {
    String path = join(await getDatabasesPath(), 'database.db');
    await deleteDatabase(path);
    await createDatabase();
  }

  Future<void> deleteUser(int id) async {
    final count = await _users.rawDelete('DELETE FROM users WHERE id = $id');
    assert(count == 1);
  }

  Future<void> updateUser(int id, String? nam, String? num, String? loc) async {
    List<Map<String, dynamic>> map = await getUsers();

    late Map<String, dynamic> item;

    for (int i = 0; i < map.length; i++) {
      if (map[i]['id'] == id) {
        item = map[i];
      }
    }

    String name = nam ?? item['name'];
    String number = num ?? item['number'];
    String location = loc ?? item['location'];

    await _users.update(
        'users', {'name': name, 'number': number, 'location': location},
        where: 'id = $id');
  }
}
