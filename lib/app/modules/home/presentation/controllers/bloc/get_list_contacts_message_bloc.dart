import 'dart:async';

import 'package:app/app/core/presentation/controller/app_state.dart';
import 'package:app/app/modules/home/domain/usecases/get_list_contacts_message.dart';
import 'package:app/app/modules/home/presentation/controllers/events/home_event.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

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

    if (streamGetList == null) {
      emit(ErrorState('Não foi possível carregar os dados do usuário'));
    }

    emit(SuccessGetListContactMessageState());
  }

  @override
  void dispose() {
    close();
  }
}
