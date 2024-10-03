import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:neighborgood/core/constants/app_colors.dart';
import 'package:neighborgood/core/constants/app_constants.dart';
import 'package:neighborgood/core/constants/image_path.dart';
import 'package:neighborgood/core/shared/providers/user_state_provider.dart';
import 'package:neighborgood/core/shared/widgets/custom_text.dart';
import 'package:neighborgood/features/create_post/domain/models/create_post_model.dart';
import 'package:neighborgood/features/home/presentation/providers/profile_screen_provider.dart';
import 'package:neighborgood/features/home/presentation/widgets/profile_count_widget.dart';
import 'package:neighborgood/features/home/presentation/widgets/user_profile_btn.dart';

class ProfileScreen extends HookConsumerWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profilePostList = ref.watch(ProfileProvider);

    final user = ref.watch(userStateNotifierProvider);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.white,
      body: Container(
        margin: EdgeInsets.only(top: AppConstants.appBarHeight - 10),
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    ImagePath.appName,
                    width: AppConstants.screenWidth * 0.5,
                    height: 30,
                  ),
                  Icon(
                    Icons.menu_rounded,
                    size: 24,
                  )
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 25),
                child: Column(
                  children: [
                    Container(
                      width: 72,
                      height: 72,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(image: AssetImage(ImagePath.user_profile)),
                      ),
                    ),
                    CustomText(
                      padding: EdgeInsets.only(top: 8),
                      size: 16,
                      text: user!.fullName,
                      fontWeight: FontWeight.bold,
                    ),
                    CustomText(
                      padding: EdgeInsets.symmetric(vertical: 2),
                      size: 10,
                      text: 'Intrested In Coding',
                      fontWeight: FontWeight.w400,
                      color: AppColors.black.withOpacity(0.5),
                    ),
                    Profile_Count(post_length: profilePostList.length),
                    Container(
                      margin: EdgeInsets.only(top: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          UserProfileButton(text: 'Edit Profile', imageAssetPath: ImagePath.edit_user_icon),
                          UserProfileButton(text: 'Create Postcard', imageAssetPath: ImagePath.edit_icon),
                        ],
                      ),
                    ),
                  ],
                ),
              )
              /*  ListView.builder(
                itemBuilder: (context, index) => ListTile(
                  title: Text(profilePostList[index].title),
                ),
                itemCount: profilePostList.length,
              ), */
            ],
          ),
        ),
      ),
    );
  }
}
