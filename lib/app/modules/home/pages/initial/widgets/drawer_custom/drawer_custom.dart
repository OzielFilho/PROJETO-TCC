import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../initial_store.dart';

class DrawerCustom extends StatefulWidget {
  final double height;
  final double weight;
  DrawerCustom({Key? key, required this.height, required this.weight})
      : super(key: key);

  @override
  _DrawerCustomState createState() => _DrawerCustomState();
}

class _DrawerCustomState extends State<DrawerCustom> {
  final storeInitial = Modular.get<InitialStore>();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.deepPurple,
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(25), bottomRight: Radius.circular(25)),
      ),
      height: widget.height,
      width: widget.weight,
      child: Column(
        children: [
          IconButton(
            onPressed: () => storeInitial.showDrawer = !storeInitial.showDrawer,
            icon: Icon(Icons.arrow_back_ios_new_outlined),
            color: Colors.white,
          ),
          Text('OK'),
        ],
      ),
    );
  }
}
