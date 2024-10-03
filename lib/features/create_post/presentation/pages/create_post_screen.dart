import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:neighborgood/core/constants/app_colors.dart';
import 'package:neighborgood/core/constants/app_constants.dart';
import 'package:neighborgood/core/constants/image_path.dart';
import 'package:neighborgood/core/shared/widgets/custom_button.dart';
import 'package:neighborgood/core/shared/widgets/custom_text.dart';
import 'package:neighborgood/core/shared/widgets/custom_text_view.dart';
import 'package:neighborgood/core/utils/dotted_border.dart';
import 'package:neighborgood/core/utils/snack_bar_utils.dart';
import 'package:neighborgood/core/utils/utils.dart';
import 'package:neighborgood/features/auth/data/entities/auth_entity.dart';
import 'package:neighborgood/features/create_post/domain/models/create_post_model.dart';
import 'package:neighborgood/features/create_post/presentation/provider/create_post_provider.dart';

class CreatePostScreen extends HookConsumerWidget {
  const CreatePostScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final titleController = useTextEditingController();
    final descriptionController = useTextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('Create post'),
        leading: Icon(Icons.arrow_back_rounded),
        backgroundColor: AppColors.white,
      ),
      backgroundColor: AppColors.white,
      body: Container(
        width: AppConstants.screenWidth,
        height: AppConstants.screenHeight - AppConstants.appBarHeight,
        margin: EdgeInsets.only(top: AppBar().preferredSize.height),
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            Container(
              width: AppConstants.screenWidth * 0.9,
              height: AppConstants.screenWidth * 0.5,
              child: Consumer(builder: (context, ref, child) {
                final imageFile = ref.watch(fileProvider);
                if (imageFile != null) {
                  return InkWell(
                    onTap: () async => ref.read(fileProvider.notifier).state = await Utils().pickImage() ?? null,
                    child: Container(
                      height: AppConstants.screenHeight * 0.5,
                      decoration: BoxDecoration(
                        image: DecorationImage(image: FileImage(imageFile), fit: BoxFit.cover, filterQuality: FilterQuality.high),
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  );
                } else {
                  return CustomPaint(
                    painter: DashedPainter(color: AppColors.black.withOpacity(0.25), strokeWidth: 1, dashPattern: [5, 5], radius: Radius.circular(15)),
                    child: Container(
                      height: AppConstants.screenHeight * 0.5,
                      decoration: BoxDecoration(
                        color: AppColors.grayLite,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(
                        child: InkWell(
                          onTap: () async => ref.read(fileProvider.notifier).state = await Utils().pickImage() ?? null,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Spacer(),
                              Image.asset(
                                ImagePath.file_upload,
                                width: AppConstants.screenWidth * 0.1,
                                height: AppConstants.screenWidth * 0.1,
                                filterQuality: FilterQuality.high,
                                color: AppColors.black,
                                fit: BoxFit.cover,
                              ),
                              Spacer(),
                              CustomText(
                                text: 'Upload a Image here',
                                size: 15,
                                fontWeight: FontWeight.w500,
                                style: TextStyle(decoration: TextDecoration.underline),
                              ),
                              CustomText(
                                padding: EdgeInsets.symmetric(vertical: 15),
                                text: 'JPG or PNG file size no more than 10MB',
                                size: 12,
                                fontWeight: FontWeight.w500,
                                color: AppColors.black.withOpacity(0.5),
                              ),
                              Spacer(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }
              }),
            ),
            SizedBox(
              height: 15,
            ),
            CustomText(
              padding: EdgeInsets.symmetric(vertical: 8),
              size: 14,
              isManditory: true,
              text: 'Event Title ',
              fontWeight: FontWeight.bold,
              positionAlign: MainAxisAlignment.start,
              color: AppColors.black,
            ),
            CustomTextField(
              controller: titleController,
              hintText: 'Post Title',
              hintStyle: TextStyle(color: AppColors.black.withOpacity(0.5), fontSize: 12, fontWeight: FontWeight.w400),
            ),
            SizedBox(
              height: 15,
            ),
            CustomText(
              padding: EdgeInsets.symmetric(vertical: 8),
              size: 14,
              isManditory: true,
              text: 'Discription ',
              fontWeight: FontWeight.bold,
              positionAlign: MainAxisAlignment.start,
              color: AppColors.black,
            ),
            CustomTextField(
              controller: descriptionController,
              hintText: 'Write your discription...',
              hintStyle: TextStyle(color: AppColors.black.withOpacity(0.5), fontSize: 12, fontWeight: FontWeight.w400),
            ),
            Spacer(),
            Container(
              margin: EdgeInsets.only(bottom: AppConstants.appBarHeight - 15),
              child: CustomButton(
                onPressed: () async {
                  if (titleController.text.isEmpty || descriptionController.text.isEmpty || ref.read(fileProvider) == null) {
                    showCustomSnackbar(context, status: SnackBarStatus.failure, message: 'All fields are required.', position: SnackPosition.top);
                    return;
                  } else {
                    AuthResponse uploadFileRes = await ref.read(createPostStateProvider.notifier).uploadFile(ref.read(fileProvider)!);

                    if (uploadFileRes.status) {
                      if (uploadFileRes.message.isEmpty) {
                        showCustomSnackbar(context, status: SnackBarStatus.failure, message: 'Image upload Failed', position: SnackPosition.top);
                        return;
                      } else {
                        CreatePostModel post = CreatePostModel(title: titleController.text, description: descriptionController.text, post_image_path: uploadFileRes.message);
                        AuthResponse uploadPostRes = await ref.read(createPostStateProvider.notifier).uploadPost(post);

                        showCustomSnackbar(
                          context,
                          status: uploadPostRes.status ? SnackBarStatus.success : SnackBarStatus.failure,
                          message: uploadPostRes.message,
                        );
                        if (uploadPostRes.status) {
                          // Navigation
                        }
                      }
                    }
                  }
                },
                text: "Share",
                fontSize: 14,
                borderRadius: 12,
                width: AppConstants.screenWidth,
              ),
            )
          ],
        ),
      ),
    );
  }
}
