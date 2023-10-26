import 'package:flutter/material.dart';

import '../constant/constant_view.dart';

class TextFormFiledWidget extends StatelessWidget {
  String hint;
  int maxLines;
  TextEditingController controller = TextEditingController();
  TextInputAction textInputAction;
  Function(String) validate;
  TextFormFiledWidget(
      {Key? key,
      required this.hint,
      required this.maxLines,
      required this.controller,
      required this.validate,
      required this.textInputAction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: TextStyle(color: Colors.white),
      maxLines: maxLines,
      textInputAction: textInputAction,
      validator: (value) {
        return validate(value.toString());
      },
      decoration: InputDecoration(
        hintText: "$hint",
        fillColor: Constants.textFiledColors.withOpacity(0.5),
        filled: true,
        hintStyle: TextStyle(color: Colors.white),
        border: OutlineInputBorder(borderRadius: BorderRadius.zero),
      ),
    );
  }
}
