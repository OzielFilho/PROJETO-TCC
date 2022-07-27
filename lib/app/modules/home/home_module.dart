import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomeModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          Modular.initialRoute,
          child: (context, args) => Container(
            child: Center(
              child: MaterialButton(
                color: Colors.white,
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  Modular.to.pushReplacementNamed('/');
                },
                child: Text('opa'),
              ),
            ),
          ),
        )
      ];
}
