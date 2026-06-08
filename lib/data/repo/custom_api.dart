import 'package:basic_fundamental/network/Dio_pri_client.dart';

class dynamicApi<mod> {
  final dio = DioPrivateClient().dio;

  dynamicApi();

  Future<List<mod>> getFunction(String api, mod Function(Map<String, dynamic>) fromJson) async {
    final response = await dio.get(api);
    return (response.data as List).map((e) => fromJson(e)).toList();
  }

  Future<mod> getDetailFunction(String api,mod Function(Map<String,dynamic>) fromJson)async{
    final response = await dio.get(api);
    return fromJson(response.data);
  }

}
