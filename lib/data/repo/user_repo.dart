import 'package:dio/dio.dart';

import '../../core/network/ApiEndpoint.dart';
import '../../core/network/Dio_pri_client.dart';
import '../../core/network/Dio_public_client.dart';
import '../data_model/user_details.dart';

class User_Respository {
  final Dio dio = DioPublicClient().dio;
  final Dio dio1 = DioPrivateClient().dio;

  Future<Map<String, dynamic>> get_new_login(String googleIdToken) async {
    final response = await dio
        .post(ApiEndpoint.new_login, data: {'google_id_token': googleIdToken});
    return response.data;
  }

  Future<Map<String, dynamic>> refreshTokens(String refreshToken) async {
    final response = await dio
        .post(ApiEndpoint.refresh_token, data: {'refresh': refreshToken});
    return response.data;
  }

  Future<UserDetails> get_currents_user() async {
    final response = await dio1.get(ApiEndpoint.get_current_user);
    return UserDetails.fromJson(response.data[0]);
  }
}
