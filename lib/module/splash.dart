import 'package:basic_fundamental/route/app_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3),()=>Get.toNamed(appRoute.mainHome));
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          height: 200,
          width: 200,
          child: const CircleAvatar(
            radius: 100,
            backgroundImage: AssetImage('assets/yt.png'),
          ),
        ),
      ),
    );
  }
}
