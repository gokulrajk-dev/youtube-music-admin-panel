import 'package:basic_fundamental/module/page/main_home_page/mainHomeController.dart';
import 'package:basic_fundamental/module/page/modelEditPage/controller/modelEditPageController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';

import '../../../data/registry/model_registry.dart';
import '../../../data/registry/model_type.dart';
import '../login/loginController.dart';
import '../modelEditPage/view/modelEditPageViews.dart';

class mainHomePage extends StatefulWidget {
  const mainHomePage({super.key});

  @override
  State<mainHomePage> createState() => _mainHomePageState();
}

class _mainHomePageState extends State<mainHomePage> {
  final mainHomeController getSong = Get.find<mainHomeController>();
  final GetModelEditController getModel = Get.find<GetModelEditController>();
  final auth_google_login auth = Get.find<auth_google_login>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: RefreshIndicator(
        backgroundColor: Colors.black,
        color: Colors.red,
        edgeOffset: 20,
        displacement: 100,
        onRefresh: () async {
          await getSong.refreshHome([
            getSong.showModel(),
          ]);
        },
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverAppBar(
                pinned: true,
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
                    onPressed: () {
                      auth.signOut();
                    },
                    icon: const Icon(Icons.logout),
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
            SliverToBoxAdapter(child: Obx(() {
              if (getSong.error.isNotEmpty) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height * 0.8,
                  child: Center(
                    child:
                        Text(getSong.error.value.replaceAll("Exception:", "")),
                  ),
                );
              }
              return Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
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
                                  final modelType = getModelType(model);
                                  final definition =
                                      ModelRegistry.models[modelType]!;
                                  Get.to(
                                    () => ModelEditView(
                                      definition: definition,
                                    ),
                                  );
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
                                      style: const TextStyle(color: Colors.black),
                                    ),
                                  ),
                                ),
                              )))),
                    );
                  },
                ),
              );
            }))
          ],
        ),
      ),
    );
  }
}
