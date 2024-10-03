import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:neighborgood/core/constants/app_colors.dart';

final checkBoxProvider = StateProvider<bool>((ref) => false);

class CustomCheckbox extends HookConsumerWidget {
  final String checkBoxText;

  const CustomCheckbox({Key? key, this.checkBoxText = ''}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rememberMe = ref.watch(checkBoxProvider);

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Transform.scale(
          scale: 0.8,
          child: Checkbox(
            value: rememberMe,
            checkColor: AppColors.white,
            activeColor: Colors.green,
            onChanged: (value) {
              ref.read(checkBoxProvider.notifier).state = value ?? false;
            },
          ),
        ),
        GestureDetector(
          onTap: () {
            ref.read(checkBoxProvider.notifier).state = !rememberMe;
          },
          child: Text(
            checkBoxText,
            style: TextStyle(fontSize: 12),
          ),
        ),
      ],
    );
  }
}
