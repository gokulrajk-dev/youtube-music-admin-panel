import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../../data/registry/model_definition.dart';
import '../controller/modelEditPageController.dart';

class ModelDetailsEditView extends StatefulWidget {
  final ModelDetailDefinition definitions;
  final dynamic item;

  const ModelDetailsEditView({
    super.key,
    required this.definitions,
    required this.item,
  });

  @override
  State<ModelDetailsEditView> createState() => _ModelDetailsEditViewState();
}

class _ModelDetailsEditViewState extends State<ModelDetailsEditView> {
  final controller = Get.find<GetModelEditController>();

  @override
  void initState() {
    controller.loadDetailData(widget.definitions, widget.item);
    super.initState();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
        backgroundColor: const Color(0xFF0A0A0F),
        body: Obx(() {
          if(controller.load.value){
            return Center(child: Lottie.asset('assets/lottie/song.json', width: 450,
              height: 400,),);
          }
      return widget.definitions.DetailBuilder(controller.model_details.value);
    }));
  }
}
