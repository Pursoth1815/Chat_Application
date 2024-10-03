import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:neighborgood/core/constants/app_colors.dart';
import 'package:neighborgood/core/constants/app_constants.dart';
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
    final pageController = ref.watch(authPageControllerProvider);
    final termsController = ref.watch(checkBoxProvider);

    final usernameController = useTextEditingController();
    final passwordController = useTextEditingController();
    final confirmPasswordController = useTextEditingController();
    final fullNameController = useTextEditingController();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.white,
      body: Container(
        margin: EdgeInsets.only(top: AppConstants.appBarHeight - 10),
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(
                ImagePath.appName,
                height: 55,
                fit: BoxFit.cover,
              ),
              SizedBox(
                height: 20,
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
                  fontSize: 14,
                  onPressed: () async {
                    if (fullNameController.text.isEmpty || usernameController.text.isEmpty || passwordController.text.isEmpty || confirmPasswordController.text.isEmpty) {
                      showCustomSnackbar(context, status: SnackBarStatus.failure, message: 'All fields are required.', position: SnackPosition.top);
                      return;
                    } else if (confirmPasswordController.text != passwordController.text) {
                      showCustomSnackbar(context, status: SnackBarStatus.failure, message: 'Password & Confirm password are not same.', position: SnackPosition.top);
                      return;
                    } else if (!termsController) {
                      showCustomSnackbar(context, status: SnackBarStatus.failure, message: 'Accept the Terms& condition', position: SnackPosition.top);
                      return;
                    } else {
                      final userDetails = RegisterUserModel(fullName: fullNameController.text, password: confirmPasswordController.text, username: usernameController.text);
                      AuthResponse res = await ref.read(authStateProvider.notifier).signUp(userDetails);
                      showCustomSnackbar(
                        context,
                        status: res.status ? SnackBarStatus.success : SnackBarStatus.failure,
                        message: res.message,
                      );
                      fullNameController.clear();
                      usernameController.clear();
                      passwordController.clear();
                      confirmPasswordController.clear();
                      if (res.status) {
                        pageController.animateToPage(0, duration: Duration(milliseconds: 800), curve: Curves.linearToEaseOut);
                      }
                    }
                  },
                  borderRadius: 12,
                  width: AppConstants.screenWidth,
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 20),
                child: OtherSignInOptions(
                  onTap: () {
                    fullNameController.clear();
                    usernameController.clear();
                    passwordController.clear();
                    confirmPasswordController.clear();

                    pageController.animateToPage(
                      0,
                      duration: Duration(milliseconds: 800),
                      curve: Curves.linearToEaseOut,
                    );
                  },
                  otherOptionManditoryText: 'Login',
                  otherOptionText: 'Already have an account? ',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
