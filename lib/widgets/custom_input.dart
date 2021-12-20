import 'package:flutter/material.dart';
import 'package:odm_ui/constants.dart';

class CustomInput extends StatelessWidget {
  final String hintText;
  CustomInput({this.hintText});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      margin: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFF2F2F2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 24,
          )
        ),
        style: Constants.regDarkTxt,
      ),
    );
  }
}
