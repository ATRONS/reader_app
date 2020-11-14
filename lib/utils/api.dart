import 'package:atrons_mobile/models/material.dart';
import 'package:dio/dio.dart';

class Api {
  Dio dio = Dio();
  static String baseUrl = 'http://192.168.43.188:5000/api/v1/reader';
  static String initialData = '/initialData';

  Future<Map<String, dynamic>> getInitialBooks() async {
    var res = await dio.get(baseUrl + initialData).catchError((err) {
      throw err;
    });

    return res.data;
  }
}
