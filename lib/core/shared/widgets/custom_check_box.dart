import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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
        Checkbox(
          value: rememberMe,
          onChanged: (value) {
            ref.read(checkBoxProvider.notifier).state = value ?? false;
          },
        ),
        GestureDetector(
          onTap: () {
            ref.read(checkBoxProvider.notifier).state = !rememberMe;
          },
          child: Text(
            checkBoxText,
            style: TextStyle(fontSize: 14),
          ),
        ),
      ],
    );
  }
}
