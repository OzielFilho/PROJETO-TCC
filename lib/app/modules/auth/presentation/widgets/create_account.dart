import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../core/presentation/widgets/buttons_design.dart';
import '../../../../core/presentation/widgets/form_desing.dart';
import '../../../../core/theme/theme_app.dart';

class CreateAccountWidget extends StatefulWidget {
  const CreateAccountWidget({Key? key}) : super(key: key);

  @override
  State<CreateAccountWidget> createState() => _CreateAccountWidgetState();
}

class _CreateAccountWidgetState extends State<CreateAccountWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              onPressed: () => Modular.to.pop(),
              icon: Icon(Icons.arrow_back_ios_new_outlined))),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text('Crie sua conta',
                    style: ThemeApp.theme.textTheme.headline1),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text('Insira suas credenciais',
                    style: ThemeApp.theme.textTheme.subtitle1),
              ),
              BuildFormRegisterAccount(),
            ],
          ),
        ),
      ),
    );
  }
}

class BuildFormRegisterAccount extends StatelessWidget {
  BuildFormRegisterAccount({Key? key}) : super(key: key);

  final _emailControllerNew = TextEditingController();
  final _nameControllerNew = TextEditingController();

  final _passwordControllerNew = TextEditingController();

  final _confirmPasswordControllerNew = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 54.0),
      child: Column(
        children: [
          FormsDesign.textFormCustom(
            null,
            null,
            'Nome',
            visibility: false,
            controller: _nameControllerNew,
          ),
          FormsDesign.textFormCustom(
            null,
            null,
            'Email',
            visibility: false,
            controller: _emailControllerNew,
          ),
          FormsDesign.textFormCustom(
            null,
            null,
            'Senha',
            visibility: false,
            controller: _passwordControllerNew,
          ),
          FormsDesign.textFormCustom(
            null,
            null,
            'Confirme a Senha',
            visibility: false,
            controller: _confirmPasswordControllerNew,
          ),
          ButtonsDesign.buttonDefault(text: 'Avançar', action: () {}),
        ],
      ),
    );
  }
}
