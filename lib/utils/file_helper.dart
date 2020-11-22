import 'dart:io';

import 'package:path_provider/path_provider.dart';

Future<String> getAppDocDir() async {
  Directory appDocDir = Platform.isAndroid
      ? await getExternalStorageDirectory()
      : await getApplicationDocumentsDirectory();
  return appDocDir.path;
}

Future<String> getEpubTempFilePath(String filename) async {
  final tempDir = await getTemporaryDirectory();
  return '${tempDir.path}/$filename.epub';
}

Future<String> getEpubFilePath(String filename) async {
  final appDocDir = await getAppDocDir();
  return appDocDir + '/$filename.aes';
}

Future<String> getImgFilePath(String filename) async {
  final appDocDir = await getAppDocDir();
  return appDocDir + '/$filename';
}

Future<bool> fileExistsInAppDir(String filename) async {
  final path = await getEpubFilePath(filename);
  final file = File(path);
  return await file.exists();
}
