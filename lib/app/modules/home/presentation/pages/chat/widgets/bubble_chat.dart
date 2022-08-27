import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher_string.dart';

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
      width: MediaQuery.of(context).size.width * .45,
      padding: const EdgeInsets.all(6.0),
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(25), color: color),
      child: message.contains("http")
          ? Linkify(
              onOpen: _onOpen,
              textScaleFactor: 1,
              textAlign: TextAlign.right,
              maxLines: 10,
              textDirection: TextDirection.rtl,
              overflow: TextOverflow.ellipsis,
              style: ThemeApp.theme.textTheme.subtitle1!
                  .copyWith(color: ColorUtils.primaryColor),
              linkStyle: ThemeApp.theme.textTheme.subtitle1!.copyWith(
                  color: ColorUtils.primaryColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  decoration: TextDecoration.underline),
              text: message,
            )
          : Text(
              message,
              textAlign: TextAlign.right,
              maxLines: 10,
              overflow: TextOverflow.ellipsis,
              style: ThemeApp.theme.textTheme.subtitle1!
                  .copyWith(color: ColorUtils.primaryColor),
            ),
    );
  }

  Future<void> _onOpen(LinkableElement link) async =>
      await launchUrlString(link.url);
}
