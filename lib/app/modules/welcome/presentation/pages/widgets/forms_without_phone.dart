import '../../../../../core/presentation/widgets/form_desing.dart';
import 'package:flutter/material.dart';

import '../../../../../core/theme/theme_app.dart';

class FormsWithoutPhoneWidget extends StatelessWidget {
  FormsWithoutPhoneWidget({Key? key}) : super(key: key);
  final _controllerPhone = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            'Para continuar, insira seu telefone que será utilizado para contato',
            style: ThemeApp.theme.textTheme.subtitle1,
          ),
          FormsDesign(controller: _controllerPhone),
        ],
      ),
    );
  }
}