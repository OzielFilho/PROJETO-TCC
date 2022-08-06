import 'package:app/app/core/theme/theme_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ConfigurationsHomePage extends StatefulWidget {
  const ConfigurationsHomePage({Key? key}) : super(key: key);

  @override
  State<ConfigurationsHomePage> createState() => _ConfigurationsHomePageState();
}

class _ConfigurationsHomePageState extends State<ConfigurationsHomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Modular.to.pop(),
            icon: Icon(Icons.arrow_back_ios)),
        title: Text(
          'Configurações',
          style: ThemeApp.theme.textTheme.headline3,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextButton(
                    onPressed: () {},
                    child: Text(
                      'Editar Perfil',
                      style: ThemeApp.theme.textTheme.headline2,
                    )),
              ],
            ),
            Column(
              children: [
                TextButton(
                    onPressed: () {},
                    child: Text(
                      'Sair do App',
                      style: ThemeApp.theme.textTheme.headline2,
                    )),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Versão do App 1.0.0',
                    style: ThemeApp.theme.textTheme.subtitle1,
                    textAlign: TextAlign.center,
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
