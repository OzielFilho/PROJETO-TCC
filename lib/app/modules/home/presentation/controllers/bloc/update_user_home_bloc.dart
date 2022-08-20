import 'dart:async';
import 'dart:io';

import 'package:app/app/core/error/failure.dart';
import 'package:app/app/core/presentation/controller/app_state.dart';
import 'package:app/app/core/services/firestorage_service.dart';
import 'package:app/app/modules/home/domain/usecases/update_user_home.dart';
import 'package:app/app/modules/home/presentation/controllers/events/home_event.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class UpdateUserHomeBloc extends Bloc<HomeEvent, AppState>
    implements Disposable {
  final UpdateUserHome _updateUserHome;
  final FirestorageService _storage;
  UpdateUserHomeBloc(this._updateUserHome, this._storage)
      : super(InitialState()) {
    on<UpdateUserHomeEvent>(_onUpdateUserHome);
  }
  _onUpdateUserHome(UpdateUserHomeEvent event, Emitter<AppState> emit) async {
    emit(ProcessingState());
    final result = await _updateUserHome.call(event.user);

    emit(result.fold((failure) {
      switch (failure.runtimeType) {
        case ParamsEmptyFailure:
          return EmptyParamsErrorState('O seu nome não pode está vazio');
        default:
          return ErrorState('Não foi possível atualizar o usuário');
      }
    }, (success) => SuccessUpdateUserState()));
  }

  Future<String> saveFile(File file, String tokenId) async {
    await _storage.saveArchive(path: 'image_user/$tokenId.jpg', data: file);
    final result = await _storage.getArchive(path: 'image_user/$tokenId.jpg');
    return result;
  }

  @override
  void dispose() => close();
}
