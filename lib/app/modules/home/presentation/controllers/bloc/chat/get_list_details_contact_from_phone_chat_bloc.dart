import 'package:bloc/bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../../core/error/failure.dart';
import '../../../../../../core/presentation/controller/app_state.dart';
import '../../../../domain/entities/details_contact_chat.dart';
import '../../../../domain/usecases/chat/get_list_details_contact_from_phone_chat.dart';
import '../../events/home_event.dart';

class GetListDetailsContactFromPhoneChatBloc extends Bloc<HomeEvent, AppState>
    implements Disposable {
  final GetListDetailsContactFromPhoneChat _usecase;
  GetListDetailsContactFromPhoneChatBloc(this._usecase)
      : super(InitialState()) {
    on<GetListDetailsContactFromPhoneChatEvent>(
        _onGetListDetailsContactFromPhoneChatHome);
  }
  List<DetailsContactChat>? contacts;
  _onGetListDetailsContactFromPhoneChatHome(
      GetListDetailsContactFromPhoneChatEvent event,
      Emitter<AppState> emit) async {
    emit(ProcessingState());
    if (event.contacts.isEmpty) {
      emit(ListContactsErrorState(
          'Você não possuí contatos para iniciar um chat'));
      return;
    }
    final result = await _usecase.call(event.contacts);
    emit(result.fold((failure) {
      switch (failure.runtimeType) {
        case NetworkFailure:
          return NetworkErrorState('Sem conexão com a internet');
        default:
          return GetListContactsErrorState(
              'Não foi carregar a lista de contatos');
      }
    }, (success) {
      if (success.isEmpty) {
        return ListContactsErrorState(
            'Você não possuí contatos para iniciar um chat');
      }
      contacts = success;
      return SuccessGetListDetailsContactFromPhoneChatState();
    }));
  }

  @override
  void dispose() {
    close();
  }
}
