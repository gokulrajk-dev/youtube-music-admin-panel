import 'package:basic_fundamental/module/page/modelEditPage/widgets/helperwidget/helper_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:lottie/lottie.dart';

import '../../../../data/registry/model_definition.dart';
import '../controller/modelEditPageController.dart';

class ModelEditView extends StatefulWidget {
  final ModelDefinition definition;

  const ModelEditView({
    super.key,
    required this.definition,
  });

  @override
  State<ModelEditView> createState() => _ModelEditViewState();
}

class _ModelEditViewState extends State<ModelEditView> {
  final controller = Get.find<GetModelEditController>();

  @override
  void initState() {
    controller.loadData(
      widget.definition,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0F),
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0.04),
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: CircleIconButton(
            icon: Icons.arrow_back,
            onTap: () {
              Get.back();
            },
          ),
        ),
        leadingWidth: 48,
        title: Text(
          widget.definition.title,
          style: const TextStyle(color: Colors.white),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 14.0),
            child: CircleIconButton(
              icon: Icons.more_vert_rounded,
              onTap: () {
                controller
                    .showMenu(context, widget.definition.title, children: [
                  controller.menuItem(
                    Icons.add,
                    "Create",
                    () {
                      controller.dynamicCreateButton(widget.definition.title);
                    },
                  ),
                ]);
              },
            ),
          ),
        ],
      ),
      body: LiquidPullToRefresh(
        color: Colors.red,
        onRefresh: () async {
          await controller.loadData(
            widget.definition,
          );
        },
        child: Obx(() {
          if (controller.isLoading.value) {
            return Center(
              child: Lottie.asset(
                'assets/lottie/artist.json',
                width: 450,
                height: 400,
              ),
            );
          }
          return ListView.builder(
            itemCount: controller.items.length,
            itemBuilder: (context, index) {
              final item = controller.items[index];
              return widget.definition.tileBuilder(item);
            },
          );
        }),
      ),
    );
  }
}
