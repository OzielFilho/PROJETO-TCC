import 'dart:async';

import 'package:app/app/core/presentation/controller/app_state.dart';
import 'package:app/app/modules/home/domain/usecases/get_list_message_chat_user.dart';
import 'package:app/app/modules/home/presentation/controllers/events/home_event.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../domain/entities/message_chat.dart';

class GetListMessageChatUserBloc extends Bloc<HomeEvent, AppState>
    implements Disposable {
  final GetListMessageChatUser _usecase;
  GetListMessageChatUserBloc(this._usecase) : super(InitialState()) {
    on<GetListMessageChatUserEvent>(_onGetListContactsMessage);
  }
  Stream<List<MessageChat>>? streamGetList;

  _onGetListContactsMessage(
      GetListMessageChatUserEvent event, Emitter<AppState> emit) {
    emit(ProcessingState());

    if (event.tokenIdContact.isEmpty || event.tokenIdUser.isEmpty) {
      emit(ErrorState('Não foi possível carregar as mensagens'));
    }

    final result = _usecase.call(event.tokenIdUser, event.tokenIdContact);
    streamGetList = result;

    emit(SuccessGetListMessageChatUserState());
  }

  @override
  void dispose() {
    close();
  }
}
