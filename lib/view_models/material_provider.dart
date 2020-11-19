import 'package:atrons_mobile/database/downloads.dart';
import 'package:atrons_mobile/models/genere.dart';
import 'package:atrons_mobile/models/material.dart';
import 'package:atrons_mobile/utils/api.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'loading_state.dart';

class MaterialProvider extends ChangeNotifier {
  Api _api = Api();
  final _downloadsDb = DownloadsDB();

  List<Genere> _generes;
  List<Genere> get generes => _generes;
  Map<String, List<MiniMaterial>> _popular;
  Map<String, List<MiniMaterial>> get popular => _popular;

  LoadingState initialDataLoadingState = LoadingState.loading;
  LoadingState bookLoadingState = LoadingState.loading;
  LoadingState magazineLoadingState = LoadingState.loading;
  LoadingState newspapaerLoadingState = LoadingState.loading;

  void loadInitialData() {
    _api.getInitialData().then((Response response) {
      final Map<String, dynamic> body = response.data;

      if (!body['success']) {
        initialDataLoadingState = LoadingState.failed;
        print(body['message']);
        return notifyListeners();
      }

      _generes = List<dynamic>.from(body['data']['generes'])
          .map((genere) => Genere.fromJSON(genere))
          .toList();

      _popular = Map();

      Map<String, List<dynamic>>.from(body['data']['popular'])
          .forEach((genereId, materials) {
        final mini =
            materials.map((json) => MiniMaterial.fromJSON(json)).toList();
        _popular[genereId] = mini;
      });

      initialDataLoadingState = LoadingState.success;
      return notifyListeners();
    }).catchError((err) {
      initialDataLoadingState = LoadingState.failed;
      print(err);
      return notifyListeners();
    });
  }

  getDownloadedMaterials() async {
    final materials = await _downloadsDb.getAllMaterials();
    print(materials);
  }

  void setInitialDataState(LoadingState state) {
    initialDataLoadingState = state;
    return notifyListeners();
  }
}
