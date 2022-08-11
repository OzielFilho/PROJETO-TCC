import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../core/theme/theme_app.dart';

class ChatWithContactPage extends StatefulWidget {
  final String name;
  final String tokenId;
  ChatWithContactPage({Key? key, required this.name, required this.tokenId})
      : super(key: key);

  @override
  State<ChatWithContactPage> createState() => _ChatWithContactPageState();
}

class _ChatWithContactPageState extends State<ChatWithContactPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      leading: IconButton(
          onPressed: () => Modular.to.pop(), icon: Icon(Icons.arrow_back_ios)),
      title: Text(
        widget.name,
        style: ThemeApp.theme.textTheme.headline3,
      ),
      centerTitle: true,
    ));
  }
}
