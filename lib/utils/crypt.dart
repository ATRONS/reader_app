import 'dart:io';

import 'package:encrypt/encrypt.dart';

Future<bool> decryptFile(
    String srcPath, String destPath, String key, String iv) async {
  final srcFile = File(srcPath);
  final destFile = File(destPath);
  try {
    if (!await srcFile.exists()) return false;
    if (await destFile.exists()) {
      await destFile.delete();
      await destFile.create();
    }
    final encrypter = Encrypter(AES(Key.fromUtf8(key)));
    final encrypted = Encrypted.fromUtf8(srcFile.readAsStringSync());
    final decrypted = encrypter.decrypt(encrypted, iv: IV.fromUtf8(iv));
    await destFile.writeAsString(decrypted);
    return true;
  } catch (e) {
    print(e);
  }
  return false;
}
