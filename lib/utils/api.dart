import 'package:dio/dio.dart';

class Api {
  Dio dio = Dio();
  static String baseUrl = 'http://10.6.212.217:5000/api/v1';
  static String readerBaseUrl = baseUrl + '/reader';
  static String mediaBaseUrl = baseUrl + '/media';

  static String initialDataUrl = readerBaseUrl + '/initialData';
  static String materialsUrl = readerBaseUrl + '/materials';
  static String providersUrl = readerBaseUrl + '/providers';
  static String downloadMaterialUrl = mediaBaseUrl + '/materials';
  static String signupUrl = readerBaseUrl + '/signup';
  static String loginUrl = readerBaseUrl + '/login';
  static String logoutUrl = readerBaseUrl + '/logout';

  Future<Response> getInitialData() {
    return dio.get(initialDataUrl);
  }

  Future<Response> getMaterials(String type) {
    final url = '$materialsUrl?type=$type';
    return dio.get(url);
  }

  Future<Response> getMaterialDetail(String id) {
    final url = '$materialsUrl/$id';
    return dio.get(url);
  }

  Future<Response> signupReader(Map<String, String> credentials) {
    return dio.post(signupUrl, data: credentials);
  }

  Future<Response> loginReader(String email, String password) {
    return dio.post('$loginUrl', data: {"email": email, "password": password});
  }

  Future<Response> logoutReader(String token) {
    dio.options.headers['content-Type'] = 'application/json';
    dio.options.headers["authorization"] = token;
    return dio.post('$logoutUrl', data: {});
  }
}
