import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:to_do_app/constants/colors.dart';

extension NumExt on num {
  /// Gap.
  SizedBox get gap => SizedBox(
        height: toDouble(),
        width: toDouble(),
      );

  /// Edge Insets.
  EdgeInsets get edgeInsetsAll => EdgeInsets.all(toDouble());

  EdgeInsets get edgeInsetsVertical => EdgeInsets.symmetric(vertical: toDouble());

  EdgeInsets get edgeInsetsHorizontal => EdgeInsets.symmetric(horizontal: toDouble());

  /// Border Radius.
  BorderRadius get borderRadiusAll => BorderRadius.circular(toDouble());

  BorderRadius get borderRadiusTop => BorderRadius.vertical(
        top: Radius.circular(toDouble()),
      );

  BorderRadius get borderRadiusBottom => BorderRadius.vertical(
        bottom: Radius.circular(toDouble()),
      );
}

extension StringExt on String {
  /// Toast.
  Future<bool?> get showToast => Fluttertoast.showToast(
        msg: this,
        fontSize: 16,
        textColor: AppColors.whiteColor,
        backgroundColor: AppColors.darkBlueColor,
      );
}
