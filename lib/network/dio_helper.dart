import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class DioHelper
{
  static Dio? dio;

  static init()
  {
    dio = Dio(
      BaseOptions(
        baseUrl: '  ',
        receiveDataWhenStatusError: true,
      ),
    );
  }


   static Future<Response> getData({
  required String url,
  required dynamic query,
}) async
   {
    return await dio!.get(
      url,
      queryParameters: query,
    );
   }
}