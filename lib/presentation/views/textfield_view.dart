// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:m_hike/common/constants.dart/app_color.dart';

class TextFieldView extends StatelessWidget {
  const TextFieldView(
      {super.key,
      required this.controller,
      required this.focusNode,
      required this.onChanged,
      required this.onSubmitted,
      this.keyboardType = TextInputType.text,
      this.placeholder});

  final TextEditingController controller;
  final FocusNode focusNode;
  final TextInputType keyboardType;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final String? placeholder;
  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: keyboardType,
      focusNode: focusNode,
      controller: controller,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      decoration: InputDecoration(
        hintText: placeholder,
        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppColor.grayI)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppColor.blueI)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppColor.redI)),
      ),
    );
  }
}
