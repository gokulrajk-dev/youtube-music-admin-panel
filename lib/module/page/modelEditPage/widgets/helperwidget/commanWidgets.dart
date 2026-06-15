import 'package:flutter/material.dart';
import 'package:get/get.dart';


class ModelImage extends StatelessWidget {
  final String image;
  const ModelImage({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.6),
      child: Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Container(color: Colors.transparent),
            ),
          ),
          Center(
            child: Container(
              height: 300,
              width: 300,
              child: Image.network(image,fit: BoxFit.cover,),
            ),
          )
        ],
      ),
    );
  }
}
