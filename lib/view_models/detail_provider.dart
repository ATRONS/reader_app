import 'dart:io';

import 'package:atrons_mobile/fragments/download_alert.dart';
import 'package:atrons_mobile/models/material.dart';
import 'package:atrons_mobile/utils/api.dart';
import 'package:atrons_mobile/utils/constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import 'loading_state.dart';

class DetailProvider extends ChangeNotifier {
  final api = Api();
  MaterialDetail _selectedMaterial;
  MaterialDetail get selectedMaterial => _selectedMaterial;
  LoadingState loadingState = LoadingState.loading;

  Future downloadFile(
      BuildContext context, String url, String filename, int total) async {
    PermissionStatus permission = await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.storage);

    if (permission != PermissionStatus.granted) {
      await PermissionHandler().requestPermissions([PermissionGroup.storage]);
      startDownload(context, url, filename, total);
    } else {
      startDownload(context, url, filename, total);
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
    String path = Platform.isIOS
        ? appDocDir + filename
        : appDocDir.split('Android')[0] + '${Constants.appName}/$filename.epub';
    return path;
  }

  Future<bool> fileExistsInAppDir(String filename) async {
    final path = await getFilePath(filename);
    final file = File(path);
    return await file.exists();
  }

  void startDownload(
      BuildContext context, String url, String filename, int total) async {
    final path = await getFilePath(filename);
    if (Platform.isAndroid) {
      Directory(path.split('Android')[0] + '${Constants.appName}').createSync();
    }

    File file = File(path);
    if (!await file.exists()) {
      await file.create();
    } else {
      await file.delete();
      await file.create();
    }

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => DownloadAlert(
        url: url,
        path: path,
        total: total,
      ),
    ).then((v) {
      if (v != null) {
        print('download finished');
      }
    });
  }

  void getMaterialDetail(String id) {
    api.getMaterialDetail(id).then((Response res) async {
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
      print('error in here');
      loadingState = LoadingState.failed;
      return notifyListeners();
    });
  }
}
