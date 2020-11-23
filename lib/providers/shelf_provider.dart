import 'package:atrons_mobile/database/downloads.dart';
import 'package:atrons_mobile/models/material.dart';
import 'package:atrons_mobile/providers/loading_state.dart';
import 'package:flutter/cupertino.dart';

class ShelfProvider extends ChangeNotifier {
  final _downloadsDb = DownloadsDB();

  LoadingState _loadingState = LoadingState.loading;
  get loadingState => _loadingState;

  List<MiniMaterial> _downloadedMaterials = [];
  get downloadedMaterials => _downloadedMaterials;

  void fetchDownloadedMaterials() async {
    _downloadedMaterials = await _downloadsDb.getAllMaterials();
    _loadingState = LoadingState.success;
    return notifyListeners();
  }

  void addToShelf(MiniMaterial material) {
    _downloadedMaterials.add(material);
  }

  void removeFromShelf(String id) {
    _downloadedMaterials.removeWhere((element) => element.iD == id);
  }
}
