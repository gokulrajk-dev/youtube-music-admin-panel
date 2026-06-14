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

// this is design for List
class ListModelTile extends StatelessWidget {
  final IconData icon;
  final Color borderColor;
  final Color IconColor;
  const ListModelTile({super.key, required this.icon, required this.borderColor, required this.IconColor});

  @override
  Widget build(BuildContext context) {
    return  Container(
      width: 34,
      height: 34,
      decoration: BoxDecoration(
        color: borderColor.withOpacity(0.06),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: borderColor.withOpacity(0.10),
          width: 0.5,
        ),
      ),
      child: Icon(
        icon,
        size: 16,
        // color: const Color(0xFFF0ECE4).withOpacity(0.45),
        color: IconColor.withOpacity(0.45),
      ),
    );
  }
}

// this design for show the Model like artist,song,genre and album
class SingleModelDetailsWidget extends StatelessWidget {
  final String Title;
  final List<Widget> children;
  final EdgeInsets padding;
  const SingleModelDetailsWidget({super.key,  required this.Title, required this.children, required this.padding});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.04),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white.withOpacity(0.08),
          width: 0.5,
        ),
      ),
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
           Text(
            Title.toUpperCase(),
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w500,
              letterSpacing: 1.2,
              color: Color(0x4DF0ECE4),
            ),
          ),
          const SizedBox(height: 12),
          ...children
              ],
            ),
          );
  }
}

// inside the model info using design

class SingleModelDetailsWidgetInfoRow extends StatelessWidget {
  final IconData icon;
  final Color iconBg;
  final Color iconColor;
  final String label;
  final String? value;
  final Widget? customChild;
  final bool isLast;

  const SingleModelDetailsWidgetInfoRow({super.key,
    required this.icon,
    required this.iconBg,
    required this.iconColor,
    required this.label,
    this.value,
    this.customChild,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: isLast
          ? null
          : BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.white.withOpacity(0.06),
            width: 0.5,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: iconColor, size: 16),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w300,
                    color: const Color(0xFFF0ECE4).withOpacity(0.35),
                  ),
                ),
                const SizedBox(height: 2),
                if (customChild != null)
                  customChild!
                else
                  Text(
                    value ?? '',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFFF0ECE4),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SingleModelDetailsWidgetGenreTag extends StatelessWidget {
  final String label;
  final Color bgColor;
  final Color textColor;
  final Color borderColor;

  const SingleModelDetailsWidgetGenreTag({super.key,
    required this.label,
    required this.bgColor,
    required this.textColor,
    required this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: borderColor, width: 0.5),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: textColor,
        ),
      ),
    );
  }
}
