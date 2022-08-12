import '../../../../../core/presentation/controller/app_state.dart';
import '../../../../../core/presentation/widgets/form_desing.dart';
import '../../../../../core/utils/colors/colors_utils.dart';
import '../../../domain/entities/message_chat.dart';
import '../../controllers/events/home_event.dart';
import 'widgets/bubble_chat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../core/presentation/widgets/loading_desing.dart';
import '../../../../../core/theme/theme_app.dart';
import '../../controllers/bloc/chat/get_list_message_chat_user_bloc.dart';

class ChatWithContactPage extends StatefulWidget {
  final String name;
  final String tokenIdUser;
  final String tokenIdContact;
  ChatWithContactPage({
    Key? key,
    required this.name,
    required this.tokenIdUser,
    required this.tokenIdContact,
  }) : super(key: key);

  @override
  State<ChatWithContactPage> createState() => _ChatWithContactPageState();
}

class _ChatWithContactPageState extends State<ChatWithContactPage> {
  final _blocChatListUser = Modular.get<GetListMessageChatUserBloc>();

  ScrollController _controller = ScrollController();
  final _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _blocChatListUser.add(GetListMessageChatUserEvent(
        tokenIdUser: widget.tokenIdUser,
        tokenIdContact: widget.tokenIdContact));
  }

  @override
  void dispose() {
    _blocChatListUser.streamGetList = Stream<List<MessageChat>>.empty();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () => Modular.to.pop(),
              icon: Icon(Icons.arrow_back_ios)),
          title: Text(
            widget.name,
            style: ThemeApp.theme.textTheme.headline3,
          ),
          centerTitle: true,
        ),
        body: BlocBuilder<GetListMessageChatUserBloc, AppState>(
            bloc: _blocChatListUser,
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
              if (state is SuccessGetListMessageChatUserState) {
                return StreamBuilder<List<MessageChat>>(
                  stream: _blocChatListUser.streamGetList,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(child: LoadingDesign());
                    }
                    if (snapshot.hasData) {
                      final result = snapshot.data!;

                      return Container(
                        height: MediaQuery.of(context).size.height,
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            SingleChildScrollView(
                              controller: _controller,
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: 12.0,
                                    right: 12.0,
                                    top: 12.0,
                                    bottom: MediaQuery.of(context).size.height *
                                        .08),
                                child: ListView.builder(
                                  controller: _controller,
                                  itemBuilder: (context, index) {
                                    bool isContact = result[index].tokenId ==
                                        widget.tokenIdContact;
                                    return Container(
                                      alignment: isContact
                                          ? Alignment.centerLeft
                                          : Alignment.centerRight,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 12.0),
                                      child: BubbleChat(
                                        message: result[index].text,
                                        color: isContact
                                            ? ColorUtils.whiteColor
                                            : ColorUtils.whiteColor
                                                .withOpacity(0.7),
                                      ),
                                    );
                                  },
                                  itemCount: result.length,
                                  shrinkWrap: true,
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.bottomCenter,
                              color: ColorUtils.primaryColor,
                              padding: const EdgeInsets.only(
                                  bottom: 6, left: 12.0, right: 12.0, top: 6.0),
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * .08,
                              child: FormsDesign(
                                prefixIcon: null,
                                filled: true,
                                suffixIcon: Icon(
                                  Icons.arrow_forward_outlined,
                                  color: ColorUtils.primaryColor,
                                ),
                                borderRadius: 35,
                                title: 'Insira uma mensagem',
                                visibility: false,
                                controller: _messageController,
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                    return Container();
                  },
                );
              }
              return Container();
            }));
  }
}
