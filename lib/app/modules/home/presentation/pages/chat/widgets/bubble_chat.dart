import 'package:app/app/core/theme/theme_app.dart';
import 'package:app/app/core/utils/colors/colors_utils.dart';
import 'package:flutter/material.dart';

class BubbleChat extends StatelessWidget {
  final String message;
  final Color color;
  const BubbleChat({Key? key, required this.message, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: MediaQuery.of(context).size.width * .45,
      padding: const EdgeInsets.all(8.0),
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(35), color: color),
      child: Text(
        message,
        textAlign: TextAlign.right,
        maxLines: 3,
        style: ThemeApp.theme.textTheme.subtitle1!
            .copyWith(color: ColorUtils.primaryColor),
      ),
    );
  }
}
