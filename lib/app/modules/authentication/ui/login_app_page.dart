import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../core/presentation/controller/app_state.dart';
import '../../../core/presentation/widgets/buttons_design.dart';
import '../../../core/presentation/widgets/form_desing.dart';
import '../../../core/presentation/widgets/loading_desing.dart';
import '../../../core/theme/theme_app.dart';
import '../../../core/utils/colors/colors_utils.dart';
import '../authentication_email_and_password/models/authentication_params_model.dart';
import '../authentication_email_and_password/presenter/authentication_email_and_password_presenter.dart';
import '../authentication_email_and_password/presenter/authentication_email_and_password_presenter_provider.dart';
import '../authentication_google/presenter/authentication_google_presenter.dart';
import '../authentication_google/presenter/authentication_google_presenter_provider.dart';

class LoginAppPage extends StatefulWidget {
  const LoginAppPage({Key? key}) : super(key: key);

  @override
  State<LoginAppPage> createState() => _LoginAppPageState();
}

class _LoginAppPageState extends State<LoginAppPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _visibility = true;

  late AuthenticationEmailAndPasswordPresenterProvider _providerLogin;
  late AuthenticationGooglePresenterProvider _providerLoginGoogle;

  @override
  void initState() {
    _providerLogin = AuthenticationEmailAndPasswordPresenter(context: context);
    _providerLoginGoogle = AuthenticationGooglePresenter(context: context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                  StreamBuilder<Object>(
                    stream: _providerLogin.outAuthController,
                    builder: (context, snapshot) {
                      if (snapshot.data is ProcessingState) {
                        return LoadingDesign();
                      }

                      return SizedBox(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: ButtonDesign(
                            text: 'Entrar',
                            action: () async {
                              FocusScope.of(context).unfocus();
                              await _providerLogin
                                  .authenticationEmailAndPassword(
                                      params: AuthenticationParamsModel(
                                          _emailController.text,
                                          _passwordController.text));
                            }),
                      );
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Esqueceu a senha?',
                        style: ThemeApp.theme.textTheme.overline,
                      ),
                      TextButton(
                          onPressed: () =>
                              Modular.to.pushNamed('recovery_account'),
                          child: Text(
                            'Clique aqui e recupere',
                            style: ThemeApp.theme.textTheme.caption,
                          )),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          width: 80,
                          height: 1,
                          color: ColorUtils.whiteColor,
                        ),
                        Text(
                          'Ou entre com outras opções',
                          style: ThemeApp.theme.textTheme.overline,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          width: 80,
                          height: 1,
                          color: ColorUtils.whiteColor,
                        ),
                      ],
                    ),
                  ),
                  StreamBuilder<Object>(
                    stream: _providerLoginGoogle.outGoogleLoginController,
                    builder: (context, snapshot) {
                      if (snapshot.data is ProcessingState) {
                        return LoadingDesign();
                      }

                      return InkWell(
                        onTap: () async {
                          await _providerLoginGoogle.authenticationGoogle();
                        },
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
                      );
                    },
                  ),
                ],
              ))),
    );
  }
}
