import 'package:flutter/material.dart';
import 'package:neighborgood/core/constants/app_colors.dart';

class SocialIconButton extends StatelessWidget {
  final String imagePath;
  final double size;
  final VoidCallback? onTap;

  const SocialIconButton({
    Key? key,
    required this.imagePath,
    this.size = 30.0,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.whiteLite,
        ),
        child: Image.asset(
          imagePath,
          width: size,
          height: size,
        ),
      ),
    );
  }
}
