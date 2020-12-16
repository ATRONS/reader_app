import 'dart:io';

import 'package:atrons_mobile/models/material.dart';
import 'package:atrons_mobile/providers/shelf_provider.dart';
import 'package:objectdb/objectdb.dart';
import 'package:path_provider/path_provider.dart';

class DownloadsDB {
  Future<String> getPath() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    final path = documentDirectory.path + '/downloads.db';
    return path;
  }

  void addMaterial(ShelfProvider provider, Map item) async {
    final db = ObjectDB(await getPath());
    db.open();
    db.insert(item);
    db.tidy();
    await db.close();
    provider.addToShelf(MiniMaterial.fromJSON(item));
  }

  Future<int> removeMaterial(ShelfProvider provider, String id) async {
    final db = ObjectDB(await getPath());
    db.open();
    int val = await db.remove({'iD': id});
    db.tidy();
    await db.close();
    provider.removeFromShelf(id);
    return val;
  }

  Future<List<MiniMaterial>> getAllMaterials() async {
    final db = ObjectDB(await getPath());
    db.open();
    final val = List<dynamic>.from(await db.find({}))
        .map((each) => MiniMaterial.fromJSON(each))
        .toList();
    db.tidy();
    await db.close();
    return val;
  }

  Future<List> findMaterials(Map query) async {
    final db = ObjectDB(await getPath());
    db.open();
    List val = await db.find(query);
    db.tidy();
    await db.close();
    return val;
  }

  Future<void> clear() async {
    final db = ObjectDB(await getPath());
    await db.open();
    await db.remove({});
    await db.close();
  }
}
