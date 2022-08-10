import 'package:app/app/modules/home/presentation/controllers/bloc/get_list_details_contact_from_phone_chat_bloc.dart';
import 'package:app/app/modules/home/presentation/controllers/events/home_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../core/presentation/controller/app_state.dart';
import '../../../../core/presentation/widgets/loading_desing.dart';
import '../../../../core/theme/theme_app.dart';

class ChatListHomePage extends StatefulWidget {
  final List<String> contacts;
  const ChatListHomePage({Key? key, required this.contacts}) : super(key: key);

  @override
  State<ChatListHomePage> createState() => _ChatListHomePageState();
}

class _ChatListHomePageState extends State<ChatListHomePage> {
  final _blocGetContacts =
      Modular.get<GetListDetailsContactFromPhoneChatBloc>();

  @override
  void initState() {
    _blocGetContacts.add(
        GetListDetailsContactFromPhoneChatEvent(contacts: widget.contacts));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<GetListDetailsContactFromPhoneChatBloc, AppState>(
          bloc: _blocGetContacts,
          builder: (context, state) {
            if (state is ProcessingState) {
              return Center(child: LoadingDesign());
            }
            if (state is ErrorState) {
              return AnimatedContainer(
                duration: Duration(seconds: 5),
                alignment: Alignment.center,
                curve: Curves.ease,
                child: Text(
                  state.message!,
                  style: ThemeApp.theme.textTheme.subtitle1,
                ),
              );
            }
            if (state is SuccessGetListDetailsContactFromPhoneChatState) {
              return Container(
                  padding: const EdgeInsets.all(12.0),
                  child: ListView.builder(
                    itemBuilder: (context, index) => InkWell(
                      onTap: () =>
                          Modular.to.pushNamed('chat_conversation_home'),
                      child: Container(
                          child: ListTile(
                        leading: CircleAvatar(),
                        subtitle: Text(
                          '${_blocGetContacts.contacts![index].email}',
                          style: ThemeApp.theme.textTheme.subtitle1,
                        ),
                        title: Text(
                          '${_blocGetContacts.contacts![index].name}',
                          style: ThemeApp.theme.textTheme.headline2,
                        ),
                      )),
                    ),
                    itemCount: _blocGetContacts.contacts!.length,
                    shrinkWrap: true,
                  ));
            }
            return Center(child: LoadingDesign());
          }),
    );
  }
}
