import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

import 'package:expenses/components/inset_shadow_container.dart';
import 'package:expenses/components/chart_bar.dart';
import 'package:expenses/components/register_tile.dart';
import 'package:expenses/models/register.dart';
import 'package:expenses/models/value_formatter.dart';

class RegisterCard extends StatefulWidget {
  static const double _standardCardWidth = 100;
  static const double _standardCardHeight = 100;
  static const double _longCardWidth = 300;
  static const double _longCardHeight = 100;

  final void Function() updateState;

  final Register register;
  final double? budget;

  final double? width;
  final double? height;
  final double expandedWidth;
  final double expandedHeight;
  final double spacing;
  final double radius;
  final double elevation;
  final double minOpacity;
  final double maxOpacity;
  final double? vertical;
  final double? horizontal;
  final int minAnimationDuration;
  final int maxAnimationDuration;
  final bool badge;
  final bool mainAxis;
  final bool longCard;

  const RegisterCard(
    this.register,
    this.updateState, {
    this.budget,
    this.width,
    this.height,
    this.expandedWidth = 300,
    this.expandedHeight = 100,
    this.spacing = 10,
    this.radius = 12,
    this.elevation = 5,
    this.minOpacity = 0,
    this.maxOpacity = 1,
    this.vertical,
    this.horizontal,
    this.minAnimationDuration = 300,
    this.maxAnimationDuration = 1000,
    this.badge = true,
    this.mainAxis = true,
    this.longCard = false,
    super.key,
  });

  @override
  State<RegisterCard> createState() => _RegisterCardState();
}

class _RegisterCardState extends State<RegisterCard> {
  bool _isOpen = false;
  final double _minAmount = 0.0;
  final String _dateFormat = 'yyyy MMM dd';

  late double width;
  late double height;

  void Function() get updateState => widget.updateState;

  Register get register => widget.register;

  double get budget => (widget.budget == null)
      ? Register.total
      : widget.budget! <= _minAmount
          ? Register.total
          : widget.budget!;

  double get spentPercentageTotal => (widget.budget == null)
      ? register.value.toDouble() / Register.total
      : widget.budget! <= _minAmount
          ? register.value.toDouble() / Register.total
          : register.value.toDouble() / widget.budget!;

  double get spentPercentage => (widget.budget == null)
      ? _minAmount
      : widget.budget! <= _minAmount
          ? _minAmount
          : register.value.toDouble() / widget.budget!;

  double get individualProportion => register.value.toDouble() / Register.total;

  double get expandedWidth => widget.expandedWidth;
  double get expandedHeight => widget.expandedHeight;

  double get spacing => widget.spacing;
  double get radius => widget.radius;
  double get elevation => widget.elevation;
  double get minOpacity => widget.minOpacity;
  double get maxOpacity => widget.maxOpacity;

  double get vertical {
    return mainAxis
        ? widget.vertical ?? spacing * 2
        : widget.vertical ?? height;
  }

  double get horizontal {
    return mainAxis
        ? widget.horizontal ?? width - spacing
        : widget.horizontal ?? spacing;
  }

  int get minAnimationDuration => widget.minAnimationDuration;
  int get maxAnimationDuration => widget.maxAnimationDuration;
  int get tenthMaxAnimationDuration => (maxAnimationDuration * 0.1).toInt();
  int get halfMaxAnimationDuration => (maxAnimationDuration * 0.5).toInt();

  bool get badge => widget.badge;
  bool get mainAxis => widget.mainAxis;
  bool get longCard => widget.longCard;

  @override
  void initState() {
    width = widget.width ??
        (widget.longCard
            ? RegisterCard._longCardWidth
            : RegisterCard._standardCardWidth);
    height = widget.height ??
        (widget.longCard
            ? RegisterCard._longCardHeight
            : RegisterCard._standardCardHeight);
    super.initState();
  }

  void _openClose() {
    setState(() {
      _isOpen = !_isOpen;
    });
  }

  void _remove() {
    setState(() {
      Register.removeRegister(register.index);
      updateState();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedContainer(
          width: mainAxis
              ? _isOpen
                  ? width + expandedWidth + spacing
                  : width + spacing
              : _isOpen
                  ? expandedWidth + horizontal + spacing
                  : width + spacing,
          height: mainAxis
              ? _isOpen
                  ? expandedHeight + vertical + spacing
                  : height + spacing
              : _isOpen
                  ? height + expandedHeight + spacing
                  : height + spacing,
          duration: Duration(milliseconds: minAnimationDuration),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius),
          ),
          child: Stack(
            children: [
              Positioned(
                top: vertical,
                left: horizontal,
                child: RegisterTile(
                  register,
                  width: mainAxis ? 0 : width - spacing,
                  height: mainAxis ? height - spacing : 0,
                  expandedWidth:
                      mainAxis ? expandedWidth : expandedWidth - spacing,
                  expandedHeight:
                      mainAxis ? expandedHeight - spacing : expandedHeight,
                  radius: radius,
                  minOpacity: minOpacity,
                  maxOpacity: maxOpacity,
                  minAnimationDuration: minAnimationDuration,
                  maxAnimationDuration: maxAnimationDuration,
                  openState: _isOpen,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: SizedBox(
                  width: width + spacing,
                  height: height + spacing,
                  child: Center(
                    child: Card(
                      color: Theme.of(context).colorScheme.surface,
                      elevation: elevation,
                      child: SizedBox(
                        width: 300,
                        height: height,
                        child: FloatingActionButton(
                          backgroundColor:
                              Theme.of(context).colorScheme.surface,
                          onPressed: _openClose,
                          child: longCard
                              ? SizedBox(
                                  width: width,
                                  height: height,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Flexible(
                                            flex: 1,
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(2.0),
                                                child: Theme.of(context)
                                                            .brightness ==
                                                        Brightness.dark
                                                    ? InsetShadowContainer.dark(
                                                        height / 2,
                                                        height / 2,
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .secondary,
                                                        child: FittedBox(
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Text(
                                                              register.value
                                                                  .valueWithoutCipher,
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .displayLarge,
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    : InsetShadowContainer
                                                        .light(
                                                        height / 2,
                                                        height / 2,
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .secondary,
                                                        child: FittedBox(
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Text(
                                                              register.value
                                                                  .valueWithoutCipher,
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .displayLarge,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                              ),
                                            ),
                                          ),
                                          Flexible(
                                            flex: 3,
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 8.0,
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    FittedBox(
                                                      child: Text(
                                                        register.name,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .titleLarge,
                                                      ),
                                                    ),
                                                    FittedBox(
                                                      child: Text(
                                                        DateFormat(_dateFormat)
                                                            .format(register
                                                                .dateTime),
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .titleMedium,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          Flexible(
                                            flex: 1,
                                            child: FittedBox(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(2.0),
                                                child: IconButton(
                                                  onPressed: () => _remove(),
                                                  icon: Icon(Icons.delete),
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .onTertiary,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Divider(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimary,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Flexible(
                                            flex: 1,
                                            child: FittedBox(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: Text(
                                                  register.value.toString(),
                                                  textAlign: TextAlign.center,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleMedium,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Flexible(
                                            flex: 3,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: FittedBox(
                                                child: ChartBar(
                                                  width: width,
                                                  height: 5,
                                                  spentPercentageTotal,
                                                  darkMode: Theme.of(context)
                                                          .brightness ==
                                                      Brightness.dark,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Flexible(
                                            flex: 1,
                                            child: FittedBox(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: Text(
                                                  ValueFormatter.formatter(
                                                      budget),
                                                  textAlign: TextAlign.center,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleMedium,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                )
                              : SizedBox(
                                  width: width,
                                  height: height,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 6.0,
                                          horizontal: 4.0,
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Flexible(
                                              child: Theme.of(context)
                                                          .brightness ==
                                                      Brightness.dark
                                                  ? InsetShadowContainer.dark(
                                                      height / 2,
                                                      height / 2,
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .secondary,
                                                      child: FittedBox(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Text(
                                                            register.value
                                                                .valueWithoutCipher,
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .displayLarge,
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  : InsetShadowContainer.light(
                                                      height / 2,
                                                      height / 2,
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .secondary,
                                                      child: FittedBox(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Text(
                                                            register.value
                                                                .valueWithoutCipher,
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .displayLarge,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                            ),
                                            FittedBox(
                                              child: Text(
                                                DateFormat(_dateFormat)
                                                    .format(register.dateTime),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleSmall,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 6.0,
                                            ),
                                            child: Column(
                                              spacing: 4,
                                              children: [
                                                Flexible(
                                                  child: ChartBar(
                                                    width: 5,
                                                    height:
                                                        height - (spacing * 3),
                                                    spentPercentage,
                                                    mainAxis: false,
                                                    darkMode: Theme.of(context)
                                                            .brightness ==
                                                        Brightness.dark,
                                                  ),
                                                ),
                                                FittedBox(
                                                  child: Icon(
                                                    Icons.monetization_on,
                                                    size: 14,
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .onTertiary,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 6.0,
                                            ),
                                            child: Column(
                                              spacing: 4,
                                              children: [
                                                Flexible(
                                                  child: ChartBar(
                                                    width: 5,
                                                    height:
                                                        height - (spacing * 3),
                                                    individualProportion,
                                                    mainAxis: false,
                                                    darkMode: Theme.of(context)
                                                            .brightness ==
                                                        Brightness.dark,
                                                  ),
                                                ),
                                                FittedBox(
                                                  child: Icon(
                                                    Icons.pie_chart,
                                                    size: 14,
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .onTertiary,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              badge
                  ? AnimatedPositioned(
                      top: mainAxis
                          ? _isOpen
                              ? 0
                              : 25
                          : null,
                      bottom: mainAxis
                          ? null
                          : _isOpen
                              ? 0
                              : 25,
                      left: mainAxis ? null : 0,
                      right: mainAxis ? 0 : null,
                      duration: Duration(milliseconds: maxAnimationDuration),
                      curve: Curves.easeInOut,
                      child: AnimatedOpacity(
                        opacity: _isOpen ? maxOpacity : minOpacity,
                        duration: Duration(
                          milliseconds: _isOpen
                              ? maxAnimationDuration + halfMaxAnimationDuration
                              : tenthMaxAnimationDuration,
                        ),
                        curve: Curves.easeInOut,
                        child: Card(
                          elevation: elevation,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: CircleAvatar(
                            child: Icon(widget.register.paymentIcon),
                          ),
                        ),
                      ),
                    )
                  : SizedBox.shrink(),
            ],
          ),
        ),
      ],
    );
  }
}
