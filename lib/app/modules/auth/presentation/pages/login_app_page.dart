import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../core/presentation/controller/app_state.dart';
import '../../../../core/presentation/widgets/buttons_design.dart';
import '../../../../core/presentation/widgets/form_desing.dart';
import '../../../../core/presentation/widgets/loading_desing.dart';
import '../../../../core/theme/theme_app.dart';
import '../../../../core/utils/colors/colors_utils.dart';
import '../controllers/login_controller/login_bloc.dart';
import '../controllers/login_controller/login_event.dart';
import '../controllers/login_google_controller/login_google_bloc.dart';
import '../controllers/login_google_controller/login_google_event.dart';

class LoginAppPage extends StatefulWidget {
  const LoginAppPage({Key? key}) : super(key: key);

  @override
  State<LoginAppPage> createState() => _LoginAppPageState();
}

class _LoginAppPageState extends State<LoginAppPage> {
  final TextEditingController _emailController = TextEditingController();
  final _loginBloc = Modular.get<LoginWithEmailAndPasswordBloc>();
  final _loginGoogleBloc = Modular.get<LoginWithGoogleBloc>();
  final TextEditingController _passwordController = TextEditingController();

  bool _visibility = true;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginWithEmailAndPasswordBloc, AppState>(
        bloc: _loginBloc,
        listener: (context, state) {
          if (state is SuccessHomeState) {
            Modular.to.pushReplacementNamed('/home/');
          }
          if (state is SuccessWelcomeState) {
            Modular.to.pushReplacementNamed('/welcome/');
          }
        },
        builder: (context, stateEmail) {
          return BlocConsumer(
            builder: (context, stateGoogle) {
              return Scaffold(
                appBar: AppBar(
                  leading: IconButton(
                    onPressed: () => Modular.to.pop(),
                    icon: Icon(Icons.arrow_back_ios_new_outlined),
                  ),
                ),
                body: SingleChildScrollView(
                    child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 12.0),
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
                                      image: AssetImage(
                                          'assets/images/login_woman.png'))),
                            ),
                            FormsDesign(
                              prefixIcon: Icon(
                                Icons.person_outline,
                                color: ColorUtils.whiteColor,
                              ),
                              suffixIcon: null,
                              title: 'Email',
                              visibility: false,
                              controller: _emailController,
                            ),
                            FormsDesign(
                              prefixIcon: null,
                              suffixIcon: IconButton(
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
                              title: 'Senha',
                              visibility: _visibility,
                              controller: _passwordController,
                            ),
                            if (stateEmail is ErrorState) ...[
                              AnimatedContainer(
                                duration: Duration(seconds: 5),
                                curve: Curves.ease,
                                child: Text(
                                  stateEmail.message!,
                                  style: ThemeApp.theme.textTheme.subtitle1,
                                ),
                              )
                            ],
                            if (stateGoogle is ErrorState) ...[
                              AnimatedContainer(
                                duration: Duration(seconds: 5),
                                curve: Curves.ease,
                                child: Text(
                                  stateGoogle.message!,
                                  style: ThemeApp.theme.textTheme.subtitle1,
                                ),
                              )
                            ],
                            ButtonDesign(
                                text: 'Entrar',
                                action: () {
                                  if (!(stateGoogle is ProcessingState) ||
                                      !(stateEmail is ProcessingState)) {
                                    _loginBloc.add(
                                        LoginWithEmailAndPasswordEvent(
                                            email: _emailController.text,
                                            password:
                                                _passwordController.text));
                                  }
                                }),
                            if (stateEmail is ProcessingState) ...[
                              LoadingDesign(),
                            ],
                            if (stateGoogle is ProcessingState) ...[
                              CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    ColorUtils.whiteColor),
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
                                    onPressed: () => Modular.to
                                        .pushNamed('/recovery_account'),
                                    child: Text(
                                      'Clique aqui e recupere',
                                      style: ThemeApp.theme.textTheme.caption,
                                    )),
                              ],
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 20.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12.0),
                                    width: 80,
                                    height: 1,
                                    color: ColorUtils.whiteColor,
                                  ),
                                  Text(
                                    'Ou entre com outras opções',
                                    style: ThemeApp.theme.textTheme.overline,
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12.0),
                                    width: 80,
                                    height: 1,
                                    color: ColorUtils.whiteColor,
                                  ),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                if (!(stateGoogle is ProcessingState) ||
                                    !(stateEmail is ProcessingState)) {
                                  _loginGoogleBloc.add(LoginWithGoogleEvent());
                                }
                              },
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: 15,
                                    backgroundColor:
                                        ColorUtils.transparentColor,
                                    backgroundImage: AssetImage(
                                        'assets/images/google_icon.png'),
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
                        ))),
              );
            },
            listener: (context, state) {
              if (state is SuccessHomeState) {
                Modular.to.pushReplacementNamed(
                  '/home/',
                );
              }
              if (state is SuccessWelcomeState) {
                Modular.to.pushReplacementNamed('/welcome/');
              }
            },
            bloc: _loginGoogleBloc,
          );
        });
  }
}
