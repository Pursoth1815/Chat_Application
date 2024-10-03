import 'package:flutter/material.dart';
import 'package:neighborgood/core/constants/app_colors.dart';
import 'package:neighborgood/core/constants/app_constants.dart';
import 'package:neighborgood/core/constants/image_path.dart';
import 'package:neighborgood/core/shared/widgets/custom_text.dart';
import 'package:neighborgood/features/auth/presentation/widgets/social_btn_widget.dart';

class OtherSignInOptions extends StatelessWidget {
  const OtherSignInOptions({
    super.key,
    required this.otherOptionText,
    required this.otherOptionManditoryText,
    required this.onTap,
  });

  final String otherOptionText;
  final String otherOptionManditoryText;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 20),
          padding: const EdgeInsets.symmetric(horizontal: 14.0),
          child: Row(
            children: [
              Expanded(
                child: Divider(
                  color: AppColors.gray,
                  thickness: 1.5,
                ),
              ),
              SizedBox(width: 10),
              CustomText(
                padding: EdgeInsets.symmetric(
                  vertical: 5,
                ),
                size: 12,
                text: 'You can connect with',
                fontWeight: FontWeight.bold,
                color: AppColors.black.withOpacity(0.3),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Divider(
                  color: AppColors.gray,
                  thickness: 1.5,
                ),
              ),
            ],
          ),
        ),
        Column(
          children: [
            Container(
              width: AppConstants.screenWidth * 0.6,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SocialIconButton(imagePath: ImagePath.fb_icon),
                  SocialIconButton(imagePath: ImagePath.google_icon),
                  SocialIconButton(imagePath: ImagePath.apple_icon),
                ],
              ),
            ),
            CustomText(
              padding: EdgeInsets.only(top: 25),
              size: 12,
              isManditory: true,
              manditoryText: otherOptionManditoryText,
              text: otherOptionText,
              fontWeight: FontWeight.bold,
              color: AppColors.black,
              manditoryTextColor: AppColors.orange,
              onTap: onTap,
            ),
          ],
        ),
      ],
    );
  }
}
