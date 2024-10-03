import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:neighborgood/core/constants/app_colors.dart';
import 'package:neighborgood/core/constants/app_constants.dart';
import 'package:neighborgood/core/constants/image_path.dart';
import 'package:neighborgood/core/shared/widgets/custom_text.dart';
import 'package:neighborgood/features/home/presentation/providers/post_feed_provider.dart';

class PostFeedScreen extends HookConsumerWidget {
  const PostFeedScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final feedsList = ref.watch(feedListProvider);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.white,
      body: Container(
        margin: EdgeInsets.only(top: AppConstants.appBarHeight),
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Appbar(),
              ListView.builder(
                shrinkWrap: true,
                primary: false,
                itemCount: feedsList.length,
                itemBuilder: (context, index) => Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(color: AppColors.grayLite, borderRadius: BorderRadius.circular(8)),
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  margin: EdgeInsets.symmetric(horizontal: 10),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(image: AssetImage(ImagePath.user_profile)),
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                      padding: EdgeInsets.only(top: 8),
                                      size: 14,
                                      text: "Jhon",
                                      fontWeight: FontWeight.bold,
                                    ),
                                    CustomText(
                                      padding: EdgeInsets.symmetric(vertical: 2),
                                      size: 10,
                                      text: 'Intrested In Coding',
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.black.withOpacity(0.5),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            Icon(Icons.more_vert_rounded, color: AppColors.blackLite, size: 24),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 10),
                        child: Row(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  padding: EdgeInsets.only(top: 8),
                                  size: 14,
                                  text: feedsList[index].title,
                                  fontWeight: FontWeight.bold,
                                ),
                                CustomText(
                                  padding: EdgeInsets.symmetric(vertical: 2),
                                  size: 12,
                                  text: feedsList[index].description,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.black,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: Image.network(
                          feedsList[index].post_image_path,
                          width: double.maxFinite,
                          height: AppConstants.screenWidth * 0.5,
                          filterQuality: FilterQuality.high,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;

                            return Center(
                                child: CircularProgressIndicator(
                              color: AppColors.gray,
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                                  : null,
                            ));
                          },
                          fit: BoxFit.cover,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              IconButton(
                                icon: Icon(Icons.heart_broken, color: Colors.blue),
                                onPressed: () {},
                              ),
                              IconButton(
                                icon: Icon(Icons.comment, color: Colors.blue),
                                onPressed: () {},
                              ),
                              IconButton(
                                icon: Icon(Icons.telegram, color: Colors.blue),
                                onPressed: () {},
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              IconButton(
                                iconSize: 24,
                                icon: Icon(feedsList[index].saved ? Icons.bookmark : Icons.bookmark_border_rounded, color: AppColors.black),
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Appbar extends StatelessWidget {
  const Appbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset(
          ImagePath.appName,
          alignment: Alignment.centerLeft,
          width: AppConstants.screenWidth * 0.5,
          height: 30,
        ),
        Container(
          width: AppConstants.screenWidth * 0.15,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                ImagePath.bell_icon,
                width: 25,
                height: 25,
              ),
              Image.asset(
                ImagePath.shield,
                width: 25,
                height: 25,
              ),
            ],
          ),
        )
      ],
    );
  }
}
