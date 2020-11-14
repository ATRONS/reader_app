import 'package:atrons_mobile/utils/api.dart';
import 'package:flutter/cupertino.dart';

class MaterialProvider extends ChangeNotifier {
  Api api = Api();

  List<dynamic> generes;
  List<dynamic> popular;

  void getInitialBookData() async {
    Map<String, dynamic> response = await api.getInitialBooks();
    if (!response["success"]) {
      print('request failed');
      return;
    }
    generes = response["data"]["generes"];
    popular = response["data"]["popular"];
    print(generes);
    print(popular);
  }

  void getMaterialDetail(String id) {}
}
