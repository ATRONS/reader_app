import 'package:atrons_mobile/models/genere.dart';
import 'package:atrons_mobile/models/material.dart';
import 'package:atrons_mobile/utils/api.dart';
import 'package:flutter/cupertino.dart';

enum LoadingState { failed, loading, success }

class MaterialProvider extends ChangeNotifier {
  Api api = Api();

  List<Genere> _generes;
  List<Genere> get generes => _generes;
  Map<String, List<MiniMaterial>> _popular;
  Map<String, List<MiniMaterial>> get popular => _popular;

  LoadingState loadingState = LoadingState.loading;

  Future getInitialBookData() async {
    print('got here');
    Map<String, dynamic> response = await api.getInitialBooks();

    if (!response["success"]) {
      loadingState = LoadingState.failed;
      print('request failed');
      return notifyListeners();
    }

    _generes = List<dynamic>.from(response['data']['generes'])
        .map((genere) => Genere.fromJSON(genere))
        .toList();

    _popular = Map();

    Map<String, List<dynamic>>.from(response['data']['popular'])
        .forEach((genereId, materials) {
      var mini = materials.map((json) => MiniMaterial.fromJSON(json)).toList();
      return _popular[genereId] = mini;
    });

    loadingState = LoadingState.success;
    print('finished loading');
    notifyListeners();
  }

  void getMaterialDetail(String id) {}
}
