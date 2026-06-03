import 'package:basic_fundamental/data/data_model/Artist.dart';
import 'package:basic_fundamental/module/page/main_home_page/mainHomeController.dart';
import 'package:basic_fundamental/module/page/modelEditPage/modelEditPageController.dart';
import 'package:basic_fundamental/network/ApiEndpoint.dart';
import 'package:basic_fundamental/route/app_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';

class mainHomePage extends StatefulWidget {
  const mainHomePage({super.key});

  @override
  State<mainHomePage> createState() => _mainHomePageState();
}

class _mainHomePageState extends State<mainHomePage> {
  final mainHomeController getSong = Get.find<mainHomeController>();
  final GetModelEditController getModel = Get.find<GetModelEditController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
              pinned: true,
              // expandedHeight: 300,
              // flexibleSpace: FlexibleSpaceBar(
              //   collapseMode: CollapseMode.pin,
              //   background: Stack(
              //     fit: StackFit.loose,
              //     children: [
              //       Image.asset('assets/_joker1.png'),
              //     ],
              //   ),
              // ),
              backgroundColor: Colors.white,
              leading: const CircleAvatar(
                backgroundImage: AssetImage('assets/yt.png'),
              ),
              title: const Text(
                "YT Developer",
                style: TextStyle(color: Colors.black),
              ),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.notifications_none),
                  color: Colors.black,
                ),
                Builder(builder: (context) {
                  return GestureDetector(
                    onTap: () {},
                    child: const CircleAvatar(
                      backgroundImage: AssetImage('assets/_joker1.png'),
                    ),
                  );
                })
              ]),
          SliverToBoxAdapter(
              child: Obx(
            () => Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: getSong.gets_model.length,
                itemBuilder: (context, index) {
                  final model = getSong.gets_model[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: AnimationConfiguration.staggeredList(
                        position: index,
                        duration: const Duration(milliseconds: 500),
                        child: SlideAnimation(
                            horizontalOffset: 500.0,
                            child: FadeInAnimation(
                                child: GestureDetector(
                              onTap: () {
                                getModel.modelEditFunk(
                                    ApiEndpoint.artist, Artist.fromJson);
                                Get.toNamed(appRoute.getModel);
                              },
                              child: AnimatedContainer(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                        width: 0.5, color: Colors.black)),
                                duration: const Duration(milliseconds: 300),
                                height: 100,
                                child: Center(
                                  child: Text(
                                    model,
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              ),
                            )))),
                  );
                },
              ),
            ),
          ))
        ],
      ),
    );
  }
}
