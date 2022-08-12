import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../theme/theme_app.dart';
import '../../utils/colors/colors_utils.dart';

class FormsDesign extends StatelessWidget {
  final Widget? suffixIcon;
  final String? title;
  final int? maxLen;
  final List<TextInputFormatter>? formatter;
  final TextInputType type;
  final double borderRadius;
  final TextEditingController controller;
  final bool visibility;
  final Widget? prefixIcon;
  final bool filled;
  FormsDesign(
      {Key? key,
      this.suffixIcon,
      this.formatter,
      this.prefixIcon,
      this.title,
      required this.controller,
      this.visibility = false,
      this.maxLen,
      this.type = TextInputType.text,
      this.borderRadius = 12,
      this.filled = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        textAlignVertical: TextAlignVertical.top,
        cursorColor: ColorUtils.secondaryColor,
        style: ThemeApp.theme.textTheme.overline!.copyWith(
            color: filled ? ColorUtils.secondaryColor : ColorUtils.whiteColor),
        maxLength: maxLen,
        inputFormatters: formatter ?? [],
        keyboardType: type,
        controller: controller,
        obscureText: visibility,
        decoration: InputDecoration(
          filled: filled,
          fillColor: ColorUtils.whiteColor,
          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: new BorderSide(color: ColorUtils.whiteColor)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: new BorderSide(color: ColorUtils.whiteColor)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: new BorderSide(color: ColorUtils.whiteColor)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: new BorderSide(color: ColorUtils.whiteColor)),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: new BorderSide(color: ColorUtils.whiteColor)),
          prefixIcon: prefixIcon,
          prefixIconColor: ColorUtils.whiteColor,
          hintStyle: ThemeApp.theme.textTheme.overline!.copyWith(
              color:
                  filled ? ColorUtils.secondaryColor : ColorUtils.whiteColor),
          labelStyle: ThemeApp.theme.textTheme.overline!.copyWith(
              color:
                  filled ? ColorUtils.secondaryColor : ColorUtils.whiteColor),
          errorStyle: ThemeApp.theme.textTheme.overline!.copyWith(
              color:
                  filled ? ColorUtils.secondaryColor : ColorUtils.whiteColor),
          floatingLabelBehavior: FloatingLabelBehavior.never,
          suffixIcon: suffixIcon,
          labelText: title,
        ),
      ),
    );
  }
}
