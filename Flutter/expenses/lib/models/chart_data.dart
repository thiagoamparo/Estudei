import 'package:flutter/material.dart';

class ChartData {
  static final Map<int, String> legendNames = {};
  static final Map<int, Color> legendColors = {};

  static const double _zero = 0.0;

  double value;

  int? index;
  String? header;
  String? title;
  String? subtitle;
  String? legend;
  String? topLabel;
  String? leftLabel;
  String? rightLabel;
  String? bottomLabel;
  String? centerLabel;
  String? footer;
  Color? color;

  ChartData(
    this.value, {
    this.header,
    this.title,
    this.subtitle,
    this.legend,
    this.topLabel,
    this.leftLabel,
    this.rightLabel,
    this.bottomLabel,
    this.centerLabel,
    this.footer,
    this.color,
    this.index,
  }) {
    if (value.isNaN || value.isNegative) {
      value = _zero;
    }
  }
}
