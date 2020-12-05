import 'dart:io';
import 'package:atrons_mobile/database/downloads.dart';
import 'package:atrons_mobile/fragments/download_alert.dart';
import 'package:atrons_mobile/models/material.dart';
import 'package:atrons_mobile/providers/shelf_provider.dart';
import 'package:atrons_mobile/utils/api.dart';
import 'package:atrons_mobile/utils/file_helper.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import 'loading_state.dart';

class DetailProvider extends ChangeNotifier {
  final _api = Api();
  final _downloadsDb = DownloadsDB();

  MaterialDetail _selectedMaterial;
  MaterialDetail get selectedMaterial => _selectedMaterial;
  LoadingState _loadingState = LoadingState.loading;
  LoadingState get loadingState => _loadingState;

  LoadingState setRatingState = LoadingState.uninitialized;

  bool _isDownloaded = false;
  bool get isDownloaded => _isDownloaded;

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

  void startDownload(BuildContext context) async {
    final path = await getEpubFilePath(selectedMaterial.id);

    File file = File(path);
    if (await file.exists()) await file.delete();

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => DownloadAlert(
        material: selectedMaterial,
      ),
    ).then((v) async {
      if (v != null) {
        final mini = selectedMaterial.toMiniJSON();
        mini['cover_img_file_url'] = await getImgFilePath(mini['_id']);
        final shelfProvider =
            Provider.of<ShelfProvider>(context, listen: false);
        _downloadsDb.addMaterial(shelfProvider, mini);
        _isDownloaded = true;
        return notifyListeners();
      }
    });
  }

  void getMaterialDetail(String id) {
    _api.getMaterialDetail(id).then((Response res) async {
      final Map<String, dynamic> body = res.data;

      if (!body['success']) {
        print(body['message']);
        _loadingState = LoadingState.failed;
        return notifyListeners();
      }

      _selectedMaterial = MaterialDetail.fromJSON(body['data']);
      _loadingState = LoadingState.success;
      return notifyListeners();
    }).catchError((err) {
      print(err);
      _loadingState = LoadingState.failed;
      return notifyListeners();
    });
  }

  void setMaterialRating(int value, String rating, String id) {
    _loadingState = LoadingState.uninitialized;
    _api.rateMaterial(value, rating, id).then((Response res) async {
      final Map<String, dynamic> body = res.data;

      if (!body['success']) {
        print(body['message']);
        _loadingState = LoadingState.failed;
        return notifyListeners();
      }
      _loadingState = LoadingState.success;
      _selectedMaterial.readersLastRating = {
        "value": value,
        "description": rating
      };
      return notifyListeners();
    }).catchError((err) {
      print(err);
      _loadingState = LoadingState.failed;
      return notifyListeners();
    });
  }

  void setLoadingState(LoadingState state) {
    _loadingState = state;
  }

  void setRatingStateMethod(LoadingState state) {
    setRatingState = state;
  }

  void setIsDownloaded(bool downloaded) {
    _isDownloaded = downloaded;
  }

  void setReadersLastRating(Map<String, dynamic> rating) {
    _selectedMaterial.readersLastRating = rating;
  }
}
