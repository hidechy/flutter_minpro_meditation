// ignore_for_file: type_annotate_public_apis

import 'package:flutter/material.dart';

import '../../styles/styles.dart';

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
