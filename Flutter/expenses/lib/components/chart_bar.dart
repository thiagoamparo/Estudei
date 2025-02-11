import 'dart:math';

import 'package:flutter/material.dart';
import 'package:expenses/components/inset_shadow_container.dart';

class ChartBar extends StatefulWidget {
  final double value;
  final List<double> dataValues;
  final List<Color> dataColors;

  final double width;
  final double height;
  final double radius;
  final double overlayBorderWidth;

  final bool mainAxis;
  final bool allowOverlay;
  final bool darkMode;

  final Color color;
  final Color background;
  final Color overlayBorderColor;

  final int? colorSeed;

  const ChartBar(
    this.value, {
    this.dataValues = const [],
    this.dataColors = const [],
    this.width = 100,
    this.height = 10,
    this.radius = 5,
    this.overlayBorderWidth = 1,
    this.mainAxis = true,
    this.allowOverlay = true,
    this.darkMode = false,
    this.color = Colors.blueAccent,
    this.background = Colors.white,
    this.overlayBorderColor = Colors.indigo,
    this.colorSeed = 37,
    super.key,
  });

  @override
  State<ChartBar> createState() => _ChartBarState();
}

class _ChartBarState extends State<ChartBar> {
  final double _minValue = 0.0;
  final double _maxValue = 1.0;

  late List<double> values;
  late List<Color> colors;

  double get width => widget.width;
  double get height => widget.height;
  double get radius => widget.radius;
  double get overlayBorderWidth => widget.overlayBorderWidth;

  bool get mainAxis => widget.mainAxis;
  bool get allowOverlay => widget.allowOverlay;
  bool get darkMode => widget.darkMode;

  Color get color => widget.color;
  Color get background => widget.background;
  Color get overlayBorderColor => widget.overlayBorderColor;

  int? get colorSeed => widget.colorSeed;

  @override
  void initState() {
    values = [widget.value];
    colors = [widget.color];

    values = values + widget.dataValues;
    colors = colors + widget.dataColors;

    colors =
        colors + _getRandomColors(values.length - colors.length, colorSeed);

    values.sort((a, b) => b.compareTo(a));

    super.initState();
  }

  @override
  void didUpdateWidget(covariant ChartBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    setState(() {
      values = [widget.value];
      colors = [widget.color];

      values = values + widget.dataValues;
      colors = colors + widget.dataColors;

      colors =
          colors + _getRandomColors(values.length - colors.length, colorSeed);

      values.sort((a, b) => b.compareTo(a));
    });
  }

  List<Color> _getRandomColors(int length, int? seed) {
    List<Color> listColors = [];

    seed = seed ?? length;

    while (listColors.length < length) {
      Color color = Color.fromARGB(
        255,
        Random(seed + (listColors.length * 2)).nextInt(50),
        Random(seed + (listColors.length * 3)).nextInt(100) + 50,
        Random(seed + (listColors.length * 4)).nextInt(150) + 100,
      );

      if (!listColors.any((currentColor) =>
          currentColor.r == color.r &&
          currentColor.g == color.g &&
          currentColor.b == color.b &&
          currentColor.a == color.a)) {
        listColors.add(color);
      }
    }

    return listColors;
  }

  double _getValue(int index) {
    return values[index] < _minValue
        ? _minValue
        : values[index] > _maxValue
            ? _maxValue
            : values[index];
  }

  bool _isOverwritten(List<double> values, int index) {
    return values.lastIndexOf(values[index]) != values.indexOf(values[index]) &&
        values.lastIndexOf(values[index]) == index;
  }

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: mainAxis ? Axis.horizontal : Axis.vertical,
      children: [
        darkMode
            ? InsetShadowContainer.dark(
                width,
                height,
                boxRadius: radius,
                color: background,
                child: Stack(
                  alignment:
                      mainAxis ? Alignment.centerLeft : Alignment.bottomCenter,
                  children: List.generate(
                    values.length,
                    (index) => AnimatedFractionallySizedBox(
                      duration: Duration(milliseconds: 1000),
                      widthFactor: mainAxis ? _getValue(index) : null,
                      heightFactor: !mainAxis ? _getValue(index) : null,
                      child: Container(
                        decoration: BoxDecoration(
                          color: colors[index],
                          borderRadius: BorderRadius.circular(radius),
                          border: allowOverlay && _isOverwritten(values, index)
                              ? mainAxis
                                  ? Border(
                                      right: BorderSide(
                                        color: overlayBorderColor,
                                        width: overlayBorderWidth,
                                      ),
                                    )
                                  : Border(
                                      top: BorderSide(
                                        color: overlayBorderColor,
                                        width: overlayBorderWidth,
                                      ),
                                    )
                              : null,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            : InsetShadowContainer.light(
                width,
                height,
                boxRadius: radius,
                color: background,
                child: Stack(
                  alignment:
                      mainAxis ? Alignment.centerLeft : Alignment.bottomCenter,
                  children: List.generate(
                    values.length,
                    (index) => AnimatedFractionallySizedBox(
                      duration: Duration(milliseconds: 1000),
                      widthFactor: mainAxis ? _getValue(index) : null,
                      heightFactor: !mainAxis ? _getValue(index) : null,
                      child: Container(
                        decoration: BoxDecoration(
                          color: colors[index],
                          borderRadius: BorderRadius.circular(radius),
                          border: allowOverlay && _isOverwritten(values, index)
                              ? mainAxis
                                  ? Border(
                                      right: BorderSide(
                                        color: overlayBorderColor,
                                        width: overlayBorderWidth,
                                      ),
                                    )
                                  : Border(
                                      top: BorderSide(
                                        color: overlayBorderColor,
                                        width: overlayBorderWidth,
                                      ),
                                    )
                              : null,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
      ],
    );
  }
}
