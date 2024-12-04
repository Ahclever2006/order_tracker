import 'package:flutter/material.dart';
import '../res/app_colors.dart';

class DefaultButton extends StatefulWidget {
  const DefaultButton({
    super.key,
    this.label,
    required this.onPressed,
    this.padding = const EdgeInsets.all(16.0),
    this.margin = const EdgeInsets.only(),
    this.labelStyle = const TextStyle(
      fontSize: 16.0,
      color: Colors.white,
      height: 1.0,
      fontWeight: FontWeight.bold,
    ),
    this.alignment = Alignment.center,
    this.borderRadius = const BorderRadius.all(Radius.circular(24.0)),
    this.borderColor,
    this.shadow,
    this.isExpanded = false,
    this.icon,
    this.borderWidth = 1.0,
    this.contentAlignment = MainAxisAlignment.center,
    this.backgroundColor = AppColors.PRIMARY_COLOR,
  });

  final Function()? onPressed;
  final String? label;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final TextStyle labelStyle;
  final Color? borderColor;
  final AlignmentGeometry alignment;
  final BorderRadiusGeometry borderRadius;
  final bool isExpanded;
  final Widget? icon;
  final double borderWidth;
  final Color backgroundColor;
  final List<BoxShadow>? shadow;
  final MainAxisAlignment contentAlignment;

  @override
  State<DefaultButton> createState() => _DefaultButtonState();
}

class _DefaultButtonState extends State<DefaultButton>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final buttonContents = <Widget>[
      ...widget.icon != null
          ? [widget.icon!, if (widget.label != null) const SizedBox(width: 8.0)]
          : [],
      if (widget.label != null)
        Padding(
          padding: widget.icon != null
              ? const EdgeInsets.only(top: 3.0)
              : EdgeInsets.zero,
          child: Text(
            widget.label!,
            style: widget.labelStyle,
          ),
        ),
    ];
    return Container(
      margin: widget.margin,
      child: AnimatedSize(
        duration: const Duration(milliseconds: 300),
        curve: Curves.bounceInOut,
        alignment: widget.alignment,
        child: GestureDetector(
          onTap: () {
            widget.onPressed!();
          },
          child: Container(
            padding: widget.padding,
            alignment: widget.isExpanded ? Alignment.center : null,
            decoration: BoxDecoration(
              color: widget.backgroundColor,
              boxShadow: widget.shadow,
              borderRadius: widget.borderRadius,
              border: widget.borderColor != null
                  ? Border.all(
                      color: widget.borderColor!,
                      width: widget.borderWidth,
                    )
                  : null,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: widget.contentAlignment,
              children: buttonContents,
            ),
          ),
        ),
      ),
    );
  }
}
