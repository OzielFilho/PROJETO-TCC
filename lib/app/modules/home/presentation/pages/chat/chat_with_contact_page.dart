import '../../../../../core/utils/functions_utils.dart';
import '../../../../../core/utils/widgets_utils.dart';
import '../../controllers/bloc/chat/send_message_user_bloc.dart';

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
  final String photoUser;
  final String photoContact;
  ChatWithContactPage({
    Key? key,
    required this.name,
    required this.tokenIdUser,
    required this.tokenIdContact,
    required this.photoUser,
    required this.photoContact,
  }) : super(key: key);

  @override
  State<ChatWithContactPage> createState() => _ChatWithContactPageState();
}

class _ChatWithContactPageState extends State<ChatWithContactPage> {
  final _blocChatListUser = Modular.get<GetListMessageChatUserBloc>();

  ScrollController _controller = ScrollController();
  final _messageController = TextEditingController();
  final _sendMessageBloc = Modular.get<SendMessageUserBloc>();
  _sendToLastElement() {
    Future.delayed(Duration(milliseconds: 100), () {
      _controller.animateTo(
          _controller.position.maxScrollExtent +
              MediaQuery.of(context).size.height * 0.85,
          duration: Duration(milliseconds: 500),
          curve: Curves.decelerate);
    });
  }

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
                    _sendToLastElement();
                    if (!snapshot.hasData) {
                      return Center(child: LoadingDesign());
                    }
                    if (snapshot.hasData) {
                      return Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          snapshot.data!.isNotEmpty
                              ? Center(
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: 12.0,
                                        right: 12.0,
                                        top: 12.0,
                                        bottom:
                                            MediaQuery.of(context).size.height *
                                                .08),
                                    child: ListView.builder(
                                      controller: _controller,
                                      physics: BouncingScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        bool isContact =
                                            snapshot.data![index].tokenId ==
                                                widget.tokenIdContact;

                                        return Container(
                                          alignment: isContact
                                              ? Alignment.centerLeft
                                              : Alignment.centerRight,
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 12.0),
                                          child: BubbleChat(
                                            message: snapshot.data![index].text,
                                            color: isContact
                                                ? ColorUtils.whiteColor
                                                : ColorUtils.whiteColor
                                                    .withOpacity(0.7),
                                          ),
                                        );
                                      },
                                      itemCount: snapshot.data!.length,
                                      shrinkWrap: true,
                                    ),
                                  ),
                                )
                              : Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Center(
                                      child: Text(
                                    'Você não possui mensagens com esse usuário. Inicie enviado uma mensagem',
                                    style: ThemeApp.theme.textTheme.subtitle1,
                                    textAlign: TextAlign.center,
                                  )),
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
                              suffixIcon:
                                  BlocConsumer<SendMessageUserBloc, AppState>(
                                bloc: _sendMessageBloc,
                                listener: (context, state) {
                                  if (state is ErrorState) {
                                    WidgetUtils.showSnackBar(
                                        context, state.message!,
                                        actionText: 'Fechar', onTap: () {
                                      Modular.to.pop(context);
                                    });
                                  }
                                  if (state
                                      is SuccessSendMessageUserChatState) {
                                    _messageController.clear();
                                    FocusScope.of(context).unfocus();
                                  }
                                  if (state is NetworkErrorState) {
                                    WidgetUtils.showOkDialog(
                                        context,
                                        'Internet Indisponível',
                                        state.message!,
                                        'Reload', () {
                                      Modular.to.pop(context);
                                    }, permanentDialog: false);
                                  }
                                },
                                builder: (context, state) {
                                  if (state is ProcessingState) {
                                    return Center(
                                      child: LoadingDesign(),
                                    );
                                  }

                                  return SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.25,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        IconButton(
                                          icon: Icon(
                                            Icons.location_on_outlined,
                                            color: ColorUtils.primaryColor,
                                          ),
                                          onPressed: () async {
                                            FocusScope.of(context).unfocus();
                                            if (!(state is ProcessingState)) {
                                              _sendMessageBloc.add(SendMessageToUserEvent(
                                                  photo: widget.photoContact,
                                                  message: MessageChat(
                                                      date: DateTime.now()
                                                          .toUtc()
                                                          .toString(),
                                                      text: FunctionUtils
                                                          .currentLocationMessage(
                                                              await FunctionUtils
                                                                  .getLocation()),
                                                      tokenId:
                                                          widget.tokenIdUser),
                                                  tokenIdContact:
                                                      widget.tokenIdContact,
                                                  tokenIdUser:
                                                      widget.tokenIdUser,
                                                  name: widget.name));
                                              _sendMessageBloc.add(SendMessageToUserEvent(
                                                  photo: widget.photoUser,
                                                  message: MessageChat(
                                                      date: DateTime.now()
                                                          .toUtc()
                                                          .toString(),
                                                      text: FunctionUtils
                                                          .currentLocationMessage(
                                                              await FunctionUtils
                                                                  .getLocation()),
                                                      tokenId:
                                                          widget.tokenIdUser),
                                                  tokenIdContact:
                                                      widget.tokenIdUser,
                                                  tokenIdUser:
                                                      widget.tokenIdContact,
                                                  name: widget.name));
                                              if (snapshot.data!.isEmpty) {
                                                _blocChatListUser.add(
                                                    GetListMessageChatUserEvent(
                                                        tokenIdUser:
                                                            widget.tokenIdUser,
                                                        tokenIdContact: widget
                                                            .tokenIdContact));
                                              }
                                            }
                                          },
                                        ),
                                        IconButton(
                                          icon: Icon(
                                            Icons.arrow_forward_outlined,
                                            color: ColorUtils.primaryColor,
                                          ),
                                          onPressed: () {
                                            FocusScope.of(context).unfocus();
                                            if (!(state is ProcessingState)) {
                                              _sendMessageBloc.add(
                                                  SendMessageToUserEvent(
                                                      photo:
                                                          widget.photoContact,
                                                      message: MessageChat(
                                                          date: DateTime.now()
                                                              .toUtc()
                                                              .toString(),
                                                          text:
                                                              _messageController
                                                                  .text,
                                                          tokenId: widget
                                                              .tokenIdUser),
                                                      tokenIdContact:
                                                          widget.tokenIdContact,
                                                      tokenIdUser:
                                                          widget.tokenIdUser,
                                                      name: widget.name));
                                              _sendMessageBloc.add(
                                                  SendMessageToUserEvent(
                                                      photo: widget.photoUser,
                                                      message: MessageChat(
                                                          date: DateTime.now()
                                                              .toUtc()
                                                              .toString(),
                                                          text:
                                                              _messageController
                                                                  .text,
                                                          tokenId: widget
                                                              .tokenIdUser),
                                                      tokenIdContact:
                                                          widget.tokenIdUser,
                                                      tokenIdUser:
                                                          widget.tokenIdContact,
                                                      name: widget.name));
                                              if (snapshot.data!.isEmpty) {
                                                _blocChatListUser.add(
                                                    GetListMessageChatUserEvent(
                                                        tokenIdUser:
                                                            widget.tokenIdUser,
                                                        tokenIdContact: widget
                                                            .tokenIdContact));
                                              }
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                              borderRadius: 35,
                              title: 'Insira uma mensagem',
                              visibility: false,
                              controller: _messageController,
                            ),
                          ),
                        ],
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
