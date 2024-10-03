import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:neighborgood/core/constants/app_colors.dart';
import 'package:neighborgood/core/constants/app_constants.dart';
import 'package:neighborgood/features/home/presentation/providers/profile_screen_provider.dart';

class ProfileScreen extends HookConsumerWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profilePostList = ref.watch(ProfileProvider);

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
