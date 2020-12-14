import 'package:atrons_mobile/models/material.dart';
import 'package:atrons_mobile/utils/file_helper.dart';
import 'package:dio/dio.dart';

class Api {
  static final Dio _dio = Dio();
  // 192.168.43.240
  static String baseUrl = 'http://192.168.43.186:5000/api/v1';
  static String readerBaseUrl = baseUrl + '/reader';
  static String mediaBaseUrl = baseUrl + '/media';

  static String initialDataUrl = readerBaseUrl + '/initialData';
  static String materialsUrl = readerBaseUrl + '/materials';
  static String providersUrl = readerBaseUrl + '/providers';
  static String downloadMaterialUrl = mediaBaseUrl + '/materials';
  static String signupUrl = readerBaseUrl + '/signup';
  static String loginUrl = readerBaseUrl + '/login';
  static String logoutUrl = readerBaseUrl + '/logout';
  static String verifyUrl = readerBaseUrl + '/verifyEmail';

  static setAuthToken(String token) {
    _dio.options.headers['content-Type'] = 'application/json';
    _dio.options.headers["Authorization"] = token;
  }

  Future<Response> getInitialData() {
    print(_dio.options.headers);
    return _dio.get(initialDataUrl);
  }

  Future<Response> getMaterialsByType(String type) {
    final url = '$materialsUrl?type=$type';
    return _dio.get(url);
  }

  Future<Response> getMaterialsByProvider(String providerId) {
    final url = '$materialsUrl?provider=$providerId';
    return _dio.get(url);
  }

  Future<Response> getProviders(String provides) {
    final url = '$providersUrl?provides=$provides';
    return _dio.get(url);
  }

  Future<Response> searchMaterial(String query, String querytype) {
    final url = '$materialsUrl?search=$query&type=$querytype';
    return _dio.get(url);
  }

  Future<Response> rateMaterial(int value, String rating, String id) {
    return _dio.put('$materialsUrl/$id/ratings',
        data: {'value': value, 'description': rating});
  }

  Future<Response> getMaterialDetail(String id) {
    final url = '$materialsUrl/$id';
    print('get material detail called');
    return _dio.get(url);
  }

  Future<Response> signupReader(Map<String, String> credentials) {
    return _dio.post(signupUrl, data: credentials);
  }

  Future<Response> loginReader(String email, String password) {
    return _dio.post('$loginUrl', data: {"email": email, "password": password});
  }

  Future<Response> logoutReader() {
    return _dio.post('$logoutUrl');
  }

  Future<Response> verifyEmail(String otp) {
    return _dio.put(verifyUrl, data: {"otp": otp});
  }

  void download(MaterialDetail material, Function onProgress, Function onFinish,
      Function onError) async {
    final fileurl = baseUrl + material.file['url'];
    final imgUrl = material.coverImgUrl;
    final downloadPath = await getEpubFilePath(material.id);
    final imgDownloadPath = await getImgFilePath(material.id);

    // download material epub file
    await _dio
        .download(fileurl, downloadPath,
            deleteOnError: true, onReceiveProgress: onProgress)
        .then((val) async {
      // download cover_img
      await _dio
          .download(imgUrl, imgDownloadPath, deleteOnError: true)
          .then((value) => onFinish())
          .catchError(onError);
    }).catchError(onError);
  }
}
