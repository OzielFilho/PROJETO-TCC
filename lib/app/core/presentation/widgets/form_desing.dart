import 'package:flutter/services.dart';

import '../../theme/theme_app.dart';
import '../../utils/colors/colors_utils.dart';
import 'package:flutter/material.dart';

class FormsDesign extends StatelessWidget {
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? title;
  final int? maxLen;
  final List<TextInputFormatter>? formatter;
  final TextInputType type;
  final TextEditingController controller;
  final bool visibility;
  const FormsDesign(
      {Key? key,
      this.formatter,
      this.prefixIcon,
      this.suffixIcon,
      this.title,
      required this.controller,
      this.visibility = false,
      this.maxLen,
      this.type = TextInputType.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        maxLength: maxLen,
        inputFormatters: formatter ?? [],
        keyboardType: type,
        controller: controller,
        obscureText: visibility,
        decoration: InputDecoration(
          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: new BorderSide(color: ColorUtils.whiteColor)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: new BorderSide(color: ColorUtils.whiteColor)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: new BorderSide(color: ColorUtils.whiteColor)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: new BorderSide(color: ColorUtils.whiteColor)),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: new BorderSide(color: ColorUtils.whiteColor)),
          prefixIcon: prefixIcon,
          prefixIconColor: ColorUtils.whiteColor,
          hintStyle: ThemeApp.theme.textTheme.overline,
          labelStyle: ThemeApp.theme.textTheme.overline,
          errorStyle: ThemeApp.theme.textTheme.overline,
          floatingLabelStyle: ThemeApp.theme.textTheme.overline,
          suffixIcon: suffixIcon,
          labelText: title,
        ),
      ),
    );
  }
}
