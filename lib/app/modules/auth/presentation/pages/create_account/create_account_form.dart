import 'package:app/app/modules/auth/domain/entities/user_create.dart';
import 'package:app/app/modules/auth/presentation/controllers/create_account_controller/create_account_form/create_account_form_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../core/presentation/controller/app_state.dart';
import '../../../../../core/presentation/widgets/buttons_design.dart';
import '../../../../../core/presentation/widgets/form_desing.dart';
import '../../../../../core/presentation/widgets/loading_desing.dart';
import '../../../../../core/theme/theme_app.dart';
import '../../controllers/create_account_controller/create_account_form/create_account_form_event.dart';

class CreateAccountForm extends StatefulWidget {
  const CreateAccountForm({Key? key}) : super(key: key);

  @override
  State<CreateAccountForm> createState() => _CreateAccountFormState();
}

class _CreateAccountFormState extends State<CreateAccountForm> {
  final _emailControllerNew = TextEditingController();
  final _nameControllerNew = TextEditingController();

  final _passwordControllerNew = TextEditingController();

  final _confirmPasswordControllerNew = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final _blocFormCreateAccount = Modular.get<CreateAccountFormBloc>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateAccountFormBloc, AppState>(
        bloc: _blocFormCreateAccount,
        listener: (context, state) {
          if (state is SuccessState) {
            Map<String, dynamic> args = {
              'userCreate': UserCreate(
                  email: _emailControllerNew.text,
                  name: _nameControllerNew.text,
                  password: _passwordControllerNew.text,
                  yourPhone: '')
            };
            Modular.to
                .pushNamed('create_account_finalization', arguments: args);
          }
        },
        builder: (context, state) {
          return Form(
              key: _formKey,
              child: Scaffold(
                  appBar: AppBar(
                      leading: IconButton(
                          onPressed: () => Modular.to.pop(),
                          icon: Icon(Icons.arrow_back_ios_new_outlined))),
                  body: SingleChildScrollView(
                      child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 12.0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text('Crie sua conta',
                                      style:
                                          ThemeApp.theme.textTheme.headline1),
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text('Insira suas credenciais',
                                      style:
                                          ThemeApp.theme.textTheme.subtitle1),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 54.0),
                                  child: Column(
                                    children: [
                                      FormsDesign(
                                        prefixIcon: null,
                                        suffixIcon: null,
                                        title: 'Nome',
                                        visibility: false,
                                        controller: _nameControllerNew,
                                      ),
                                      FormsDesign(
                                        prefixIcon: null,
                                        suffixIcon: null,
                                        title: 'Email',
                                        visibility: false,
                                        controller: _emailControllerNew,
                                      ),
                                      FormsDesign(
                                        prefixIcon: null,
                                        suffixIcon: null,
                                        title: 'Senha',
                                        visibility: false,
                                        controller: _passwordControllerNew,
                                      ),
                                      FormsDesign(
                                        prefixIcon: null,
                                        suffixIcon: null,
                                        title: 'Confirme a Senha',
                                        visibility: false,
                                        controller:
                                            _confirmPasswordControllerNew,
                                      ),
                                      if (state is ErrorState) ...[
                                        AnimatedContainer(
                                          duration: Duration(seconds: 5),
                                          curve: Curves.ease,
                                          child: Text(
                                            state.message!,
                                            style: ThemeApp
                                                .theme.textTheme.subtitle1,
                                          ),
                                        )
                                      ],
                                      ButtonDesign(
                                          text: 'Avançar',
                                          action: () {
                                            _blocFormCreateAccount.add(
                                                CreateAccountFormEvent(
                                                    confirmePassword:
                                                        _confirmPasswordControllerNew
                                                            .text,
                                                    email: _emailControllerNew
                                                        .text,
                                                    name:
                                                        _nameControllerNew.text,
                                                    password:
                                                        _passwordControllerNew
                                                            .text));
                                          }),
                                      if (state is ProcessingState) ...[
                                        LoadingDesign(),
                                      ],
                                    ],
                                  ),
                                ),
                              ])))));
        });
  }
}
