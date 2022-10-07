import '../../../../domain/usecases/chat/send_message_emergence_with_chat.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../../core/error/failure.dart';
import '../../../../../../core/presentation/controller/app_state.dart';
import '../../events/home_event.dart';

class SendMessageEmergenceWithChatBloc extends Bloc<HomeEvent, AppState>
    implements Disposable {
  final SendMessageEmergenceWithChat _usecase;
  SendMessageEmergenceWithChatBloc(this._usecase) : super(InitialState()) {
    on<SendMessageEmergenceWithChatEvent>(_onSendMessageEmergenceWithChat);
  }

  _onSendMessageEmergenceWithChat(
      SendMessageEmergenceWithChatEvent event, Emitter<AppState> emit) async {
    emit(ProcessingState());

    final result = await _usecase.call(Params(
        idTokenUser: event.tokenId,
        contacts: event.contacts,
        position: event.position));

    emit(result.fold((failure) {
      switch (failure.runtimeType) {
        case NetworkFailure:
          return NetworkErrorState('Sem conexão com a internet');
        case ParamsEmptyFailure:
          return EmptyParamsErrorState('A lista está vazia');
        default:
          return SendMessageEmergenceWithChatErrorState(
              'Não foi enviar a mensagem');
      }
    }, (success) => SuccessSendMessageEmergenceWithChatState()));
  }

  @override
  void dispose() => close();
}
