import 'package:dio/dio.dart';

class Api {
  Dio dio = Dio();
  static String baseUrl = 'http://192.168.43.113:5000/api/v1/';
  static String readerBaseUrl = baseUrl + '/reader';

  static String initialDataUrl = readerBaseUrl + '/initialData';
  static String materialsUrl = readerBaseUrl + '/materials';
  static String providersUrl = readerBaseUrl + '/providers';

  Future<Response> getInitialData() async {
    return dio.get(initialDataUrl);
  }

  Future<Response> getMaterials(String type) {
    final url = '$materialsUrl?type=$type';
    return dio.get(url);
  }

  Future<Map<String, dynamic>> getMaterialDetail(String id) async {
    final url = '$materialsUrl/id';
    final res = await dio.get(url);
    return res.data;
  }
}
