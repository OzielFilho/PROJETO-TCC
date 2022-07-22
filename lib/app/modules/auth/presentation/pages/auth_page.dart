import '../../../../core/presentation/widgets/buttons_design.dart';
import '../../../../core/theme/theme_app.dart';
import '../../../../core/utils/colors/colors_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AuthPage extends StatefulWidget {
  AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              colorFilter: ColorFilter.mode(
                ColorUtils.primaryColor.withOpacity(.5),
                BlendMode.darken,
              ),
              image: AssetImage('assets/images/woman.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          alignment: Alignment.bottomCenter,
          child: Container(
            decoration: BoxDecoration(
              color: ColorUtils.primaryColor,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
            ),
            padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 0.0),
            height: MediaQuery.of(context).size.height * 0.3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Shh! Preciso de Ajuda',
                      style: ThemeApp.theme.textTheme.headline1,
                    ),
                    Text(
                      'Seu Aplicativo de proteção pessoal',
                      style: ThemeApp.theme.textTheme.subtitle1,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ButtonDesign(
                        text: 'Entrar no App',
                        action: () {
                          Modular.to.pushNamed('login_app');
                        }),
                    ButtonDesign(
                        text: 'Cadastrar Conta',
                        action: () {
                          Modular.to.pushNamed('create_account_form');
                        }),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
