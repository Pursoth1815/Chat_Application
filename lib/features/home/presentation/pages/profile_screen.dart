import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:neighborgood/core/constants/app_colors.dart';
import 'package:neighborgood/core/constants/app_constants.dart';
import 'package:neighborgood/core/constants/image_path.dart';
import 'package:neighborgood/core/shared/providers/user_state_provider.dart';
import 'package:neighborgood/core/shared/widgets/custom_text.dart';
import 'package:neighborgood/features/auth/domain/models/register_user_model.dart';
import 'package:neighborgood/features/home/domain/models/post_feeds_model.dart';
import 'package:neighborgood/features/home/presentation/providers/home_screen_provider.dart';
import 'package:neighborgood/features/home/presentation/providers/profile_screen_provider.dart';
import 'package:neighborgood/features/home/presentation/widgets/profile_count_widget.dart';
import 'package:neighborgood/features/home/presentation/widgets/user_posts_feed.dart';
import 'package:neighborgood/features/home/presentation/widgets/user_profile_btn.dart';

class ProfileScreen extends HookConsumerWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profilePostList = ref.watch(ProfileProvider);
    final pageController = ref.watch(homePageControllerProvider);
    final user = ref.watch(userStateNotifierProvider);

    final selectedIndex = useState(0);

    final filteredPosts = selectedIndex.value == 0 ? profilePostList : profilePostList.where((post) => post.saved == true).toList();

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
                    alignment: Alignment.centerLeft,
                    height: 30,
                  ),
                  Icon(
                    Icons.menu_rounded,
                    size: 24,
                  )
                ],
              ),
              _profile_card_widget(user, profilePostList, pageController, ref, selectedIndex),
              PostGrid(posts: filteredPosts)
            ],
          ),
        ),
      ),
    );
  }

  Container _profile_card_widget(RegisterUserModel? user, List<PostFeedsModel> profilePostList, PageController pageController, WidgetRef ref, ValueNotifier<int> selectedIndex) {
    return Container(
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
            alignment: Alignment.center,
            fontWeight: FontWeight.bold,
          ),
          CustomText(
            padding: EdgeInsets.symmetric(vertical: 2),
            size: 10,
            text: 'Intrested In Coding',
            alignment: Alignment.center,
            fontWeight: FontWeight.w400,
            color: AppColors.black.withOpacity(0.5),
          ),
          Profile_Count(post_length: profilePostList.length),
          Container(
            margin: EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                UserProfileButton(text: 'Edit Profile', imageAssetPath: ImagePath.edit_user_icon),
                UserProfileButton(
                  text: 'Create Postcard',
                  imageAssetPath: ImagePath.edit_icon,
                  onTap: () {
                    pageController.jumpToPage(2);
                    ref.read(bottomNavigationIndexProvider.notifier).state = 2;
                  },
                ),
              ],
            ),
          ),
          Container(
            width: AppConstants.screenWidth * 0.4,
            margin: EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildToggleButton(
                  icon: Icons.grid_view,
                  isSelected: selectedIndex.value == 0,
                  onPressed: () => selectedIndex.value = 0,
                ),
                _buildToggleButton(
                  icon: Icons.bookmark_border_rounded,
                  isSelected: selectedIndex.value == 1,
                  onPressed: () => selectedIndex.value = 1,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToggleButton({
    required IconData icon,
    required bool isSelected,
    required VoidCallback onPressed,
  }) {
    return Column(
      children: [
        GestureDetector(
          onTap: onPressed,
          child: Icon(icon, color: isSelected ? AppColors.colorPrimary : AppColors.gray, size: 24),
        ),
        if (isSelected)
          Container(
            height: 1,
            margin: EdgeInsets.only(top: 5),
            width: 40,
            color: AppColors.colorPrimary,
          ),
      ],
    );
  }
}
