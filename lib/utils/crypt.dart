import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:pointycastle/export.dart';

Uint8List aesCbcDecrypt(Uint8List key, Uint8List iv, Uint8List cipherText) {
  final cbc = CBCBlockCipher(AESFastEngine())
    ..init(false, ParametersWithIV(KeyParameter(key), iv)); // false=decrypt

  final paddedPlainText = Uint8List(cipherText.length);

  var offset = 0;
  while (offset < cipherText.length) {
    offset += cbc.processBlock(cipherText, offset, paddedPlainText, offset);
  }
  assert(offset == cipherText.length);

  return paddedPlainText;
}

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

    final decrypted = aesCbcDecrypt(
        utf8.encode(key), utf8.encode(iv), srcFile.readAsBytesSync());
    await destFile.writeAsBytes(decrypted);
    return true;
  } catch (e) {
    print(e);
  }
  return false;
}
