import 'dart:io';

import 'package:objectdb/objectdb.dart';
import 'package:path_provider/path_provider.dart';

class UsersDB {
  Future<String> getPath() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    final path = documentDirectory.path + '/users.db';
    return path;
  }

  void addUser(Map item) async {
    final db = ObjectDB(await getPath());
    db.open();
    db.insert(item);
    db.tidy();
    await db.close();
  }

  Future<int> removeUser(String token) async {
    final db = ObjectDB(await getPath());
    db.open();
    int val = await db.remove({'token': token});
    db.tidy();
    await db.close();
    return val;
  }

  Future<List> getUser() async {
    final db = ObjectDB(await getPath());
    db.open();
    List val = await db.find({});
    db.tidy();
    await db.close();
    return val;
  }

  void clear() async {
    final db = ObjectDB(await getPath());
    db.open();
    db.remove({});
    db.close();
  }
}
