import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../service/auth_service.dart';
import '../app_route.dart';

class auth_guard extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    if (Auth_service.isAuthenticate && route == appRoute.login) {
      return const RouteSettings(name: appRoute.mainHome);
    }

    if (!Auth_service.isAuthenticate && route != appRoute.login) {
      return const RouteSettings(name: appRoute.login);
    }
    return null;
  }
}
