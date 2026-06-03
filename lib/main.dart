import 'package:basic_fundamental/route/app_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  runApp(const root());
}

class root extends StatefulWidget {
  const root({super.key});

  @override
  State<root> createState() => _rootState();
}

class _rootState extends State<root> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: appRoute.splash,
      getPages: appRoute.route,
    );
  }
}

