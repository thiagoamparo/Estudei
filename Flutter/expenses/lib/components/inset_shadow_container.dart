import 'package:flutter/material.dart';

class InsetShadowContainer extends StatefulWidget {
  final double width;
  final double height;

  final double boxSpacing;
  final double boxRadius;

  final double blurRadiusDrop;
  final double blurRadiusInset;
  final double spreadRadiusDrop;
  final double spreadRadiusInset;

  final Color color;
  final Color? dropBoxColor;
  final Color? insetBoxColor;

  final Color dropShadowColorTop;
  final Color dropShadowColorBottom;
  final Color insetShadowColorTop;
  final Color insetShadowColorBottom;

  final Offset dropShadowOffsetTop;
  final Offset dropShadowOffsetBottom;
  final Offset insetShadowOffsetTop;
  final Offset insetShadowOffsetBottom;

  final Widget? child;

  const InsetShadowContainer(
    this.width,
    this.height, {
    this.boxSpacing = 0.1,
    this.boxRadius = 50.0,
    this.blurRadiusDrop = 1.0,
    this.blurRadiusInset = 2.0,
    this.spreadRadiusDrop = 1.0,
    this.spreadRadiusInset = 1.0,
    this.color = const Color.fromARGB(255, 255, 255, 255),
    this.dropBoxColor = const Color.fromARGB(255, 255, 255, 255),
    this.insetBoxColor = const Color.fromARGB(255, 255, 255, 255),
    this.dropShadowColorTop = const Color.fromARGB(10, 158, 158, 158),
    this.dropShadowColorBottom = const Color.fromARGB(50, 255, 255, 255),
    this.insetShadowColorTop = const Color.fromARGB(255, 158, 158, 158),
    this.insetShadowColorBottom = const Color.fromARGB(100, 255, 255, 255),
    this.dropShadowOffsetTop = const Offset(-4, -4),
    this.dropShadowOffsetBottom = const Offset(4, 4),
    this.insetShadowOffsetTop = const Offset(-1, -1),
    this.insetShadowOffsetBottom = const Offset(1, 1),
    this.child,
    super.key,
  });

  const InsetShadowContainer.light(
    this.width,
    this.height, {
    this.boxSpacing = 0.1,
    this.boxRadius = 50.0,
    this.blurRadiusDrop = 1.0,
    this.blurRadiusInset = 2.0,
    this.spreadRadiusDrop = 1.0,
    this.spreadRadiusInset = 1.0,
    this.color = const Color.fromARGB(255, 255, 255, 255),
    this.dropBoxColor = const Color.fromARGB(255, 255, 255, 255),
    this.insetBoxColor = const Color.fromARGB(255, 255, 255, 255),
    this.dropShadowColorTop = const Color.fromARGB(10, 158, 158, 158),
    this.dropShadowColorBottom = const Color.fromARGB(50, 255, 255, 255),
    this.insetShadowColorTop = const Color.fromARGB(255, 158, 158, 158),
    this.insetShadowColorBottom = const Color.fromARGB(100, 255, 255, 255),
    this.dropShadowOffsetTop = const Offset(-4, -4),
    this.dropShadowOffsetBottom = const Offset(4, 4),
    this.insetShadowOffsetTop = const Offset(-1, -1),
    this.insetShadowOffsetBottom = const Offset(1, 1),
    this.child,
    super.key,
  });

  const InsetShadowContainer.dark(
    this.width,
    this.height, {
    this.boxSpacing = 0.1,
    this.boxRadius = 50.0,
    this.blurRadiusDrop = 1.0,
    this.blurRadiusInset = 2.0,
    this.spreadRadiusDrop = 1.0,
    this.spreadRadiusInset = 1.0,
    this.color = const Color.fromARGB(255, 23, 25, 56),
    this.dropBoxColor = const Color.fromARGB(255, 23, 25, 56),
    this.insetBoxColor = const Color.fromARGB(255, 23, 25, 56),
    this.dropShadowColorTop = const Color.fromARGB(57, 24, 26, 41),
    this.dropShadowColorBottom = const Color.fromARGB(98, 30, 30, 70),
    this.insetShadowColorTop = const Color.fromARGB(255, 28, 30, 45),
    this.insetShadowColorBottom = const Color.fromARGB(255, 29, 32, 72),
    this.dropShadowOffsetTop = const Offset(-4, -4),
    this.dropShadowOffsetBottom = const Offset(4, 4),
    this.insetShadowOffsetTop = const Offset(-1, -1),
    this.insetShadowOffsetBottom = const Offset(1, 1),
    this.child,
    super.key,
  });

  @override
  State<InsetShadowContainer> createState() => _InsetShadowContainerState();
}

class _InsetShadowContainerState extends State<InsetShadowContainer> {
  Widget? get child => widget.child;

  double get dropBoxWidth => widget.width;
  double get dropBoxHeight => widget.height;
  double get insetBoxWidth => widget.width - widget.boxSpacing;
  double get insetBoxHeight => widget.height - widget.boxSpacing;

  double get boxSpacing => widget.boxSpacing;
  double get boxRadius => widget.boxRadius;

  double get blurRadiusDrop => widget.blurRadiusDrop;
  double get blurRadiusInset => widget.blurRadiusInset;
  double get spreadRadiusDrop => widget.spreadRadiusDrop;
  double get spreadRadiusInset => widget.spreadRadiusInset;

  Color? get color => widget.color;
  Color? get dropBoxColor => widget.dropBoxColor;
  Color? get insetBoxColor => widget.insetBoxColor;

  Color get dropShadowColorTop => widget.dropShadowColorTop;
  Color get dropShadowColorBottom => widget.dropShadowColorBottom;
  Color get insetShadowColorTop => widget.insetShadowColorTop;
  Color get insetShadowColorBottom => widget.insetShadowColorBottom;

  Offset get dropShadowOffsetTop => widget.dropShadowOffsetTop;
  Offset get dropShadowOffsetBottom => widget.dropShadowOffsetBottom;
  Offset get insetShadowOffsetTop => widget.insetShadowOffsetTop;
  Offset get insetShadowOffsetBottom => widget.insetShadowOffsetBottom;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: dropBoxWidth,
      height: dropBoxHeight,
      decoration: BoxDecoration(
        color: dropBoxColor,
        borderRadius: BorderRadius.circular(boxRadius),
        boxShadow: [
          BoxShadow(
            color: dropShadowColorTop,
            offset: dropShadowOffsetTop,
            blurRadius: blurRadiusDrop,
            spreadRadius: spreadRadiusDrop,
          ),
          BoxShadow(
            color: dropShadowColorBottom,
            offset: dropShadowOffsetBottom,
            blurRadius: blurRadiusDrop,
            spreadRadius: spreadRadiusDrop,
          ),
        ],
      ),
      child: Center(
        child: Container(
          width: insetBoxWidth,
          height: insetBoxHeight,
          decoration: BoxDecoration(
            color: insetBoxColor,
            borderRadius: BorderRadius.circular(boxRadius),
            boxShadow: [
              BoxShadow(
                color: insetShadowColorTop,
                offset: insetShadowOffsetTop,
                blurRadius: blurRadiusInset,
                spreadRadius: spreadRadiusInset,
              ),
              BoxShadow(
                color: insetShadowColorBottom,
                offset: insetShadowOffsetBottom,
                blurRadius: blurRadiusInset,
                spreadRadius: spreadRadiusInset,
              ),
            ],
          ),
          child: Container(
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(boxRadius),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
