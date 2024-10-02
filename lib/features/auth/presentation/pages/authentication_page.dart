import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:neighborgood/core/constants/app_colors.dart';
import 'package:neighborgood/features/auth/presentation/pages/login_page.dart';
import 'package:neighborgood/features/auth/presentation/pages/registration_page.dart';
import 'package:neighborgood/features/auth/presentation/providers/auth_provider.dart';

class AuthenticationScreen extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageController = ref.watch(pageControllerProvider);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.white,
      body: PageView(
        controller: pageController,
        physics: NeverScrollableScrollPhysics(),
        children: [
          LoginScreen(),
          RegistrationScreen(),
        ],
      ),
    );
  }
}
