import 'package:app/app/modules/home/domain/usecases/chat/add_new_contacts.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../../core/error/failure.dart';
import '../../../../../../core/presentation/controller/app_state.dart';
import '../../events/home_event.dart';

class AddNewContactsBloc extends Bloc<HomeEvent, AppState>
    implements Disposable {
  final AddNewContacts _usecase;
  AddNewContactsBloc(this._usecase) : super(InitialState()) {
    on<AddNewContactsEvent>(_onAddNewContacts);
  }

  @override
  void dispose() => close();

  _onAddNewContacts(AddNewContactsEvent event, Emitter<AppState> emit) async {
    emit(ProcessingState());

    final params = Params(event.tokenId, event.contacts);
    final result = await _usecase.call(params);

    emit(result.fold((failure) {
      switch (failure.runtimeType) {
        case NetworkFailure:
          return NetworkErrorState('Sem conexão com a internet');
        case ParamsInvalidFailure:
          return ParamsInvalidErrorState('Telefone Inválido');
        case ParamsEmptyFailure:
          return ParamsEmptyErrorState('Telefone não pode está vazio');
        default:
          return ErrorState('Não foi possível adicionar no momento');
      }
    }, (success) => SuccessAddNewContactsState()));
  }
}
