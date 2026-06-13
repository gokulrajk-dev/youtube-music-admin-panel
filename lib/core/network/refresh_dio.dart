import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class RefreshDio {
  static final RefreshDio _intance = RefreshDio.internal();
  late Dio dio;

  factory RefreshDio() => _intance;

  RefreshDio.internal() {
    dio = Dio(BaseOptions(
        baseUrl: dotenv.env['API_BASE_URL']!,
        headers: {'Content-Type': 'application/json'}));
  }
}
