import 'package:basic_fundamental/data/data_model/Artist.dart';
import 'package:basic_fundamental/module/page/modelEditPage/modelEditPageController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';

class modelEditViews extends StatefulWidget {
  const modelEditViews({super.key});

  @override
  State<modelEditViews> createState() => _modelEditViewsState();
}

class _modelEditViewsState extends State<modelEditViews> {
  final GetModelEditController getModelEditController =
      Get.find<GetModelEditController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Obx(
        ()=> ListView.builder(
          itemCount: getModelEditController.item.length,
          itemBuilder: (context, index) {
            final modelItem = getModelEditController.item[index] as Artist;
            return AnimationConfiguration.staggeredList(
                position: index,
                duration: const Duration(milliseconds: 500),
                child: SlideAnimation(
                    horizontalOffset: 500.0,
                    child: FadeInAnimation(
                        child: ListTile(
                            title: Text(modelItem.artistName ?? ""),
                            subtitle: Text(modelItem.artistBio ?? "")))));
          },
        ),
      ),
    );
  }
}
