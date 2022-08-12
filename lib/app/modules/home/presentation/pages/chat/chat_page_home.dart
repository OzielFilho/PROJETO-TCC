import '../../../../../core/utils/colors/colors_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../core/theme/theme_app.dart';
import 'chat_conversation_home_page.dart';
import 'chat_list_home_page.dart';

class ChatPageHome extends StatefulWidget {
  final List<String> contacts;
  final String tokenId;
  ChatPageHome({Key? key, required this.contacts, required this.tokenId})
      : super(key: key);

  @override
  State<ChatPageHome> createState() => _ChatPageHomeState();
}

class _ChatPageHomeState extends State<ChatPageHome>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Modular.to.pop(),
            icon: Icon(Icons.arrow_back_ios)),
        title: Text(
          'Chat',
          style: ThemeApp.theme.textTheme.headline3,
        ),
        centerTitle: true,
        bottom: TabBar(
          indicatorWeight: 4,
          labelStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          controller: _tabController,
          indicatorColor: ColorUtils.whiteColor,
          tabs: <Widget>[
            Tab(
              text: "Conversas",
            ),
            Tab(
              text: "Contatos",
            )
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          ChatConversationHomePage(tokenId: widget.tokenId),
          ChatListHomePage(contacts: widget.contacts, tokenId: widget.tokenId)
        ],
      ),
    );
  }
}
