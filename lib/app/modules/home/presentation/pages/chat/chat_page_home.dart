import 'package:app/app/modules/home/presentation/controllers/bloc/get_user_home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../core/theme/theme_app.dart';
import '../../../../../core/utils/colors/colors_utils.dart';
import '../../controllers/events/home_event.dart';
import 'chat_conversation_home_page.dart';
import 'chat_list_home_page.dart';

class ChatPageHome extends StatefulWidget {
  final GetUserHomeBloc bloc;
  final List<String> contacts;
  final String tokenId;
  final String photoUser;
  ChatPageHome(
      {Key? key,
      required this.contacts,
      required this.tokenId,
      required this.photoUser,
      required this.bloc})
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
            onPressed: () {
              widget.bloc.add(GetUserHomeEvent());
              Modular.to.pop();
            },
            icon: Icon(Icons.arrow_back_ios)),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () => Modular.to.pushNamed('add_new_contact',
                  arguments: {'tokenId': widget.tokenId, 'bloc': widget.bloc}),
              child: Icon(
                Icons.add_call,
                color: ColorUtils.whiteColor,
              ),
            ),
          )
        ],
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
        physics: NeverScrollableScrollPhysics(),
        controller: _tabController,
        children: <Widget>[
          ChatConversationHomePage(
              tokenId: widget.tokenId, photo: widget.photoUser),
          ChatListHomePage(
            contacts: widget.contacts,
            tokenId: widget.tokenId,
            photo: widget.photoUser,
          )
        ],
      ),
    );
  }
}
