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

  List<MiniCompanyMaterial> _magazineList;
  List<MiniCompanyMaterial> get magazineList => _magazineList;

  List<MiniCompanyMaterial> _newspaperList;
  List<MiniCompanyMaterial> get newspaperList => _newspaperList;

  List<MiniMaterial> _listOfCompanyMaterials;
  List<MiniMaterial> get listOfCompanyMaterials => _listOfCompanyMaterials;

  LoadingState initialDataLoadingState = LoadingState.loading;
  LoadingState bookLoadingState = LoadingState.loading;
  LoadingState magazineLoadingState = LoadingState.loading;
  LoadingState newspapaerLoadingState = LoadingState.loading;
  LoadingState materialListLoadingState = LoadingState.loading;

  void loadInitialData() {
    _api.getInitialData().then((Response response) {
      final Map<String, dynamic> body = response.data;

      if (!body['success']) {
        initialDataLoadingState = LoadingState.failed;
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

      _magazineList = List.from(body['data']['magazines']['providers'])
          .map((json) => MiniCompanyMaterial.fromJSON(json))
          .toList();

      _newspaperList = List.from(body['data']['newspapers']['providers'])
          .map((json) => MiniCompanyMaterial.fromJSON(json))
          .toList();

      initialDataLoadingState = LoadingState.success;
      return notifyListeners();
    }).catchError((err) {
      initialDataLoadingState = LoadingState.failed;
      print(err);
      return notifyListeners();
    });
  }

  Future<List<MiniMaterial>> loadListOfCompanyMaterials(
      String materialId) async {
    final response = await _api.getMaterialsByProvider(materialId);
    final Map<String, dynamic> body = response.data;

    if (!body['success']) {
      materialListLoadingState = LoadingState.failed;
      return [];
    }

    return List.from(body['data']['materials'])
        .map((json) => MiniMaterial.fromJSON(json))
        .toList();
  }

  Future<List<MaterialDetail>> ownedMaterialsRequest() async {
    final response = await _api.getOwenedMaterial();
    final Map<String, dynamic> body = response.data;

    return List.from(body['data']).map((json) {
      json['more_from_provider'] = {'materials': []};
      json['provider'] = {'empty': 'value'};
      json['material_ratings'] = {'ratings': []};
      return MaterialDetail.fromJSON(json);
    }).toList();
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

  Future<List<MiniMaterial>> searchMaterial(String query, bool typebook,
      bool typemagazine, bool typenewspaper) async {
    final String filterbook = typebook ? "BOOK|" : "";
    final String filternewspaper = typenewspaper ? "NEWSPAPER|" : "";
    final String filtermagazine = typemagazine ? "MAGAZINE" : "";

    final String querytype = filterbook + filternewspaper + filtermagazine;

    try {
      final response = await _api.searchMaterial(query, querytype);
      final Map<String, dynamic> body = response.data;

      return List.from(body['data']['materials'])
          .map((json) => MiniMaterial.fromJSON(json))
          .toList();
    } catch (err) {
      return [];
    }
  }

  Future<List<MiniMaterial>> findInGenre(String genreId) async {
    try {
      final response = await _api.findBooksFromGenre(genreId);
      final Map<String, dynamic> body = response.data;

      return List.from(body['data']['materials'])
          .map((json) => MiniMaterial.fromJSON(json))
          .toList();
    } catch (err) {
      return [];
    }
  }

  // Future<List<MiniMaterial>> getWishListRequest() async {
  //   try {
  //     final response = await _api.getWishlists();
  //     final Map<String, dynamic> body = response.data;

  //     return List.from(body['data']['materials'])
  //         .map((json) => MiniMaterial.fromJSON(json))
  //         .toList();
  //   } catch (err) {
  //     return [];
  //   }
  // }

  // Future<List<MiniMaterial>> makeWishListRequest(String materialID) async {
  //   try {
  //     final response = await _api.makeFavorite({"material": materialID});
  //     final Map<String, dynamic> body = response.data;

  //     return List.from(body['data']['materials'])
  //         .map((json) => MiniMaterial.fromJSON(json))
  //         .toList();
  //   } catch (err) {
  //     return [];
  //   }
  // }

  Future<String> purchaseMaterial(
      String purchaseMaterialId, String phoneNumber) async {
    try {
      final response = await _api
          .purchaseMaterial(purchaseMaterialId, {'phone': phoneNumber});
      final Map<String, dynamic> body = response.data;

      return body['data']['code'];
    } catch (err) {
      return "";
    }
  }

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
