import 'package:expenses/components/chart_bar.dart';
import 'package:expenses/models/chart_data.dart';

import 'package:flutter/material.dart';

class Chart extends StatefulWidget {
  final List<ChartData> data;
  final List<List<ChartData>> dataValues;

  final double width;
  final double height;
  final double radius;
  final double barWidth;
  final double barHeight;
  final double barSpacing;
  final double barRadius;
  final double elevation;
  final String emptyTopLabel;
  final String emptyLeftLabel;
  final String emptyRightLabel;
  final String emptyBottomLabel;
  final bool mainAxis;
  final bool defaultColor;
  final bool randomColor;
  final bool darkMode;
  final Color barColor;
  final ScrollController? scrollController;

  const Chart(
    this.data, {
    this.dataValues = const [],
    this.width = 300,
    this.height = 200,
    this.radius = 20,
    this.barWidth = 10,
    this.barHeight = 100,
    this.barSpacing = 10,
    this.barRadius = 20,
    this.elevation = 5,
    this.emptyTopLabel = '',
    this.emptyLeftLabel = '',
    this.emptyRightLabel = '',
    this.emptyBottomLabel = '',
    this.mainAxis = false,
    this.defaultColor = false,
    this.randomColor = false,
    this.darkMode = false,
    this.barColor = Colors.blueAccent,
    this.scrollController,
    super.key,
  });

  @override
  State<Chart> createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  List<ChartData> get data => widget.data;
  List<List<ChartData>> get dataValues => widget.dataValues;

  double get width => widget.width;
  double get height => widget.height;
  double get radius => widget.radius;
  double get barWidth => widget.barWidth;
  double get barHeight => widget.barHeight;
  double get barSpacing => widget.barSpacing;
  double get barRadius => widget.barRadius;
  double get elevation => widget.elevation;

  String get emptyTopLabel => widget.emptyTopLabel;
  String get emptyLeftLabel => widget.emptyLeftLabel;
  String get emptyRightLabel => widget.emptyRightLabel;
  String get emptyBottomLabel => widget.emptyBottomLabel;

  bool get mainAxis => widget.mainAxis;
  bool get defaultColor => widget.defaultColor;
  bool get randomColor => widget.randomColor;
  bool get darkMode => widget.darkMode;

  Color get barColor => widget.barColor;

  ScrollController? get scrollController => widget.scrollController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
              controller: scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: data.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: barSpacing,
                  ),
                  padding: EdgeInsets.all(2.0),
                  child: Row(
                    children: [
                      Text(data[index].leftLabel ?? emptyLeftLabel),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(data[index].topLabel ?? emptyTopLabel),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ChartBar(
                              data[index].value,
                              dataValues: dataValues[index]
                                  .map((data) => data.value)
                                  .toList(),
                              height: barHeight,
                              width: barWidth,
                              radius: barRadius,
                              mainAxis: mainAxis,
                              color: defaultColor || randomColor
                                  ? barColor
                                  : data[index].color ?? barColor,
                              dataColors: defaultColor || randomColor
                                  ? []
                                  : dataValues[index]
                                      .map((data) => data.color ?? barColor)
                                      .toList(),
                              darkMode: darkMode,
                            ),
                          ),
                          Text(data[index].bottomLabel ?? emptyBottomLabel),
                        ],
                      ),
                      Text(data[index].rightLabel ?? emptyRightLabel),
                    ],
                  ),
                );
              }),
        ),
      ),
    );
  }
}
