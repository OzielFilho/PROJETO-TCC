import 'dart:async';

import '../../../../../../core/presentation/controller/app_state.dart';
import '../../events/home_event.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../domain/entities/message_chat.dart';
import '../../../../domain/usecases/chat/get_list_message_chat_user.dart';

class GetListMessageChatUserBloc extends Bloc<HomeEvent, AppState>
    implements Disposable {
  final GetListMessageChatUser _usecase;
  GetListMessageChatUserBloc(this._usecase) : super(InitialState()) {
    on<GetListMessageChatUserEvent>(_onGetListContactsMessage);
  }
  Stream<List<MessageChat>>? streamGetList;

  _onGetListContactsMessage(
      GetListMessageChatUserEvent event, Emitter<AppState> emit) async {
    streamGetList = Stream<List<MessageChat>>.empty();
    emit(ProcessingState());

    if (event.tokenIdContact.isEmpty || event.tokenIdUser.isEmpty) {
      emit(ErrorState('Não foi possível carregar as mensagens'));
    }
    await Future.delayed(Duration(seconds: 1));

    final result = _usecase.call(event.tokenIdUser, event.tokenIdContact);
    streamGetList = result;

    emit(SuccessGetListMessageChatUserState());
  }

  @override
  void dispose() {
    close();
  }
}
