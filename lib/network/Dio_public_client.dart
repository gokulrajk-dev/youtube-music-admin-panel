import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class DioPublicClient {
  static final DioPublicClient _instance = DioPublicClient._internal();
  late Dio dio;

  factory DioPublicClient() => _instance;

  DioPublicClient._internal() {
    dio = Dio(BaseOptions(
        baseUrl: dotenv.env['API_BASE_URL']!,
        headers: {'Content-Type': 'application/json'}));
  }
}
