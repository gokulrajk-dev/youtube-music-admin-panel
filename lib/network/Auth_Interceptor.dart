import 'package:basic_fundamental/network/refresh_dio.dart';
import 'package:basic_fundamental/service/TokenService.dart';
import 'package:dio/dio.dart';

class AuthInterceptor extends Interceptor{
  final Dio dio;
  AuthInterceptor(this.dio);

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final access = await Token_service.get_access_token();
    if(access !=null){
      options.headers['Authorization'] = 'Bearer $access';
    }
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if(err.response?.statusCode==401){
      final refresh = await Token_service.get_refresh_token();

      if(refresh ==null){
        Token_service.clear_token();
        return handler.next(err);
      }

      try{
        final response = await RefreshDio.internal().dio.post(
          '/user_accounts/auth/token/refresh/',
          data: {'refresh': refresh},
        );

        final NewAccess = response.data['access'];
        final NewRefresh = response.data['refresh'];

        await Token_service.set_access_refresh_token(NewAccess, NewRefresh);

        err.requestOptions.headers['Authorization']='Bearer $NewAccess';

        final retryResponse = await dio.fetch(err.requestOptions);

        return handler.resolve(retryResponse);

      }catch(_){}
    }
    handler.next(err);
  }
}