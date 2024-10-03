import 'package:flutter/material.dart';

import 'package:neighborgood/core/constants/app_constants.dart';
import 'package:neighborgood/core/constants/image_path.dart';

class DevelopingScreen extends StatelessWidget {
  final double imageWidthRatio;
  final double imageHeightRatio;
  final String imagePath;
  final String messageText;
  final double textSize;
  final FontWeight textFontWeight;

  const DevelopingScreen({
    Key? key,
    this.imageWidthRatio = 0.75,
    this.imageHeightRatio = 0.75,
    this.imagePath = ImagePath.not_found,
    this.messageText = "Not Found",
    this.textSize = 16,
    this.textFontWeight = FontWeight.w500,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppConstants.screenWidth,
      height: AppConstants.screenHeight - kToolbarHeight - kBottomNavigationBarHeight,
      child: Center(
        child: Image.asset(
          imagePath,
          width: AppConstants.screenWidth * imageWidthRatio,
          height: AppConstants.screenWidth * imageHeightRatio,
        ),
      ),
    );
  }
}
