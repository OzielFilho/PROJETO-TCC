import 'package:app/app/modules/home/presentation/controllers/bloc/get_list_details_contact_from_phone_chat_bloc.dart';
import 'package:app/app/modules/home/presentation/controllers/events/home_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../core/presentation/controller/app_state.dart';
import '../../../../core/presentation/widgets/loading_desing.dart';
import '../../../../core/theme/theme_app.dart';

class ChatHomePage extends StatefulWidget {
  final List<String> contacts;
  const ChatHomePage({Key? key, required this.contacts}) : super(key: key);

  @override
  State<ChatHomePage> createState() => _ChatHomePageState();
}

class _ChatHomePageState extends State<ChatHomePage> {
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
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Modular.to.pop(),
            icon: Icon(Icons.arrow_back_ios)),
        title: Text(
          'Chat',
          style: ThemeApp.theme.textTheme.headline3,
        ),
        centerTitle: true,
      ),
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
                child: Text('SuccessGetListDetailsContactFromPhoneChatState'),
              );
            }
            return Container(
              child: Text('Não deu bom'),
            );
          }),
    );
  }
}
