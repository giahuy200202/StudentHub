import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:motion_toast/motion_toast.dart';

class AlertToastHelper {
  AlertToastHelper();

  void showSuccessToast(context, title, description) {
    MotionToast(
      icon: Icons.check,
      primaryColor: Colors.green,
      title: const Text(
        "Success",
        style: TextStyle(
          fontSize: 16,
          color: Colors.black,
          fontWeight: FontWeight.w700,
        ),
      ),
      description: const Text(
        "Login succesfully",
        style: TextStyle(
          fontSize: 16,
          color: Colors.black,
          fontWeight: FontWeight.w400,
        ),
      ),
      width: 500,
      height: 80,
    ).show(context);
  }
}
