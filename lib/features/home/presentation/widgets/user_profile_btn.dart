import 'package:flutter/material.dart';
import 'package:neighborgood/core/constants/app_colors.dart';

class UserProfileButton extends StatelessWidget {
  final String text;
  final String imageAssetPath;
  final VoidCallback? onTap;

  const UserProfileButton({
    super.key,
    required this.text,
    required this.imageAssetPath,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 125,
        height: 35,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(color: AppColors.profileBtnColor, borderRadius: BorderRadius.circular(8), border: Border.all(width: 1, color: AppColors.gray)),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(
                imageAssetPath,
                height: 16,
                width: 16,
              ),
              Text(
                text,
                style: const TextStyle(
                  fontSize: 10,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
