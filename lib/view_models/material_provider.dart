import 'package:atrons_mobile/models/genere.dart';
import 'package:atrons_mobile/models/material.dart';
import 'package:atrons_mobile/utils/api.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

enum LoadingState { failed, loading, success, loadingMore }

class MaterialProvider extends ChangeNotifier {
  Api api = Api();

  List<Genere> _generes;
  List<Genere> get generes => _generes;
  Map<String, List<MiniMaterial>> _popular;
  Map<String, List<MiniMaterial>> get popular => _popular;

  LoadingState initialDataLoadingState = LoadingState.loading;
  LoadingState bookLoadingState = LoadingState.loading;
  LoadingState magazineLoadingState = LoadingState.loading;
  LoadingState newspapaerLoadingState = LoadingState.loading;

  void loadInitialData() {
    api.getInitialData().then((Response response) {
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
        var mini =
            materials.map((json) => MiniMaterial.fromJSON(json)).toList();
        return _popular[genereId] = mini;
      });

      initialDataLoadingState = LoadingState.success;
      return notifyListeners();
    }).catchError((err) {
      initialDataLoadingState = LoadingState.failed;
      print(err);
      return notifyListeners();
    });
  }

  void getMaterialDetail(String id) {
    api.getMaterialDetail(id).then((value) {}).catchError((err) {});
  }
}
