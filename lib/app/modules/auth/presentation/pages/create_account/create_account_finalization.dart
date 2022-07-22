import 'package:app/app/core/presentation/controller/app_state.dart';
import 'package:app/app/modules/auth/domain/entities/user_create.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../core/presentation/widgets/buttons_design.dart';
import '../../../../../core/presentation/widgets/form_desing.dart';
import '../../../../../core/presentation/widgets/loading_desing.dart';
import '../../../../../core/theme/theme_app.dart';
import '../../controllers/create_account_controller/create_account_bloc.dart';
import '../../controllers/create_account_controller/create_account_event.dart';

class CreateAccountFinalization extends StatefulWidget {
  final UserCreate userCreate;
  const CreateAccountFinalization({Key? key, required this.userCreate})
      : super(key: key);

  @override
  State<CreateAccountFinalization> createState() =>
      _CreateAccountFinalizationState();
}

class _CreateAccountFinalizationState extends State<CreateAccountFinalization> {
  final _phoneControllerNew = TextEditingController();
  final _registeAccountBloc =
      Modular.get<CreateAccountWithEmailAndPasswordBloc>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateAccountWithEmailAndPasswordBloc, AppState>(
      bloc: _registeAccountBloc,
      listener: (context, state) {
        if (state is SuccessState) {
          Modular.to.pushReplacementNamed('/home/');
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(leading: SizedBox()),
          body: SingleChildScrollView(
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                        'Precisamos de outros dados para concluir o cadastro',
                        style: ThemeApp.theme.textTheme.headline1),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 54.0),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Insira Seu Telefone',
                              style: ThemeApp.theme.textTheme.subtitle1),
                        ),
                        FormsDesign(
                          prefixIcon: null,
                          suffixIcon: null,
                          title: 'ex: (xx) xxxxx.xxxx',
                          visibility: false,
                          controller: _phoneControllerNew,
                        ),
                        if (state is ErrorState) ...[
                          AnimatedContainer(
                            duration: Duration(seconds: 5),
                            curve: Curves.ease,
                            child: Text(
                              state.message!,
                              style: ThemeApp.theme.textTheme.subtitle1,
                            ),
                          )
                        ],
                        ButtonDesign(
                            text: 'Criar Conta',
                            action: () {
                              if (!(state is ProcessingState)) {
                                _registeAccountBloc.add(
                                    CreateAccountWithEmailAndPasswordEvent(
                                        widget.userCreate.email!,
                                        widget.userCreate.password!,
                                        _phoneControllerNew.text));
                              }
                            }),
                        if (state is ProcessingState) ...[
                          LoadingDesign(),
                        ],
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
