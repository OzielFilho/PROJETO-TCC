import 'package:app/app/core/presentation/controller/app_state.dart';
import 'package:app/app/core/theme/theme_app.dart';
import 'package:app/app/core/utils/widgets_utils.dart';
import 'package:app/app/modules/home/presentation/controllers/bloc/logout_user_bloc.dart';
import 'package:app/app/modules/home/presentation/controllers/events/home_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ConfigurationsHomePage extends StatefulWidget {
  const ConfigurationsHomePage({Key? key}) : super(key: key);

  @override
  State<ConfigurationsHomePage> createState() => _ConfigurationsHomePageState();
}

class _ConfigurationsHomePageState extends State<ConfigurationsHomePage> {
  final _blocLogoutUser = Modular.get<LogoutUserBloc>();

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
                BlocConsumer<LogoutUserBloc, AppState>(
                    listener: (context, state) {
                      if (state is ErrorState) {
                        WidgetUtils.showOkDialog(
                            context,
                            'Problema ao Sair do App',
                            state.message!,
                            'Fechar', () {
                          Modular.to.pop();
                        });
                      }
                      if (state is SuccessLogoutUserState) {
                        Modular.to.pushNamedAndRemoveUntil(
                          '/auth/',
                          (p0) => false,
                        );
                      }
                    },
                    bloc: _blocLogoutUser,
                    builder: (context, snapshot) {
                      return TextButton(
                          onPressed: () =>
                              _blocLogoutUser.add(LogoutUserEvent()),
                          child: Text(
                            'Sair do App',
                            style: ThemeApp.theme.textTheme.headline2,
                          ));
                    }),
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
