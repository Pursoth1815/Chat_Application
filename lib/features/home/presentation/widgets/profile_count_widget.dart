import 'package:flutter/material.dart';
import 'package:neighborgood/core/constants/app_colors.dart';
import 'package:neighborgood/core/constants/app_constants.dart';
import 'package:neighborgood/core/shared/widgets/custom_text.dart';

class Profile_Count extends StatelessWidget {
  const Profile_Count({
    super.key,
    required this.post_length,
  });

  final int post_length;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppConstants.screenWidth * 0.7,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            flex: 1,
            child: Column(
              children: [
                CustomText(
                  padding: EdgeInsets.only(top: 8),
                  size: 14,
                  alignment: Alignment.center,
                  text: post_length.toString(),
                  fontWeight: FontWeight.bold,
                ),
                CustomText(
                  padding: EdgeInsets.symmetric(vertical: 2),
                  size: 10,
                  alignment: Alignment.center,
                  text: 'Post',
                  fontWeight: FontWeight.w400,
                  color: AppColors.black.withOpacity(0.5),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              children: [
                CustomText(
                  padding: EdgeInsets.only(top: 8),
                  size: 14,
                  text: '150',
                  alignment: Alignment.center,
                  fontWeight: FontWeight.bold,
                ),
                CustomText(
                  padding: EdgeInsets.symmetric(vertical: 2),
                  size: 10,
                  text: 'Followers',
                  fontWeight: FontWeight.w400,
                  alignment: Alignment.center,
                  color: AppColors.black.withOpacity(0.5),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              children: [
                CustomText(
                  padding: EdgeInsets.only(top: 8),
                  size: 14,
                  text: '98',
                  alignment: Alignment.center,
                  fontWeight: FontWeight.bold,
                ),
                CustomText(
                  padding: EdgeInsets.symmetric(vertical: 2),
                  size: 10,
                  text: 'Following',
                  alignment: Alignment.center,
                  fontWeight: FontWeight.w400,
                  color: AppColors.black.withOpacity(0.5),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
