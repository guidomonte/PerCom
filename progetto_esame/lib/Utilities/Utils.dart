import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utils {

  static const dark_blue = Color.fromRGBO(8, 57, 107, 1);

  static showOkToast(FToast toast) => toast.showToast(
        child: buildOkToast(),
        gravity: ToastGravity.BOTTOM,
      );

  static showFailToast(FToast toast) => toast.showToast(
        child: buildFailToast(),
        gravity: ToastGravity.BOTTOM,
      );

  static showFailToastText(FToast toast) => toast.showToast(
        child: buildFailToast(),
        gravity: ToastGravity.BOTTOM,
      );

  static Widget buildOkToast() => Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Colors.greenAccent,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(Icons.check, color: Colors.black87),
            SizedBox(width: 12.0),
            Text(
              'Done',
              style: TextStyle(color: Colors.black, fontSize: 18),
            )
          ],
        ),
      );

  static Widget buildFailToast() => Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Colors.redAccent,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(Icons.close, color: Colors.black87),
            SizedBox(width: 12.0),
            Text(
              'Failed',
              style: TextStyle(color: Colors.black, fontSize: 18),
            )
          ],
        ),
      );
}
