import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

const int aSec = 1;

const String secPostFix = 's';
const String labelSplitter = '|';

class TimeButton extends StatefulWidget {
  /// Create a TimeButton
  ///
  /// The [label], [timeout], [onPressed] and [toastMessage]
  /// arguments must not be null.

  /// [label]
  /// Button's label
  final String label;

  /// [timeout]
  /// Timeout after with the button is enabled
  final int timeout;

  /// [color]
  /// Button's color
  final Color? color;

  /// [textColor]
  /// Button's text color
  final Color? textColor;

  /// [disabledColor]
  /// Button's disabled color
  final Color? disabledColor;

  /// [disabledTextColor]
  /// Button's disabled text color
  final Color? disabledTextColor;

  /// [textFontWeight]
  /// Button's text weight
  final FontWeight? textFontWeight;

  /// [onPressed]
  /// Called when the button is tapped
  final Function? onPressed;

  /// [toastMessage]
  /// Show after button is tapped
  final String toastMessage;

  const TimeButton({
    Key? key,
    required this.label,
    required this.timeout,
    required this.onPressed,
    required this.toastMessage,
    this.color,
    this.textColor,
    this.textFontWeight,
    this.disabledTextColor,
    this.disabledColor,
  }) : super(key: key);

  @override
  _TimeButtonState createState() => _TimeButtonState();
}

class _TimeButtonState extends State<TimeButton> {
  bool timeUpFlag = false;
  int timer = 0;

  String get _timerText => '$timer$secPostFix';

  @override
  void initState() {
    super.initState();
    timer = widget.timeout;
    _timerUpdate();
  }

  _timerUpdate() {
    Timer(const Duration(seconds: aSec), () async {
      if (this.mounted) {
        setState(() {
          timer--;
        });
      }
      if (timer != 0)
        _timerUpdate();
      else
        timeUpFlag = true;
    });
  }

  Widget _buildChild() {
    return timeUpFlag
        ? Text(
            widget.label,
            style: TextStyle(
              fontSize: 15,
              fontWeight: widget.textFontWeight != null
                  ? widget.textFontWeight
                  : FontWeight.normal,
              color: widget.textColor != null ? widget.textColor : Colors.white,
            ),
          )
        : Text(
            '${widget.label} $labelSplitter $_timerText',
            style: TextStyle(
              fontSize: 15,
              fontWeight: widget.textFontWeight != null
                  ? widget.textFontWeight
                  : FontWeight.normal,
              color: widget.disabledTextColor != null
                  ? widget.disabledTextColor
                  : Colors.white,
            ),
          );
  }

  _onPressed() {
    if (timeUpFlag) {
      if (widget.onPressed != null) widget.onPressed!();
    }

    timeUpFlag = false;
    timer = widget.timeout;
    _timerUpdate();

    Fluttertoast.showToast(
        msg: widget.toastMessage,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM);
  }

  Color _backgroundColor(BuildContext _) {
    if (timeUpFlag) {
      return widget.color ?? Theme.of(_).accentColor;
    }

    return widget.disabledColor ?? Theme.of(_).dividerColor;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          backgroundColor: _backgroundColor(context),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
            side: BorderSide(
              width: 2.0,
              color: timeUpFlag
                  ? Theme.of(context).accentColor
                  : Theme.of(context).dividerColor,
            ),
          ),
        ),
        child: _buildChild(),
        onPressed: timeUpFlag ? () => _onPressed() : null,
      ),
    );
  }
}
