// ignore_for_file: type_annotate_public_apis

import 'package:flutter/material.dart';

import '../../../styles/styles.dart';

///
void showModalDialog({
  required BuildContext context,
  required Widget dialogWidget,
  required bool isScrollable,
}) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) => dialogWidget,
    isScrollControlled: isScrollable,
    backgroundColor: dialogBackgroundColor,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(24),
      ),
    ),
  );
}

///
String convertTimeFormat({required int seconds}) {
  final duration = Duration(seconds: seconds);

  String twoDigits(int n) => n.toString().padLeft(2, '0');

  final minutesString = twoDigits(duration.inMinutes.remainder(60));
  final secondsString = twoDigits(duration.inSeconds.remainder(60));

  return '$minutesString : $secondsString';
}
