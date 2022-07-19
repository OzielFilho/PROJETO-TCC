import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CreateAccountWidget extends StatelessWidget {
  const CreateAccountWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              onPressed: () => Modular.to.pop(),
              icon: Icon(Icons.arrow_back_ios_new_outlined))),
    );
  }
}
