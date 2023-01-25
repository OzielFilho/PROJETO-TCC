import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../core/presentation/controller/app_state.dart';
import '../../../core/presentation/widgets/buttons_design.dart';
import '../../../core/presentation/widgets/form_desing.dart';
import '../../../core/presentation/widgets/loading_desing.dart';
import '../../../core/theme/theme_app.dart';
import '../../../core/utils/colors/colors_utils.dart';
import '../recovery_password/presenter/recovery_password_presenter.dart';
import '../recovery_password/presenter/recovery_password_presenter_provider.dart';

class RecoveryAccountPage extends StatefulWidget {
  RecoveryAccountPage({Key? key}) : super(key: key);

  @override
  State<RecoveryAccountPage> createState() => _RecoveryAccountPageState();
}

class _RecoveryAccountPageState extends State<RecoveryAccountPage> {
  final _emailRecoveryController = TextEditingController();

  late RecoveryPasswordPresenterProvider _providerRecoveryPassword;

  @override
  void initState() {
    super.initState();
    _providerRecoveryPassword = RecoveryPasswordPresenter(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Modular.to.pop(),
            icon: Icon(Icons.arrow_back_ios_new_outlined),
          ),
        ),
        body: LayoutBuilder(builder: (context, viewportConstraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: viewportConstraints.maxHeight,
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 12.0, vertical: 12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Insira seus dados para recuperar sua Senha',
                            style: ThemeApp.theme.textTheme.headline1),
                        const SizedBox(
                          height: 20,
                        ),
                        Text('Insira Seu Email',
                            style: ThemeApp.theme.textTheme.subtitle1),
                        FormsDesign(
                          prefixIcon: Icon(
                            Icons.person_outline,
                            color: ColorUtils.whiteColor,
                          ),
                          suffixIcon: null,
                          title: 'usuario@exemplo.com',
                          visibility: false,
                          controller: _emailRecoveryController,
                        ),
                        StreamBuilder<Object>(
                          stream: _providerRecoveryPassword
                              .outRecoveryPasswordController,
                          builder: (context, snapshot) {
                            if (snapshot.data is ProcessingState) {
                              return Center(child: LoadingDesign());
                            }
                            if (snapshot.hasData) {
                              final result = snapshot.data is bool;
                              if (result) {
                                return Center(
                                  child: AnimatedContainer(
                                    alignment: Alignment.center,
                                    duration: Duration(seconds: 5),
                                    curve: Curves.ease,
                                    child: Text(
                                      'Dentro de alguns segundos você receberá um email com as informações para a recuperação de senha.',
                                      style: ThemeApp.theme.textTheme.subtitle1,
                                    ),
                                  ),
                                );
                              }
                            }
                            return Center(
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.7,
                                child: ButtonDesign(
                                    text: 'Recuperar Senha',
                                    action: () async {
                                      FocusScope.of(context).unfocus();
                                      await _providerRecoveryPassword
                                          .recoveryPassword(
                                              _emailRecoveryController.text);
                                    }),
                              ),
                            );
                          },
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        }));
  }
}
