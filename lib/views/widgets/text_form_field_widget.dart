import 'package:flutter/material.dart';
import 'package:to_do_app/constants/colors.dart';
import 'package:to_do_app/constants/extensions.dart';

class TextFormFieldWidget extends StatelessWidget {
  final TextEditingController inputController;
  final String? labelText;

  const TextFormFieldWidget(
    this.inputController, {
    this.labelText,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: inputController,
      cursorColor: AppColors.whiteColor,
      textInputAction: TextInputAction.next,
      style: const TextStyle(
        color: AppColors.whiteColor,
      ),
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(
          color: Colors.white,
        ),
        border: _outlineInputBorder(),
        disabledBorder: _outlineInputBorder(),
        focusedBorder: _outlineInputBorder(),
        enabledBorder: _outlineInputBorder(),
      ),
    );
  }

  OutlineInputBorder _outlineInputBorder() {
    return OutlineInputBorder(
      borderRadius: 15.borderRadiusAll,
      borderSide: const BorderSide(
        color: AppColors.whiteColor,
      ),
    );
  }
}
