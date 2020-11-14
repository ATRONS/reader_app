import 'package:dio/dio.dart';

class Api {
  Dio dio = Dio();
  static String baseUrl = 'http://10.6.152.134:5000/api/v1/';
  static String readerBaseUrl = baseUrl + '/reader';
  static String initialData = '/initialData';

  Future<Map<String, dynamic>> getInitialBooks() async {
    var res = await dio.get(readerBaseUrl + initialData).catchError((err) {
      throw err;
    });

    return res.data;
  }
}
