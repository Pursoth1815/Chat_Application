import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:neighborgood/core/constants/app_colors.dart';

class CustomTextField extends HookWidget {
  final double width;
  final double height;
  final double borderRadius;
  final Color backgroundColor;
  final Color textColor;
  final TextEditingController? controller;
  final Function(String)? onTextChanged;
  final String hintText;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final bool isPasswordField;
  final IconData? prefixIcon;

  const CustomTextField({
    Key? key,
    this.width = double.infinity,
    this.height = 50,
    this.borderRadius = 15.0,
    this.backgroundColor = Colors.white,
    this.textColor = AppColors.blackLite,
    this.controller,
    this.onTextChanged,
    this.hintText = '',
    this.padding = const EdgeInsets.symmetric(horizontal: 8),
    this.margin = const EdgeInsets.symmetric(vertical: 8),
    this.textStyle,
    this.hintStyle,
    this.isPasswordField = false,
    this.prefixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final obscureText = useState(true);

    return Container(
      width: width,
      height: height,
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(
          color: AppColors.gray,
          width: 1.0,
        ),
      ),
      child: Row(
        children: [
          if (prefixIcon != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Icon(
                prefixIcon,
                color: AppColors.black.withOpacity(0.5),
              ),
            ),
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: (value) {
                if (onTextChanged != null) {
                  onTextChanged!(value);
                }
              },
              style: textStyle ?? TextStyle(fontSize: 14, color: textColor.withOpacity(0.8)),
              obscureText: isPasswordField ? obscureText.value : false,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hintText,
                contentPadding: const EdgeInsets.symmetric(vertical: 12.0),
                hintStyle: hintStyle ??
                    TextStyle(
                      fontSize: 14,
                      color: AppColors.black.withOpacity(0.5),
                    ),
                suffixIcon: isPasswordField
                    ? IconButton(
                        splashColor: AppColors.transparent,
                        icon: Icon(
                          obscureText.value ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                          color: AppColors.black.withOpacity(0.4),
                        ),
                        onPressed: () {
                          obscureText.value = !obscureText.value;
                        },
                      )
                    : null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
