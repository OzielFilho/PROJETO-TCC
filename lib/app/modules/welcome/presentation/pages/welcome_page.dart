import 'package:app/app/core/presentation/widgets/buttons_design.dart';
import 'package:app/app/core/presentation/widgets/form_desing.dart';
import 'package:app/app/core/utils/colors/colors_utils.dart';
import 'package:app/app/modules/welcome/presentation/controllers/bloc/update_user_create_bloc.dart';
import 'package:app/app/modules/welcome/presentation/controllers/bloc/user_phone_is_empty_bloc.dart';
import 'package:app/app/modules/welcome/presentation/controllers/event/welcome_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../../../core/presentation/controller/app_state.dart';
import '../../../../core/presentation/widgets/loading_desing.dart';
import '../../../../core/theme/theme_app.dart';
import '../../../../core/utils/constants/encrypt_data.dart';
import '../controllers/bloc/get_user_welcome_bloc.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final _getUserBloc = Modular.get<GetUserWelcomeBloc>();
  final _userPhoneEmptyBloc = Modular.get<UserPhoneIsEmptyBloc>();
  final _updateUserCreateBloc = Modular.get<UpdateUserCreateBloc>();
  List<String> _contactsText = [];
  _createNewForm() {
    _formsContacts.add(FormsDesign(
        controller: TextEditingController(),
        title: 'Insira um número',
        formatter: [_maskFormatter],
        suffixIcon: IconButton(
            onPressed: _createNewForm,
            icon: Icon(
              Icons.add,
              color: ColorUtils.whiteColor,
            ))));
    setState(() {});
  }

  List<FormsDesign> _formsContacts = [];

  final _controllerPhone = TextEditingController();

  var _maskFormatter = new MaskTextInputFormatter(
      mask: '(##)#####-####',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  @override
  void initState() {
    _createNewForm();
    _getUserBloc.add(GetUserEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetUserWelcomeBloc, AppState>(
      bloc: _getUserBloc,
      builder: (context, state) {
        if (state is ProcessingState) {
          return Scaffold(body: Center(child: LoadingDesign()));
        }

        if (state is ErrorState) {
          return Scaffold(
            body: AnimatedContainer(
              alignment: Alignment.center,
              duration: Duration(seconds: 5),
              curve: Curves.ease,
              child: Text(
                state.message!,
                style: ThemeApp.theme.textTheme.subtitle1,
              ),
            ),
          );
        }
        if (state is SuccessGetUserState) {
          return Scaffold(
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Bem-Vindo ao Shh!',
                      style: ThemeApp.theme.textTheme.headline1,
                    ),
                    Text(
                      'Você acaba de entrar no Shh! Preciso de ajuda!',
                      style: ThemeApp.theme.textTheme.subtitle1,
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Expanded(
                        child: PageView(
                      controller: _getUserBloc.controller,
                      children: [
                        BlocConsumer<UpdateUserCreateBloc, AppState>(
                            listener: (context, state) {
                              if (state is SuccessUpdateUserCreateState) {
                                Modular.to.pushReplacementNamed('/home/');
                              }
                            },
                            bloc: _updateUserCreateBloc,
                            builder: (context, stateUpdate) {
                              return SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Text(
                                      'Para continuar, insira seus telefones de confiança que serão utilizados para contato',
                                      style: ThemeApp.theme.textTheme.subtitle1,
                                    ),
                                    const SizedBox(
                                      height: 20.0,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: ListView.builder(
                                        controller: _updateUserCreateBloc
                                            .scrollController,
                                        shrinkWrap: true,
                                        itemCount: _formsContacts.length,
                                        physics: NeverScrollableScrollPhysics(),
                                        padding: const EdgeInsets.all(12.0),
                                        itemBuilder: (context, index) {
                                          return _formsContacts[index];
                                        },
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20.0,
                                    ),
                                    ButtonDesign(
                                        text: 'Finalizar Conta',
                                        action: () {
                                          _contactsText = _formsContacts
                                              .map((e) => e.controller.text)
                                              .toList();
                                          _updateUserCreateBloc.add(
                                              UpdateUserCreateEvent(
                                                  contacts: _contactsText,
                                                  email:
                                                      _getUserBloc.user!.email,
                                                  name: _getUserBloc.user!.name,
                                                  phone:
                                                      _getUserBloc.user!.phone,
                                                  welcomePage: !_getUserBloc
                                                      .user!.welcomePage));
                                        }),
                                    const SizedBox(
                                      height: 20.0,
                                    ),
                                    if (stateUpdate is ErrorState) ...[
                                      AnimatedContainer(
                                        duration: Duration(seconds: 5),
                                        curve: Curves.ease,
                                        child: Text(
                                          stateUpdate.message!,
                                          style: ThemeApp
                                              .theme.textTheme.subtitle1,
                                        ),
                                      )
                                    ],
                                  ],
                                ),
                              );
                            }),
                        BlocConsumer<UserPhoneIsEmptyBloc, AppState>(
                            listener: (context, state) {
                              if (state is SuccessState) {
                                _getUserBloc.user!.phone = EncryptData()
                                    .encrypty(_controllerPhone.text)
                                    .base16;
                                _getUserBloc.controller.nextPage(
                                    duration: Duration(milliseconds: 500),
                                    curve: Curves.bounceIn);
                              }
                            },
                            bloc: _userPhoneEmptyBloc,
                            builder: (context, event) {
                              return Column(
                                children: [
                                  Text(
                                    'Insira seu telefone',
                                    style: ThemeApp.theme.textTheme.subtitle1,
                                  ),
                                  const SizedBox(
                                    height: 20.0,
                                  ),
                                  FormsDesign(
                                      controller: _controllerPhone,
                                      formatter: [_maskFormatter],
                                      suffixIcon: Icon(
                                        Icons.phone_android,
                                        color: Colors.white,
                                      )),
                                  const SizedBox(
                                    height: 20.0,
                                  ),
                                  if (state is ErrorState) ...[
                                    AnimatedContainer(
                                      duration: Duration(seconds: 5),
                                      curve: Curves.ease,
                                      child: Text(
                                        state.message!,
                                        style:
                                            ThemeApp.theme.textTheme.subtitle1,
                                      ),
                                    )
                                  ],
                                  ButtonDesign(
                                      text: 'Continuar',
                                      action: () {
                                        _userPhoneEmptyBloc.add(
                                            PhoneIsEmptyEvent(
                                                phone: _controllerPhone.text));
                                      }),
                                ],
                              );
                            }),
                      ],
                    )),
                  ],
                ),
              ),
            ),
          );
        }
        return Scaffold(
          body: Container(),
        );
      },
    );
  }
}
