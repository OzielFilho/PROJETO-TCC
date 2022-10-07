import 'package:bloc/bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../../core/error/failure.dart';
import '../../../../../../core/presentation/controller/app_state.dart';
import '../../../../domain/usecases/chat/send_message_to_user.dart';
import '../../events/home_event.dart';

class SendMessageUserBloc extends Bloc<HomeEvent, AppState>
    implements Disposable {
  final SendMessageToUser _usecase;
  SendMessageUserBloc(this._usecase) : super(InitialState()) {
    on<SendMessageToUserEvent>(_onSendMessageToUser);
  }

  _onSendMessageToUser(
      SendMessageToUserEvent event, Emitter<AppState> emit) async {
    emit(ProcessingState());

    Params params = Params(
        photo: event.photo,
        idTokenContact: event.tokenIdContact,
        idTokenUser: event.tokenIdUser,
        message: event.message,
        name: event.name);
    final result = await _usecase.call(params);
    emit(result.fold((failure) {
      switch (failure.runtimeType) {
        case NetworkFailure:
          return NetworkErrorState('Sem conexão com a internet');
        default:
          return SendMessageToUserErrorState('Não foi enviar a mensagem');
      }
    }, (success) => SuccessSendMessageUserChatState()));
  }

  @override
  void dispose() {
    close();
  }
}
