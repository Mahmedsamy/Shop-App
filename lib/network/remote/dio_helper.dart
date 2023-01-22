

import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';


class DioHelper {
  static Dio? dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
      ));
  }


  static Future<Response> getData({
    required String url,
    required dynamic query,
    String lang = 'ar',
    String? token ,
  }) async
  {

    dio!.options .headers ={

      'Content-Type' : 'application/json ',
      'lang':'en',
      'Authorization': token,
    };

    return await dio!.get(
      url,
      queryParameters: query,
    );
  }


  static Future<Response> postData({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
    String lang = 'ar',
    String? token ,
  }) async {
    dio!.options.headers ={
      'lang':lang,
      'Authorization': token??'',
      'Content-Type': 'application/json',
    };
    // (dio?.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
    //     (HttpClient dioClient) {
    //   dioClient.badCertificateCallback =
    //   ((X509Certificate cert, String host, int port) => true);
    //   return dioClient;
    // };
    return await dio!.post(
      url,
      data: data,
    );
  }
}
