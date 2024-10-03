import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:neighborgood/core/constants/app_colors.dart';
import 'package:neighborgood/core/constants/app_constants.dart';
import 'package:neighborgood/core/constants/image_path.dart';
import 'package:neighborgood/core/shared/providers/user_state_provider.dart';
import 'package:neighborgood/core/shared/widgets/custom_button.dart';
import 'package:neighborgood/core/shared/widgets/custom_check_box.dart';
import 'package:neighborgood/core/shared/widgets/custom_text.dart';
import 'package:neighborgood/core/shared/widgets/custom_text_view.dart';
import 'package:neighborgood/core/utils/snack_bar_utils.dart';
import 'package:neighborgood/core/utils/utils.dart';
import 'package:neighborgood/features/auth/data/entities/auth_entity.dart';
import 'package:neighborgood/features/auth/presentation/providers/auth_provider.dart';
import 'package:neighborgood/features/auth/presentation/widgets/other_signin_options_widget.dart';
import 'package:neighborgood/features/home/presentation/pages/home_page.dart';

class LoginScreen extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageController = ref.watch(authPageControllerProvider);

    final usernameController = useTextEditingController();
    final passwordController = useTextEditingController();

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
              Image.asset(
                ImagePath.appName,
                height: 55,
                fit: BoxFit.cover,
              ),
              SizedBox(
                height: 30,
              ),
              CustomText(
                size: 20,
                text: 'Welcome Back!',
                fontWeight: FontWeight.bold,
              ),
              CustomText(
                padding: EdgeInsets.symmetric(vertical: 8),
                size: 12,
                text: 'Let’s login for explore continues',
                fontWeight: FontWeight.w400,
                color: AppColors.black.withOpacity(0.5),
              ),
              SizedBox(
                height: 30,
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
                text: 'Password',
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
                padding: EdgeInsets.symmetric(vertical: 5),
                size: 12,
                text: 'Forgot Password?',
                fontWeight: FontWeight.normal,
                positionAlign: MainAxisAlignment.end,
                color: AppColors.orange,
              ),
              CustomCheckbox(
                checkBoxText: 'Remember Me',
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: CustomButton(
                  text: "Sign in",
                  fontSize: 16,
                  letterSpacing: 2,
                  onPressed: () async {
                    if (usernameController.text.isEmpty || passwordController.text.isEmpty) {
                      showCustomSnackbar(context, status: SnackBarStatus.failure, message: 'All fields are required.', position: SnackPosition.top);
                      return;
                    } else {
                      AuthResponse res = await ref.read(authStateProvider.notifier).signIn(
                            usernameController.text,
                            passwordController.text,
                          );
                      showCustomSnackbar(
                        context,
                        status: res.status ? SnackBarStatus.success : SnackBarStatus.failure,
                        message: res.message,
                      );
                      usernameController.clear();
                      passwordController.clear();

                      if (res.status) {
                        final userStateNotifier = ref.read(userStateNotifierProvider.notifier);

                        log('res.responce: ${res.responce}');
                        log('res.responce: ${res.responce.user_id}');
                        userStateNotifier.setUser(res.responce);
                        //Navigation
                        Utils().navigateTo(context, HomeScreen());
                      }
                    }
                  },
                  borderRadius: 12,
                  width: AppConstants.screenWidth,
                ),
              ),
              OtherSignInOptions(
                onTap: () {
                  usernameController.clear();
                  passwordController.clear();

                  pageController.animateToPage(
                    1,
                    duration: Duration(milliseconds: 800),
                    curve: Curves.linearToEaseOut,
                  );
                },
                otherOptionManditoryText: 'Sign Up here',
                otherOptionText: 'Don’t have an account? ',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
