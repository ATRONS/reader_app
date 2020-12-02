import 'dart:io';

import 'package:atrons_mobile/models/user.dart';
import 'package:objectdb/objectdb.dart';
import 'package:path_provider/path_provider.dart';

class UsersDB {
  Future<String> getPath() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    final path = documentDirectory.path + '/users.db';
    return path;
  }

  addUser(Map item) async {
    final db = ObjectDB(await getPath());
    db.open();
    await db.insert(item);
    await db.tidy();
    await db.close();
  }

  Future<int> removeUser() async {
    final db = ObjectDB(await getPath());
    db.open();
    int val = await db.remove({});
    await db.tidy();
    await db.close();
    return val;
  }

  Future<User> getUser() async {
    final db = ObjectDB(await getPath());
    db.open();
    List val = await db.find({});
    await db.tidy();
    await db.close();
    return User.fromJSON(val[0]);
  }

  void clear() async {
    final db = ObjectDB(await getPath());
    db.open();
    await db.remove({});
    await db.close();
  }
}
