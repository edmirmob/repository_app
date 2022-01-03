import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ItemsCard extends StatelessWidget {
  final double borderRadius;
  final EdgeInsets? margin;
  final Widget foreground;
  final Widget? background;
  final Color? backgroundColor;
  final double contentPadding;
  final Function()? onTap;

  final double minWidth;
  final double minHeight;
  final double maxWidth;
  final double maxHeight;

  final double shadowOffsetLeft;
  final double shadowOffsetTop;
  final double shadowOffsetRight;
  final double shadowOffsetBottom;

  Color get _bgColor {
    if (backgroundColor != null) {
      return backgroundColor!;
    } else if (background == null) {
      return Colors.white;
    } else {
      return Colors.transparent;
    }
  }

  const ItemsCard({
    Key? key,
    this.margin,
    required this.foreground,
    this.borderRadius = 5,
    this.background,
    this.backgroundColor,
    this.contentPadding = 12,
    this.onTap,
    this.minHeight = 142,
    this.minWidth = double.infinity,
    this.shadowOffsetLeft = 5,
    this.shadowOffsetTop = 16,
    this.shadowOffsetRight = 9,
    this.shadowOffsetBottom = 24,
    this.maxWidth = double.infinity,
    this.maxHeight = double.infinity,
  }) : super(key: key);

  Widget _buildShadow() {
    return Positioned.fill(
      left: shadowOffsetLeft,
      top: shadowOffsetTop,
      right: shadowOffsetRight,
      bottom: shadowOffsetBottom,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: [
            BoxShadow(
              color: Color(0x5E000000),
              blurRadius: 30,
              offset: Offset(0, 20),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBackground() {
    return Positioned.fill(
      child: Container(
        decoration: BoxDecoration(
          color: _bgColor,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: background,
        clipBehavior: Clip.antiAlias,
      ),
    );
  }

  Widget _buildForeground() {
    return Material(
      clipBehavior: Clip.antiAlias,
      borderRadius: BorderRadius.circular(borderRadius),
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        splashColor: Colors.black.withOpacity(.023),
        highlightColor: Colors.transparent,
        child: Container(
          padding: EdgeInsets.all(contentPadding),
          constraints: BoxConstraints(
              minWidth: minWidth,
              minHeight: minHeight,
              maxWidth: maxWidth,
              maxHeight: maxHeight),
          child: foreground,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        if (onTap != null) _buildShadow(),
        _buildBackground(),
        _buildForeground(),
      ],
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DoubleProperty('minWidth', minWidth));
  }
}
