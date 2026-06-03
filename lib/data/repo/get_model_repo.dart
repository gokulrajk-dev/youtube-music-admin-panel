import 'package:basic_fundamental/network/ApiEndpoint.dart';
import 'package:basic_fundamental/network/Dio_pri_client.dart';

class GetModelCrud{
  final dio = DioPrivateClient().dio;

  Future<List<String>> getModelsName() async{
    final response = await dio.get(ApiEndpoint.getAllModel);
    return List<String>.from(response.data);
  }

}