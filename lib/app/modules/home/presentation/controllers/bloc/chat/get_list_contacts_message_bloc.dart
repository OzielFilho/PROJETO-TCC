import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../../core/presentation/controller/app_state.dart';
import '../../../../domain/usecases/chat/get_list_contacts_message.dart';
import '../../events/home_event.dart';

class GetListContactsMessageBloc extends Bloc<HomeEvent, AppState>
    implements Disposable {
  final GetListContactsMessage _usecase;
  GetListContactsMessageBloc(this._usecase) : super(InitialState()) {
    on<GetListContactsMessageEvent>(_onGetListContactsMessage);
  }
  Stream<List>? streamGetList;

  _onGetListContactsMessage(
      GetListContactsMessageEvent event, Emitter<AppState> emit) {
    emit(ProcessingState());

    if (event.tokenId.isEmpty) {
      emit(ErrorState('Não foi possível carregar os dados do usuário'));
    }

    final result = _usecase.call(event.tokenId);
    streamGetList = result;

    emit(SuccessGetListContactMessageState());
  }

  @override
  void dispose() {
    close();
  }
}
