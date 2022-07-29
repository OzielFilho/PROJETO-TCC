import 'package:flutter/material.dart';

import '../../../../../core/theme/theme_app.dart';

class FormWithPhoneWidget extends StatelessWidget {
  const FormWithPhoneWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            'Para continuar, insira seus telefones de confiança que serão utilizados para contato',
            style: ThemeApp.theme.textTheme.subtitle1,
          ),
        ],
      ),
    );
  }
}
