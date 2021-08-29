import 'package:app/app/modules/home/pages/initial/initial_store.dart';
import 'package:flutter/material.dart';

import 'package:flutter_modular/flutter_modular.dart';

class ClipperCustom extends StatefulWidget {
  final double height;
  const ClipperCustom({Key? key, required this.height}) : super(key: key);

  @override
  _ClipperCustomState createState() => _ClipperCustomState();
}

class _ClipperCustomState extends State<ClipperCustom> {
  final storeInitial = Modular.get<InitialStore>();
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: BezierClipper(),
      child: Container(
        color: Theme.of(context).primaryColor,
        height: widget.height,
        width: double.infinity,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        storeInitial.showDrawer = !storeInitial.showDrawer;
                      },
                      icon: Icon(
                        Icons.list_outlined,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Olá, Fulana',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.notifications,
                    color: Colors.white,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class BezierClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = new Path();
    path.lineTo(0, size.height * 0.85); //vertical line
    path.cubicTo(size.width / 3, size.height, 2 * size.width / 3,
        size.height * 0.7, size.width, size.height * 0.85); //cubic curve
    path.lineTo(size.width, 0); //vertical line
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
