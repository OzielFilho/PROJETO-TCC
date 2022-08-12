import 'package:flutter/material.dart';

import '../../theme/theme_app.dart';
import '../../utils/colors/colors_utils.dart';

class ButtonDesign extends StatelessWidget {
  final String text;
  final VoidCallback action;
  final Widget? content;

  const ButtonDesign(
      {Key? key, required this.text, required this.action, this.content})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: action,
      color: ColorUtils.whiteColor,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (content != null) ...[
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: content)
          ],
          Text(
            text,
            style: ThemeApp.theme.textTheme.button,
          ),
        ],
      ),
    );
  }
}
