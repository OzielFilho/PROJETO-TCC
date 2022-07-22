import 'package:app/app/core/presentation/widgets/buttons_design.dart';
import 'package:app/app/core/presentation/widgets/form_desing.dart';
import 'package:app/app/core/theme/theme_app.dart';
import 'package:app/app/core/utils/colors/colors_utils.dart';
import 'package:app/app/modules/auth/presentation/controllers/login_controller/login_event.dart';
import 'package:app/app/modules/auth/presentation/controllers/login_controller/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../controllers/login_controller/login_bloc.dart';

class LoginAppWidget extends StatefulWidget {
  const LoginAppWidget({Key? key}) : super(key: key);

  @override
  State<LoginAppWidget> createState() => _LoginAppWidgetState();
}

class _LoginAppWidgetState extends State<LoginAppWidget> {
  final TextEditingController _emailController = TextEditingController();
  final _loginBloc = Modular.get<LoginBloc>();

  final TextEditingController _passwordController = TextEditingController();

  bool _visibility = true;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, AppState>(
      bloc: _loginBloc,
      listener: (context, state) {
        if (state is SuccessState) {
          //NAVIGATE
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () => Modular.to.pop(),
              icon: Icon(Icons.arrow_back_ios_new_outlined),
            ),
          ),
          body: SingleChildScrollView(
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Insira suas Credenciais',
                        style: ThemeApp.theme.textTheme.headline1),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.3,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.contain,
                            image:
                                AssetImage('assets/images/login_woman.png'))),
                  ),
                  FormsDesign.textFormCustom(
                    Icon(
                      Icons.person_outline,
                      color: ColorUtils.whiteColor,
                    ),
                    null,
                    'Email',
                    visibility: false,
                    controller: _emailController,
                  ),
                  FormsDesign.textFormCustom(
                    null,
                    IconButton(
                        onPressed: () {
                          setState(() {
                            _visibility = !_visibility;
                          });
                        },
                        icon: Icon(
                          _visibility
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: ColorUtils.whiteColor,
                        )),
                    'Senha',
                    visibility: _visibility,
                    controller: _passwordController,
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
                  ButtonsDesign.buttonDefault(
                      text: 'Entrar',
                      action: () {
                        if (!(state is ProcessingState)) {
                          _loginBloc.add(LoginWithEmailAndPasswordEvent(
                              email: _emailController.text,
                              password: _passwordController.text));
                        }
                      }),
                  if (state is ProcessingState) ...[
                    CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(ColorUtils.whiteColor),
                    )
                  ],
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Esqueceu a senha?',
                        style: ThemeApp.theme.textTheme.overline,
                      ),
                      TextButton(
                          onPressed: () {},
                          child: Text(
                            'Clique aqui e recupere',
                            style: ThemeApp.theme.textTheme.caption,
                          )),
                    ],
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 12.0),
                              width: 80,
                              height: 1,
                              color: ColorUtils.whiteColor,
                            ),
                            Text(
                              'Ou entre com outras opções',
                              style: ThemeApp.theme.textTheme.overline,
                            ),
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 12.0),
                              width: 80,
                              height: 1,
                              color: ColorUtils.whiteColor,
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 15,
                              backgroundColor: ColorUtils.transparentColor,
                              backgroundImage:
                                  AssetImage('assets/images/google_icon.png'),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Text(
                              'Entre com sua conta Google',
                              style: ThemeApp.theme.textTheme.caption,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
