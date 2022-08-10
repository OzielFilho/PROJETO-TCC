import 'package:app/app/core/presentation/controller/app_state.dart';
import 'package:app/app/modules/home/domain/usecases/get_list_contacts_with_message_chat.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../core/error/failure.dart';
import '../../../domain/entities/contacts_with_message.dart';
import '../events/home_event.dart';

class GetListContactsWithMessageChatBloc extends Bloc<HomeEvent, AppState>
    implements Disposable {
  final GetListContactsWithMessageChat _usecase;
  GetListContactsWithMessageChatBloc(this._usecase) : super(InitialState()) {
    on<GetListContactsWithChatEvent>(_onGetListContactsWithMessageChat);
  }
  List<ContactsWithMessage>? listContacts;
  _onGetListContactsWithMessageChat(
      GetListContactsWithChatEvent event, Emitter<AppState> emit) async {
    emit(ProcessingState());
    final result = await _usecase.call(event.tokenId);

    emit(result.fold((failure) {
      switch (failure.runtimeType) {
        case IdTokenFailure:
          return EmptyParamsErrorState('Email ou Senha estão vazios');
        default:
          return ErrorState('Não foi possível carregar a lista de conversas');
      }
    }, (success) {
      listContacts = success;
      return SuccessGetListContactWithMessageChatState();
    }));
  }

  @override
  void dispose() {
    close();
  }
}
