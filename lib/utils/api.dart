import 'package:dio/dio.dart';

class Api {
  Dio dio = Dio();
  static String baseUrl = 'http://192.168.43.240:5000/api/v1';
  static String readerBaseUrl = baseUrl + '/reader';
  static String mediaBaseUrl = baseUrl + '/media';

  static String initialDataUrl = readerBaseUrl + '/initialData';
  static String materialsUrl = readerBaseUrl + '/materials';
  static String providersUrl = readerBaseUrl + '/providers';
  static String downloadMaterialUrl = mediaBaseUrl + '/materials';
  static String signupUrl = readerBaseUrl + '/signup';
  static String loginUrl = readerBaseUrl + '/login';

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
}
