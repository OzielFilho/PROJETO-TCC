import 'package:app/app/core/presentation/widgets/form_desing.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {
  final bool hasPhone;
  const WelcomePage({Key? key, required this.hasPhone}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  List<FormsDesign> forms = [
    FormsDesign(
      controller: TextEditingController(text: 'opa'),
    )
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('${widget.hasPhone}'),
      ),
    );
  }
}
