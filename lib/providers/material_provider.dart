import 'dart:convert';

import 'package:atrons_mobile/database/downloads.dart';
import 'package:atrons_mobile/database/locator.dart';
import 'package:atrons_mobile/models/genere.dart';
import 'package:atrons_mobile/models/material.dart';
import 'package:atrons_mobile/providers/user_provider.dart';
import 'package:atrons_mobile/utils/api.dart';
import 'package:atrons_mobile/utils/crypt.dart';
import 'package:atrons_mobile/utils/file_helper.dart';
import 'package:dio/dio.dart';
import 'package:epub_viewer/epub_viewer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

      Map<String, Map<String, dynamic>>.from(body['data']['popular'])
          .forEach((genereId, subDoc) {
        final mini = List.from(subDoc['materials'])
            .map((json) => MiniMaterial.fromJSON(json))
            .toList();
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

  void loadNewsPapers() async {
    _api.getProviders("NEWSPAPER").then((Response res) {
      print(res.data);
    }).catchError((err) {
      newspapaerLoadingState = LoadingState.failed;
      notifyListeners();
    });
  }

  void loadMagazines() {}

  Future<List<MiniMaterial>> getDownloadedMaterials() async {
    return await _downloadsDb.getAllMaterials();
  }

  void setInitialDataState(LoadingState state) {
    initialDataLoadingState = state;
    return notifyListeners();
  }

  String getGenereName(String id, GenereLang lang) {
    final List<Genere> generes =
        _generes.where((genere) => genere.id == id).toList();
    if (generes.length != 1) return "should not happen";
    return generes[0].getGenereName(lang);
  }

  void openMaterial(BuildContext context, String id) async {
    final user = Provider.of<UserProvider>(context, listen: false).user;
    final url = await getEpubFilePath(id);
    final tempUrl = await getEpubTempFilePath(id);

    final decrypted = await decryptFile(url, tempUrl, user.key, user.iv);
    if (!decrypted) {
      print('DECRYPTION FAILED FOR SOME REASON');
      return;
    }

    List locators = await LocatorDB().getLocator(id);

    EpubViewer.setConfig(
      themeColor: Theme.of(context).primaryColor,
      identifier: "androidBook",
      scrollDirection: EpubScrollDirection.ALLDIRECTIONS,
      allowSharing: false,
      enableTts: false,
    );
    EpubViewer.open(tempUrl,
        lastLocation:
            locators.isNotEmpty ? EpubLocator.fromJson(locators[0]) : null);

    EpubViewer.locatorStream.listen((event) async {
      Map json = jsonDecode(event);
      json['bookId'] = id;
      await LocatorDB().update(json);
    });
  }
}
