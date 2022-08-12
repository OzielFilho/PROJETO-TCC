import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../core/presentation/controller/app_state.dart';
import '../../../core/presentation/widgets/svg_design.dart';
import '../../../core/utils/widgets_utils.dart';
import 'controllers/splash_bloc.dart';
import 'controllers/splash_event.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final _splashBloc = Modular.get<SplashBloc>();

  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 500), () {
      _splashBloc.add(LoggedUserEvent());
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SplashBloc, AppState>(
      bloc: _splashBloc,
      listener: (context, state) {
        if (state is ErrorState) {
          WidgetUtils.showOkDialog(context, 'Não foi possível entrar no app',
              state.message!, 'Reload', () {
            Modular.to.pushReplacementNamed('/');
          }, permanentDialog: false);
        }
        if (!(state is NetworkErrorState)) {
          if (state is UserNotLoggedState) {
            Modular.to.pushReplacementNamed('/auth/');
          }
          if (state is SuccessHomeState) {
            Modular.to.pushReplacementNamed('/home/');
          }
          if (state is SuccessWelcomeState) {
            Modular.to.pushReplacementNamed(
              '/welcome/',
            );
          }
        }

        if (state is NetworkErrorState) {
          WidgetUtils.showOkDialog(
              context, 'Internet Indisponível', state.message!, 'Reload', () {
            Modular.to.pushReplacementNamed('/');
          }, permanentDialog: false);
        }
      },
      builder: (context, state) {
        return Scaffold(
            body: SvgDesign(
          path: 'assets/images/svg/splash_icon.svg',
        ));
      },
    );
  }
}
