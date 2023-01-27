import 'package:flutter/material.dart';
import '../../../core/presentation/widgets/svg_design.dart';
import '../presenter/refresh_token_presenter.dart';
import '../presenter/refresh_token_presenter_provider.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late RefreshTokenPresenterProvider _provider;

  @override
  void initState() {
    super.initState();
    _provider = RefreshTokenPresenter(context: context);
    Future.delayed(Duration(milliseconds: 500), () async {
      await _provider.verifyLoggedUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
        stream: _provider.outRefreshToken,
        builder: (context, snapshot) {
          return Scaffold(
              body: SvgDesign(
            path: 'assets/images/svg/splash_icon.svg',
          ));
        });
  }
}
