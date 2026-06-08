import 'package:flutter/material.dart';
import 'package:get/get.dart';

class appBar extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  const appBar({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
      const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleIconButton(
            icon: Icons.arrow_back,
            onTap: () => Get.back(),
          ),
           Text(
            title,
            style: const TextStyle(
              fontFamily: 'serif',
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Color(0xFFF0ECE4),
              letterSpacing: -0.2,
            ),
          ),
          CircleIconButton(
            icon: Icons.more_vert,
            onTap: onTap,
          ),
        ],
      ),
    );
  }
}


class CircleIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const CircleIconButton({super.key, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white.withOpacity(0.1),
          border: Border.all(
            color: Colors.white.withOpacity(0.15),
            width: 0.5,
          ),
        ),
        child: Icon(icon, color: const Color(0xFFF0ECE4), size: 18),
      ),
    );
  }
}