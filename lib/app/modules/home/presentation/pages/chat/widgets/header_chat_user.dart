import '../../../../../../core/utils/colors/colors_utils.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/theme/theme_app.dart';

class HeaderChatUser extends StatelessWidget {
  final String title;
  final String? image;
  final String body;

  const HeaderChatUser({
    Key? key,
    required this.title,
    this.image,
    required this.body,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: ColorUtils.secondaryColor,
        backgroundImage: image != null && image!.isNotEmpty
            ? NetworkImage(image!)
            : AssetImage('assets/images/icon.png') as ImageProvider,
      ),
      subtitle: Text(
        body,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: ThemeApp.theme.textTheme.subtitle1,
      ),
      title: Text(
        title,
        style: ThemeApp.theme.textTheme.headline2,
      ),
    );
  }
}
