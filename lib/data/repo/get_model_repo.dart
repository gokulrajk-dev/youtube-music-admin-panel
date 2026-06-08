import 'package:basic_fundamental/network/ApiEndpoint.dart';
import 'package:basic_fundamental/network/Dio_pri_client.dart';
import 'package:dio/dio.dart';

class GetModelCrud {
  final dio = DioPrivateClient().dio;

  // Future<List<String>> getModelsName() async {
  //   final response = await dio.get(ApiEndpoint.getAllModel);
  //   if(response.statusCode ==200){
  //     return List<String>.from(response.data);
  //   }
  //   switch(response.statusCode){
  //     case 401:
  //       throw Exception("Unauthorized");
  //     case 403:
  //       throw Exception("Forbidden");
  //     case 404:
  //       throw Exception("Not Found");
  //     default:
  //       throw Exception("Something went wrong");
  //   }
  // }


  Future<List<String>> getModelsName() async {
    try {
      final response = await dio.get(ApiEndpoint.getAllModel);
      return List<String>.from(response.data);

    } on DioException catch (e) {

      switch (e.response?.statusCode) {
        case 401:
          throw Exception("Unauthorized User ,This app only for Developer and Superuser");

        case 403:
          throw Exception("Forbidden,You Don't Have the permission to use this app");

        case 404:
          throw Exception("Not Found");

        default:
          throw Exception(
            e.response?.statusMessage ?? "Something went wrong",
          );
      }
    }
  }
}
