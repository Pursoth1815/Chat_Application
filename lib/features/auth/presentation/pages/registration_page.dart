import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:neighborgood/core/constants/app_colors.dart';
import 'package:neighborgood/core/constants/image_path.dart';
import 'package:neighborgood/core/shared/widgets/custom_button.dart';
import 'package:neighborgood/core/shared/widgets/custom_check_box.dart';
import 'package:neighborgood/core/shared/widgets/custom_text.dart';
import 'package:neighborgood/core/shared/widgets/custom_text_view.dart';
import 'package:neighborgood/core/utils/snack_bar_utils.dart';
import 'package:neighborgood/features/auth/data/entities/auth_entity.dart';
import 'package:neighborgood/features/auth/domain/models/register_user_model.dart';
import 'package:neighborgood/features/auth/presentation/providers/auth_provider.dart';
import 'package:neighborgood/features/auth/presentation/widgets/other_signin_options_widget.dart';

class RegistrationScreen extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageController = ref.watch(pageControllerProvider);

    final usernameController = useTextEditingController();
    final passwordController = useTextEditingController();
    final confirmPasswordController = useTextEditingController();
    final fullNameController = useTextEditingController();

    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.white,
      body: Container(
        margin: EdgeInsets.only(top: (AppBar().preferredSize.height) + 20),
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(
                ImagePath.appName,
                width: screenWidth * 0.7,
                height: 55,
                fit: BoxFit.cover,
              ),
              SizedBox(
                height: 25,
              ),
              CustomText(
                size: 20,
                text: 'Create Account',
                fontWeight: FontWeight.bold,
                positionAlign: MainAxisAlignment.start,
              ),
              SizedBox(
                height: 15,
              ),
              CustomText(
                padding: EdgeInsets.symmetric(vertical: 8),
                size: 12,
                isManditory: true,
                text: 'Full Name',
                fontWeight: FontWeight.bold,
                positionAlign: MainAxisAlignment.start,
                color: AppColors.black,
              ),
              CustomTextField(
                controller: fullNameController,
                hintText: 'Enter your name',
                prefixIcon: Icons.person_2_rounded,
              ),
              CustomText(
                padding: EdgeInsets.symmetric(vertical: 8),
                size: 12,
                isManditory: true,
                text: 'Email or Phone Number',
                fontWeight: FontWeight.bold,
                positionAlign: MainAxisAlignment.start,
                color: AppColors.black,
              ),
              CustomTextField(
                controller: usernameController,
                hintText: 'Email or Phone Number',
                prefixIcon: Icons.email_outlined,
              ),
              CustomText(
                padding: EdgeInsets.symmetric(vertical: 8),
                size: 12,
                isManditory: true,
                text: 'Create Password',
                fontWeight: FontWeight.bold,
                positionAlign: MainAxisAlignment.start,
                color: AppColors.black,
              ),
              CustomTextField(
                controller: passwordController,
                hintText: 'Enter your password',
                isPasswordField: true,
                prefixIcon: Icons.lock_outline_rounded,
              ),
              CustomText(
                padding: EdgeInsets.symmetric(vertical: 8),
                size: 12,
                isManditory: true,
                text: 'Confirm Password',
                fontWeight: FontWeight.bold,
                positionAlign: MainAxisAlignment.start,
                color: AppColors.black,
              ),
              CustomTextField(
                controller: confirmPasswordController,
                hintText: 'Re-enter your password',
                isPasswordField: true,
                prefixIcon: Icons.lock_outline_rounded,
              ),
              CustomCheckbox(
                checkBoxText: 'I agree to terms & conditions',
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: CustomButton(
                  text: "Create Account",
                  fontSize: 18,
                  onPressed: () async {
                    if (fullNameController.text.isEmpty || usernameController.text.isEmpty || confirmPasswordController.text.isEmpty) {
                      showCustomSnackbar(context, status: SnackBarStatus.failure, message: 'All fields are required.', position: SnackPosition.top);
                      return;
                    }
                    final userDetails = RegisterUserModel(
                        fullName: fullNameController.text, password: confirmPasswordController.text, username: usernameController.text);
                    try {
                      AuthResponse res = await ref.read(authStateProvider.notifier).signUp(userDetails);
                      showCustomSnackbar(
                        context,
                        status: res.status ? SnackBarStatus.success : SnackBarStatus.failure,
                        message: res.message,
                      );
                      if (res.status) {
                        pageController.animateToPage(0, duration: Duration(milliseconds: 800), curve: Curves.linearToEaseOut);
                      }
                    } catch (e) {}
                  },
                  borderRadius: 12,
                  width: screenWidth,
                ),
              ),
              OtherSignInOptions(
                onTap: () {
                  pageController.animateToPage(
                    0,
                    duration: Duration(milliseconds: 800),
                    curve: Curves.linearToEaseOut,
                  );
                },
                otherOptionManditoryText: 'Login',
                otherOptionText: 'Already have an account? ',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
