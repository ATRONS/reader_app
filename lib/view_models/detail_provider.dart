import 'dart:io';
import 'package:atrons_mobile/database/downloads.dart';
import 'package:atrons_mobile/fragments/download_alert.dart';
import 'package:atrons_mobile/models/material.dart';
import 'package:atrons_mobile/utils/api.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import 'loading_state.dart';

class DetailProvider extends ChangeNotifier {
  final _api = Api();
  final _downloadsDb = DownloadsDB();

  MaterialDetail _selectedMaterial;
  MaterialDetail get selectedMaterial => _selectedMaterial;
  LoadingState loadingState = LoadingState.loading;

  Future downloadFile(BuildContext context) async {
    PermissionStatus permission = await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.storage);

    if (permission != PermissionStatus.granted) {
      await PermissionHandler().requestPermissions([PermissionGroup.storage]);
      startDownload(context);
    } else {
      startDownload(context);
    }
  }

  Future<String> getAppDocDir() async {
    Directory appDocDir = Platform.isAndroid
        ? await getExternalStorageDirectory()
        : await getApplicationDocumentsDirectory();
    return appDocDir.path;
  }

  Future<String> getFilePath(String filename) async {
    final appDocDir = await getAppDocDir();
    print("getfilepath - " + appDocDir + '/$filename.epub');
    return appDocDir + '/$filename.epub';
  }

  Future<bool> fileExistsInAppDir(String filename) async {
    final path = await getFilePath(filename);
    print(path);
    final file = File(path);
    return await file.exists();
  }

  void startDownload(BuildContext context) async {
    final path = await getFilePath(selectedMaterial.id);

    File file = File(path);
    if (await file.exists()) await file.delete();

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => DownloadAlert(
        material: selectedMaterial,
        downloadPath: path,
      ),
    ).then((v) {
      if (v != null) {
        _downloadsDb.addMaterial(selectedMaterial.toMiniJSON());
      }
    });
  }

  void getMaterialDetail(String id) {
    _api.getMaterialDetail(id).then((Response res) async {
      final Map<String, dynamic> body = res.data;

      if (!body['success']) {
        print(body['message']);
        loadingState = LoadingState.failed;
        return notifyListeners();
      }

      _selectedMaterial = MaterialDetail.fromJSON(body['data']['material']);

      loadingState = LoadingState.success;
      return notifyListeners();
    }).catchError((err) {
      print(err);
      loadingState = LoadingState.failed;
      return notifyListeners();
    });
  }
}
