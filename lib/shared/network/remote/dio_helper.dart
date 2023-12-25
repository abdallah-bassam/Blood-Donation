import 'package:dio/dio.dart';

class DioHelper {
  static Dio? dio;

  static init() {
    dio = Dio(BaseOptions(
      baseUrl: 'https://student.valuxapps.com/api/',
      headers: {'Content-Type': 'application/json'},
      receiveDataWhenStatusError: true,
    ));
  }

  static Future<Response> getFromDatabase(
      {required String url, required Map<String, dynamic> query}) async {
    return await dio!.get(url, queryParameters: query);
  }

  static Future<Response> postData(
      {required Map<String, dynamic> data,
      required String url,
      Map<String, dynamic>? query}) {
    return dio!.post(url,queryParameters: query,data: data);
  }
}
