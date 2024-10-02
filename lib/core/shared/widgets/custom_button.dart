import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:neighborgood/core/constants/app_colors.dart';

class CustomButton extends HookConsumerWidget {
  final String text;
  final double fontSize;
  final Future<void> Function() onPressed;
  final double width;
  final double height;
  final double letterSpacing;
  final Color color;
  final Color textColor;
  final Color shadowColor;
  final double borderRadius;
  final Widget? icon;
  final EdgeInsetsGeometry iconPadding;

  const CustomButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.width = 200,
    this.fontSize = 14,
    this.height = 50,
    this.letterSpacing = 1,
    this.color = AppColors.colorPrimary,
    this.shadowColor = AppColors.white,
    this.textColor = Colors.white,
    this.borderRadius = 30,
    this.icon,
    this.iconPadding = const EdgeInsets.only(right: 8),
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = useState(false);

    Future<void> _handlePress() async {
      isLoading.value = true;
      try {
        await onPressed();
      } finally {
        isLoading.value = false;
      }
    }

    return GestureDetector(
      onTap: isLoading.value ? null : _handlePress,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(borderRadius),
          color: color,
          boxShadow: [
            BoxShadow(
              color: shadowColor.withOpacity(0.05),
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Center(
          child: isLoading.value
              ? SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    color: textColor,
                    strokeWidth: 3,
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (icon != null)
                      Padding(
                        padding: iconPadding,
                        child: icon!,
                      ),
                    Text(
                      text,
                      style: TextStyle(
                        letterSpacing: letterSpacing,
                        color: textColor,
                        fontSize: fontSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
