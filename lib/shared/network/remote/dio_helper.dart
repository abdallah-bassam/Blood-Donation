import 'package:dio/dio.dart';

class DioHelper {
  static Dio? dio;

  static init() {
    dio = Dio(BaseOptions(
        baseUrl: 'http://192.168.1.17:8080/',
        receiveDataWhenStatusError: true));
  }

  static Future<Response> getDatabase(
      {required String url, Map<String, dynamic>? query}) async {
    return await dio!.get(url, queryParameters: query);
  }

  static Future<Response> postToDatabase(
      {required url, Map <String,dynamic>? query, required Map <String,dynamic> data}) {
    return dio!.post(url,queryParameters: query,data: data);
  }

  static Future<Response> putToDatabase({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
  }) async {
    return await dio!.put(url, queryParameters: query, data: data);
  }

  static Future<Response> deleteFromDatabase({
    required String url,
    Map<String, dynamic>? query,
  }) async {
    return await dio!.delete(url, queryParameters: query);
  }

}
