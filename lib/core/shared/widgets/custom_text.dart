import 'package:flutter/material.dart';
import 'package:neighborgood/core/constants/app_colors.dart';

class CustomText extends StatefulWidget {
  final String text;
  final String manditoryText;
  final double size;
  final Color color;
  final Color manditoryTextColor;
  final FontWeight fontWeight;
  final TextAlign textAlign;
  final int? maxLines;
  final EdgeInsetsGeometry padding;
  final bool isManditory;
  final TextStyle? style;
  final MainAxisAlignment positionAlign;
  final VoidCallback? onTap;
  final bool wrappedText;

  const CustomText({
    Key? key,
    required this.text,
    this.manditoryText = '*',
    this.size = 14.0,
    this.color = Colors.black,
    this.manditoryTextColor = Colors.red,
    this.fontWeight = FontWeight.normal,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.isManditory = false,
    this.wrappedText = false,
    this.padding = const EdgeInsets.all(0),
    this.positionAlign = MainAxisAlignment.center,
    this.style,
    this.onTap,
  }) : super(key: key);

  @override
  _CustomTextState createState() => _CustomTextState();
}

class _CustomTextState extends State<CustomText> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.text,
            textAlign: widget.textAlign,
            maxLines: isExpanded ? null : widget.maxLines,
            overflow: isExpanded ? null : TextOverflow.ellipsis,
            style: widget.style?.copyWith(
                  fontSize: widget.size,
                  color: widget.color,
                  fontWeight: widget.fontWeight,
                ) ??
                TextStyle(
                  fontSize: widget.size,
                  color: widget.color,
                  fontWeight: widget.fontWeight,
                ),
          ),
          if (!_isExpandedCondition() && widget.wrappedText)
            GestureDetector(
              onTap: () {
                setState(() {
                  isExpanded = !isExpanded;
                });
              },
              child: Text(
                isExpanded ? 'Show Less' : 'Show More',
                style: TextStyle(
                  color: AppColors.grayDark,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
        ],
      ),
    );
  }

  bool _isExpandedCondition() {
    if (widget.maxLines == null || isExpanded) return false;

    final textPainter = TextPainter(
      text: TextSpan(
        text: widget.text,
        style: TextStyle(fontSize: widget.size),
      ),
      maxLines: widget.maxLines,
      textAlign: widget.textAlign,
      textDirection: TextDirection.ltr,
    );

    textPainter.layout(maxWidth: MediaQuery.of(context).size.width);

    final totalHeight = textPainter.size.height;
    final maxHeight = widget.size * (widget.maxLines ?? 1) * 1.2;

    return totalHeight > maxHeight;
  }
}
