import '../../theme/theme_app.dart';
import '../../utils/colors/colors_utils.dart';
import 'package:flutter/material.dart';

class ButtonDesign extends StatelessWidget {
  final String text;
  final VoidCallback action;
  const ButtonDesign({Key? key, required this.text, required this.action})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: action,
      color: ColorUtils.whiteColor,
      child: Text(
        text,
        style: ThemeApp.theme.textTheme.button,
      ),
    );
  }
}
