import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:neighborgood/core/constants/app_colors.dart';
import 'package:neighborgood/core/constants/image_path.dart';
import 'package:neighborgood/core/shared/screens/dev_screen.dart';
import 'package:neighborgood/features/create_post/presentation/pages/create_post_screen.dart';
import 'package:neighborgood/features/home/presentation/pages/post_feed_screen.dart';
import 'package:neighborgood/features/home/presentation/pages/profile_screen.dart';
import 'package:neighborgood/features/home/presentation/providers/home_screen_provider.dart';

class HomeScreen extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageController = ref.watch(homePageControllerProvider);
    final currentIndex = ref.watch(bottomNavigationIndexProvider);

    return WillPopScope(
      onWillPop: () async {
        if (currentIndex == 2) {
          ref.read(bottomNavigationIndexProvider.notifier).state = 0;
          pageController.jumpToPage(0);
        }
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.white,
        body: PageView(
          controller: pageController,
          onPageChanged: (index) {
            ref.read(bottomNavigationIndexProvider.notifier).state = index;
          },
          physics: NeverScrollableScrollPhysics(),
          children: [
            PostFeedScreen(),
            DevelopingScreen(),
            CreatePostScreen(),
            DevelopingScreen(),
            ProfileScreen(),
          ],
        ),
        bottomNavigationBar: currentIndex == 2
            ? SizedBox()
            : BottomNavigationBar(
                currentIndex: currentIndex,
                onTap: (index) {
                  pageController.jumpToPage(index);
                  ref.read(bottomNavigationIndexProvider.notifier).state = index;
                },
                type: BottomNavigationBarType.fixed,
                backgroundColor: AppColors.white,
                elevation: 60,
                showSelectedLabels: false,
                showUnselectedLabels: false,
                selectedItemColor: AppColors.colorPrimary,
                unselectedItemColor: AppColors.black,
                items: [
                  BottomNavigationBarItem(
                    icon: Image.asset(
                      ImagePath.home_icon,
                      height: 24,
                      color: currentIndex == 0 ? AppColors.colorPrimary : AppColors.blackLite.withOpacity(0.8),
                    ),
                    label: '',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.search,
                      size: 24,
                    ),
                    label: '',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.add_circle_outline_rounded,
                      size: 24,
                    ),
                    label: '',
                  ),
                  BottomNavigationBarItem(
                    icon: Image.asset(
                      color: currentIndex == 3 ? AppColors.colorPrimary : AppColors.black,
                      ImagePath.chat_icon,
                      height: 24,
                    ),
                    label: '',
                  ),
                  BottomNavigationBarItem(
                    icon: Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.colorPrimary, width: currentIndex == 4 ? 2 : 0),
                        image: DecorationImage(image: AssetImage(ImagePath.user_profile)),
                      ),
                    ),
                    label: '',
                  ),
                ],
              ),
      ),
    );
  }
}
