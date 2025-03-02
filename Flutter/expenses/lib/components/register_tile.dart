import 'package:expenses/models/register.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RegisterTile extends StatefulWidget {
  final Register register;

  final double width;
  final double height;
  final double expandedWidth;
  final double expandedHeight;
  final double radius;
  final double minOpacity;
  final double maxOpacity;
  final int minAnimationDuration;
  final int maxAnimationDuration;
  final bool openState;
  final Alignment initialAlignment;
  final Alignment finalAlignment;
  final Offset initialOffset;
  final Offset finalOffset;
  final Color? color;
  final List<BoxShadow>? boxShadow;

  const RegisterTile(
    this.register, {
    this.width = 0,
    this.height = 0,
    this.expandedWidth = 250,
    this.expandedHeight = 100,
    this.radius = 12,
    this.minOpacity = 0,
    this.maxOpacity = 1,
    this.maxAnimationDuration = 1000,
    this.minAnimationDuration = 300,
    this.openState = false,
    this.initialAlignment = Alignment.topRight,
    this.finalAlignment = Alignment.topLeft,
    this.initialOffset = const Offset(0, -0.5),
    this.finalOffset = const Offset(0, 0),
    this.color,
    this.boxShadow = const [
      BoxShadow(
        color: Colors.black26,
        offset: Offset(4, 4),
        blurRadius: 8,
      )
    ],
    super.key,
  });

  @override
  State<RegisterTile> createState() => _RegisterTileState();
}

class _RegisterTileState extends State<RegisterTile> {
  late bool isOpen;
  final String _dateFormat = 'yyyy MMM dd';

  double get initialWidth => widget.width;
  double get initialHeight => widget.height;
  double get radius => widget.radius;
  double get expandedWidth => widget.expandedWidth;
  double get expandedHeight => widget.expandedHeight;
  double get minOpacity => widget.minOpacity;
  double get maxOpacity => widget.maxOpacity;
  int get minAnimationDuration => widget.minAnimationDuration;
  int get maxAnimationDuration => widget.maxAnimationDuration;
  bool get openState => widget.openState;
  Alignment get initialAlignment => widget.initialAlignment;
  Alignment get finalAlignment => widget.finalAlignment;
  Offset get initialOffset => widget.initialOffset;
  Offset get finalOffset => widget.finalOffset;
  Color? get color => widget.color;
  List<BoxShadow>? get boxShadow => widget.boxShadow;

  @override
  void initState() {
    isOpen = openState;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant RegisterTile oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.openState != widget.openState) {
      setState(() {
        isOpen = widget.openState;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: isOpen ? expandedWidth : initialWidth,
      height: isOpen ? expandedHeight : initialHeight,
      duration: Duration(milliseconds: minAnimationDuration),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(radius),
        boxShadow: boxShadow,
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 20,
          ),
          child: AnimatedOpacity(
            opacity: isOpen ? maxOpacity : minOpacity,
            duration: Duration(
              milliseconds: isOpen
                  ? maxAnimationDuration
                  : (maxAnimationDuration * 0.1).toInt(),
            ),
            curve: Curves.easeInOut,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AnimatedAlign(
                  alignment: isOpen ? finalAlignment : initialAlignment,
                  duration: Duration(milliseconds: maxAnimationDuration),
                  curve: Curves.easeInOut,
                  child: FittedBox(
                    child: Text(
                      widget.register.name,
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ),
                ),
                Divider(
                  thickness: 1,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
                Row(
                  children: [
                    Expanded(
                      child: AnimatedAlign(
                        alignment: isOpen ? finalAlignment : initialAlignment,
                        duration: Duration(milliseconds: maxAnimationDuration),
                        curve: Curves.easeInOut,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            widget.register.topic,
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: AnimatedAlign(
                        alignment: isOpen ? initialAlignment : finalAlignment,
                        duration: Duration(milliseconds: maxAnimationDuration),
                        curve: Curves.easeInOut,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Icon(
                                widget.register.coinIcon,
                                size: 18,
                                color: Theme.of(context).colorScheme.onPrimary,
                              ),
                              Text(
                                widget.register.value.value.toStringAsFixed(
                                    widget.register.value.fractionDigits),
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Divider(
                  thickness: 1,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
                AnimatedSlide(
                  duration: Duration(
                    milliseconds: maxAnimationDuration,
                  ),
                  offset: isOpen ? finalOffset : initialOffset,
                  child: Text(
                    widget.register.description,
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                AnimatedAlign(
                  alignment: isOpen ? initialAlignment : finalAlignment,
                  duration: Duration(milliseconds: maxAnimationDuration),
                  curve: Curves.easeInOut,
                  child: FittedBox(
                    child: Text(
                      DateFormat(_dateFormat).format(widget.register.dateTime),
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
