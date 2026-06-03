
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class DioPrivateClient{
  static final DioPrivateClient _instance = DioPrivateClient._internal();
  late Dio dio;

  factory DioPrivateClient()=>_instance;

  DioPrivateClient._internal(){
    dio=Dio(
      BaseOptions(
        baseUrl: dotenv.env['API_BASE_URL']!,
        headers: {'Content-Type': 'application/json'}
      )
    );
    // dio.interceptors.add(AuthInterceptor(dio));
  }

}
