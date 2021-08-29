import 'package:app/app/modules/home/pages/initial/initial_store.dart';
import 'package:app/app/modules/home/pages/initial/widgets/clipper_custom/clipper_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'widgets/drawer_custom/drawer_custom.dart';

class InitialPage extends StatefulWidget {
  final String title;
  const InitialPage({Key? key, this.title = 'InitialPage'}) : super(key: key);
  @override
  InitialPageState createState() => InitialPageState();
}

class InitialPageState extends ModularState<InitialPage, InitialStore> {
  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (BuildContext context) => SafeArea(
        child: SingleChildScrollView(
          child: Stack(children: [
            Column(
              children: [
                ClipperCustom(
                    height: MediaQuery.of(context).size.height * 0.28),
                Container(
                  height: MediaQuery.of(context).size.height * 0.15,
                  child: ListView.builder(
                    itemCount: 5,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.all(15.0),
                    itemBuilder: (context, index) => Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      margin: const EdgeInsets.only(left: 8.0, right: 8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        image: DecorationImage(
                            image: NetworkImage(
                              'https://imagens.ebc.com.br/RwwMGJgNywD83h4rbZeLZHB7Qtw=/1170x700/smart/https://agenciabrasil.ebc.com.br/sites/default/files/thumbnails/image/violencia_contra_mulher.jpeg?itok=e3lq3q-y',
                            ),
                            fit: BoxFit.fill),
                      ),
                    ),
                  ),
                )
              ],
            ),
            AnimatedContainer(
              duration: Duration(seconds: 10),
              curve: Curves.decelerate,
              child: store.showDrawer
                  ? DrawerCustom(
                      height: MediaQuery.of(context).size.height * 0.9,
                      weight: MediaQuery.of(context).size.width * 0.5)
                  : Container(),
            )
          ]),
        ),
      ),
    );
  }
}
