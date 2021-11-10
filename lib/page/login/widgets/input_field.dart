
import 'package:flutter/material.dart';

import '../../../app_colors.dart';
import '../../../dimens.dart';

class InputField extends StatelessWidget {

  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final String errorText;
  final Function(String value) onChanged;

  InputField({this.controller,
    this.hintText,
    this.obscureText = false,
    this.errorText,
    this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(Dimens.size10),
      elevation: Dimens.size3,
      shadowColor: AppColors.primaryColor,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius:
              BorderRadius.circular(Dimens.size10),
              borderSide: BorderSide.none),
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.grey),
          contentPadding: EdgeInsets.symmetric(
              horizontal: Dimens.size10,
              vertical: Dimens.size20),
          filled: true,
          fillColor: Colors.white,
          errorText: errorText,
        ),
        obscureText: obscureText,
        onChanged: onChanged,
      ),
    );
  }
}
