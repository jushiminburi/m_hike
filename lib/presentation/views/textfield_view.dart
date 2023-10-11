// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:m_hike/common/constants.dart/app_color.dart';


class TextFieldView extends StatefulWidget {

  const TextFieldView(
      {super.key,
      required this.controller,
      required this.focusNode,
      required this.onChanged,
      required this.onSubmitted,
      this.keyboardType = TextInputType.text,
      this.placeholder,
      this.suffix});

  final TextEditingController controller;
  final FocusNode focusNode;
  final TextInputType keyboardType;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final String? placeholder;
  final Widget? suffix;

  @override
  State<TextFieldView> createState() => _TextFieldViewState();
}

class _TextFieldViewState extends State<TextFieldView> {
  final ValueNotifier<bool> _myFocusNotifier = ValueNotifier<bool>(false);
  FocusNode get _focusNode => widget.focusNode;
  TextEditingController get _controller => widget.controller;
  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    _myFocusNotifier.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    _myFocusNotifier.value = _controller.text.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: _myFocusNotifier,
        builder: (_, isFocus, child) {
          return TextField(
            keyboardType: widget.keyboardType,
            focusNode: _focusNode,
            controller: _controller,
            onChanged: widget.onChanged,
            onSubmitted: widget.onSubmitted,
            decoration: InputDecoration(
              filled: isFocus ? false : true,
              suffixIconConstraints: const BoxConstraints(maxHeight: 20),
              suffixIcon: widget.suffix,
              focusColor: Colors.white,
              hintText: widget.placeholder,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: isFocus
                      ? const BorderSide(color: AppColor.orangeI)
                      : const BorderSide(color: AppColor.grayII)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: const BorderSide(color: AppColor.orangeI)),
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(13),
                  borderSide: const BorderSide(color: AppColor.redI)),
            ),
          );
        });
  }
}
