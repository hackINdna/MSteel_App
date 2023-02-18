import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Future<dynamic> showCircularProgressIndicator({required BuildContext context}) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return Center(
        child: Material(
          elevation: 5,
          borderRadius: BorderRadius.circular(5),
          clipBehavior: Clip.antiAlias,
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
            ),
            child: const CircularProgressIndicator(),
          ),
        ),
      );
    },
  );
}
