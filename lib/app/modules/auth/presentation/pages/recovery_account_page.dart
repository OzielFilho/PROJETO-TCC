import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../core/presentation/controller/app_state.dart';
import '../../../../core/presentation/widgets/buttons_design.dart';
import '../../../../core/presentation/widgets/form_desing.dart';
import '../../../../core/presentation/widgets/loading_desing.dart';
import '../../../../core/theme/theme_app.dart';
import '../../../../core/utils/colors/colors_utils.dart';
import '../../../../core/utils/widgets_utils.dart';
import '../controllers/recovery_account_controller/recovery_account_bloc.dart';
import '../controllers/recovery_account_controller/recovery_account_event.dart';

class RecoveryAccountPage extends StatelessWidget {
  RecoveryAccountPage({Key? key}) : super(key: key);

  final _recoveryBloc = Modular.get<RecoveryAccountBloc>();
  final _emailRecoveryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RecoveryAccountBloc, AppState>(
      listener: (context, state) {
        if (state is NetworkErrorState) {
          WidgetUtils.showOkDialog(
              context, 'Internet Indisponível', state.message!, 'Reload', () {
            Modular.to.pop(context);
          }, permanentDialog: false);
        }
      },
      bloc: _recoveryBloc,
      builder: (context, state) {
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
                          if (state is ErrorState) ...[
                            AnimatedContainer(
                              alignment: Alignment.center,
                              duration: Duration(seconds: 5),
                              curve: Curves.ease,
                              child: Text(
                                state.message!,
                                style: ThemeApp.theme.textTheme.subtitle1,
                              ),
                            )
                          ],
                          if (state is SuccessState) ...[
                            AnimatedContainer(
                              alignment: Alignment.center,
                              duration: Duration(seconds: 5),
                              curve: Curves.ease,
                              child: Text(
                                'Dentro de alguns segundos você receberá um email com as informações para a recuperação de senha.',
                                style: ThemeApp.theme.textTheme.subtitle1,
                              ),
                            )
                          ],
                          if (state is ProcessingState) ...[
                            Align(
                                alignment: Alignment.center,
                                child: LoadingDesign()),
                          ],
                        ],
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: ButtonDesign(
                            text: 'Recuperar Senha',
                            action: () {
                              FocusScope.of(context).unfocus();
                              if (!(state is SuccessState)) {
                                _recoveryBloc.add(RecoveryAccountWithEmailEvent(
                                    email: _emailRecoveryController.text));
                              }
                            }),
                      )
                    ],
                  ),
                ),
              ),
            );
          }),
        );
      },
    );
  }
}
