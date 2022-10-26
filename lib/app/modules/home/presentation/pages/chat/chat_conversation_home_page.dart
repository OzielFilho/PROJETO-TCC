import '../../../../../core/utils/constants/encrypt_data.dart';
import 'widgets/header_chat_user.dart';

import '../../../../../core/presentation/controller/app_state.dart';
import '../../controllers/events/home_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../../../core/presentation/widgets/loading_desing.dart';
import '../../../../../core/theme/theme_app.dart';
import '../../../infra/models/contacts_with_message_model.dart';
import '../../controllers/bloc/chat/get_list_contacts_message_bloc.dart';

class ChatConversationHomePage extends StatefulWidget {
  final String tokenId;
  final String photo;
  final String nameUser;
  ChatConversationHomePage(
      {Key? key,
      required this.tokenId,
      required this.photo,
      required this.nameUser})
      : super(key: key);

  @override
  State<ChatConversationHomePage> createState() =>
      _ChatConversationHomePageState();
}

class _ChatConversationHomePageState extends State<ChatConversationHomePage> {
  final _blocGetListContactsMessage = Modular.get<GetListContactsMessageBloc>();

  @override
  void initState() {
    _blocGetListContactsMessage
        .add(GetListContactsMessageEvent(tokenId: widget.tokenId));
    super.initState();
  }

  @override
  void dispose() {
    _blocGetListContactsMessage.streamGetList = Stream<List>.empty();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: BlocBuilder<GetListContactsMessageBloc, AppState>(
            bloc: _blocGetListContactsMessage,
            builder: (context, state) {
              if (state is ProcessingState) {
                return Center(child: LoadingDesign());
              }
              if (state is ErrorState) {
                return AnimatedContainer(
                  duration: Duration(seconds: 5),
                  curve: Curves.ease,
                  child: Text(
                    state.message!,
                    style: ThemeApp.theme.textTheme.subtitle1,
                  ),
                );
              }
              if (state is SuccessGetListContactMessageState) {
                return StreamBuilder<List>(
                  stream: _blocGetListContactsMessage.streamGetList,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(child: LoadingDesign());
                    }

                    if (snapshot.hasData) {
                      final result = snapshot.data!
                          .map((contact) => contact as ContactsWithMessageModel)
                          .toList();

                      if (snapshot.data == null) {
                        return AnimatedContainer(
                          duration: Duration(seconds: 5),
                          curve: Curves.ease,
                          alignment: Alignment.center,
                          child: Text(
                            'Você não possui conversas no momento',
                            style: ThemeApp.theme.textTheme.subtitle1,
                          ),
                        );
                      }
                      if (snapshot.data!.isEmpty) {
                        return AnimatedContainer(
                          duration: Duration(seconds: 5),
                          curve: Curves.ease,
                          alignment: Alignment.center,
                          child: Text(
                            'Você não possui conversas no momento',
                            style: ThemeApp.theme.textTheme.subtitle1,
                          ),
                        );
                      }
                      return ListView.builder(
                        itemBuilder: (context, index) => InkWell(
                            onTap: () => Modular.to.pushNamed(
                                    'chat_with_contact_home',
                                    arguments: {
                                      'tokenIdContact': result[index].tokenId,
                                      'tokenIdUser': widget.tokenId,
                                      'photoContact': result[index].photo,
                                      'photoUser': widget.photo,
                                      'nameContact': result[index].name,
                                      'nameUser': widget.nameUser
                                    }),
                            child: HeaderChatUser(
                              title: '${result[index].name}',
                              body: '${result[index].messages.last.text}',
                              image: '${result[index].photo}',
                            )),
                        itemCount: result.length,
                        shrinkWrap: true,
                      );
                    }
                    return Container();
                  },
                );
              }
              return Center(child: LoadingDesign());
            },
          )),
    );
  }
}
