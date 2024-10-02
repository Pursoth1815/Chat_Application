import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final String manditoryText;
  final double size;
  final Color color;
  final Color manditoryTextColor;
  final FontWeight fontWeight;
  final TextAlign textAlign;
  final dynamic maxLines;
  final TextOverflow overflow;
  final EdgeInsetsGeometry padding;
  final bool isManditory;
  final TextStyle? style;
  final MainAxisAlignment positionAlign;
  final VoidCallback? onTap;

  const CustomText({
    Key? key,
    required this.text,
    this.manditoryText = '*',
    this.size = 14.0,
    this.color = Colors.black,
    this.manditoryTextColor = Colors.red,
    this.fontWeight = FontWeight.normal,
    this.textAlign = TextAlign.start,
    this.maxLines = null,
    this.overflow = TextOverflow.ellipsis,
    this.isManditory = false,
    this.padding = const EdgeInsets.all(0),
    this.positionAlign = MainAxisAlignment.center,
    this.style,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Row(
        mainAxisAlignment: positionAlign,
        children: [
          Text(
            text,
            textAlign: textAlign,
            maxLines: maxLines,
            overflow: overflow,
            style: style?.copyWith(
                  fontSize: size,
                  color: color,
                  fontWeight: fontWeight,
                ) ??
                TextStyle(
                  fontSize: size,
                  color: color,
                  fontWeight: fontWeight,
                ),
          ),
          if (isManditory)
            InkWell(
              onTap: onTap,
              child: Text(
                manditoryText,
                textAlign: textAlign,
                style: style?.copyWith(
                      fontSize: size,
                      color: color,
                      fontWeight: fontWeight,
                    ) ??
                    TextStyle(
                      fontSize: size,
                      color: manditoryTextColor,
                      fontWeight: fontWeight,
                    ),
              ),
            ),
        ],
      ),
    );
  }
}
