import 'package:app/app/core/presentation/widgets/form_desing.dart';
import 'package:app/app/modules/welcome/presentation/controllers/welcome_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../../../core/presentation/controller/app_state.dart';
import '../../../../core/presentation/widgets/loading_desing.dart';
import '../../../../core/theme/theme_app.dart';
import '../controllers/get_user_welcome_bloc.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final _getUserBloc = Modular.get<GetUserWelcomeBloc>();
  final _controllerPhone = TextEditingController();

  List<FormsDesign> _forms = [
    FormsDesign(
      controller: TextEditingController(),
    )
  ];
  var _maskFormatter = new MaskTextInputFormatter(
      mask: '(##)#####-####',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  @override
  void initState() {
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
            body: SingleChildScrollView(
              child: SafeArea(
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
                      if (_getUserBloc.user!.phone.isEmpty) ...[
                        Text(
                          'Insira seu telefone',
                          style: ThemeApp.theme.textTheme.subtitle1,
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
                      ],
                      Text(
                        'Para continuar, insira seus telefones de confiança que serão utilizados para contato',
                        style: ThemeApp.theme.textTheme.subtitle1,
                      ),
                    ],
                  ),
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
