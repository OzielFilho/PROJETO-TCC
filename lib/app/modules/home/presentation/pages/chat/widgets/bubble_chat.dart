import '../../../../../../core/theme/theme_app.dart';
import '../../../../../../core/utils/colors/colors_utils.dart';
import 'package:flutter/material.dart';

class BubbleChat extends StatelessWidget {
  final String message;
  final Color color;
  const BubbleChat({Key? key, required this.message, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .42,
      padding: const EdgeInsets.all(4.0),
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(25), color: color),
      child: Text(
        message,
        textAlign: TextAlign.right,
        maxLines: 10,
        overflow: TextOverflow.ellipsis,
        style: ThemeApp.theme.textTheme.subtitle1!
            .copyWith(color: ColorUtils.primaryColor),
      ),
    );
  }
}
