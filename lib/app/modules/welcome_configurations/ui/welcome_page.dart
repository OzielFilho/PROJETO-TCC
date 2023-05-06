import 'package:app/app/core/models/user_account.dart';
import 'package:app/app/core/presentation/widgets/buttons_design.dart';
import 'package:app/app/core/presentation/widgets/form_desing.dart';
import 'package:app/app/core/presentation/widgets/loading_desing.dart';
import 'package:app/app/core/theme/theme_app.dart';
import 'package:app/app/core/utils/colors/colors_utils.dart';
import 'package:app/app/modules/welcome_configurations/presenter/update_contacts_user_presenter.dart';
import 'package:app/app/modules/welcome_configurations/presenter/update_contacts_user_presenter_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  late UpdateContactsUserPresenterProvider _provider;
  UserAccount _userAccount = UserAccount.instance;

  List<String> _contactsText = [];
  _createNewForm() {
    _formsContacts.add(FormsDesign(
        controller: TextEditingController(),
        title: 'Insira um número',
        formatter: [_maskFormatter],
        suffixIcon: IconButton(
            onPressed: _createNewForm,
            icon: Icon(
              Icons.add,
              color: ColorUtils.whiteColor,
            ))));
    setState(() {});
  }

  List<FormsDesign> _formsContacts = [];

  final _controllerPhone = TextEditingController();
  PageController? _controllerPage;

  var _maskFormatter = new MaskTextInputFormatter(
      mask: '(##)#####-####',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  @override
  void initState() {
    _createNewForm();
    _controllerPage = PageController(initialPage: 0);

    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (_controllerPage!.hasClients) {
        if (_userAccount.phone.isEmpty) {
          _controllerPage!.jumpToPage(2);
        } else {
          _controllerPage!.jumpToPage(1);
        }
      }
    });
    _provider = UpdateContactsUserPresenter();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Bem-Vindo ao Shh!',
                style: ThemeApp.theme.textTheme.headline1,
              ),
              Text(
                'Você acaba de entrar no Shh! Preciso de ajuda!',
                style: ThemeApp.theme.textTheme.subtitle1,
              ),
              const SizedBox(
                height: 20.0,
              ),
              Expanded(
                  flex: 1,
                  child: PageView(
                    physics: NeverScrollableScrollPhysics(),
                    controller: _controllerPage,
                    children: [
                      Center(child: LoadingDesign()),
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            Text(
                              'Para continuar, insira seus telefones de confiança que serão utilizados para contato',
                              style: ThemeApp.theme.textTheme.subtitle1,
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: _formsContacts.length,
                                physics: NeverScrollableScrollPhysics(),
                                padding: const EdgeInsets.all(12.0),
                                itemBuilder: (context, index) {
                                  return _formsContacts[index];
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            StreamBuilder<Object>(
                              initialData: false,
                              stream: _provider.outUpdateContactsUser,
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) return LoadingDesign();
                                if (snapshot.data is Exception)
                                  return Column(
                                    children: [
                                      Text(snapshot.data.toString()),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.7,
                                        child: ButtonDesign(
                                            text: 'Finalizar Novamente a Conta',
                                            action: () async {
                                              FocusScope.of(context).unfocus();

                                              _contactsText = _formsContacts
                                                  .map((e) => e.controller.text)
                                                  .toList();
                                              _userAccount.contacts =
                                                  _contactsText;
                                              _formsContacts.clear();
                                              await _provider
                                                  .updateContactsUser(
                                                      _userAccount);
                                              _createNewForm();
                                            }),
                                      ),
                                    ],
                                  );
                                if (!(snapshot.data is bool)) {
                                  return SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.7,
                                      child: ButtonDesign(
                                          text: 'Finalizar Conta',
                                          action: () async {
                                            FocusScope.of(context).unfocus();

                                            _contactsText = _formsContacts
                                                .map((e) => e.controller.text)
                                                .toList();
                                            _userAccount.contacts =
                                                _contactsText;
                                            _formsContacts.clear();
                                            await _provider.updateContactsUser(
                                                _userAccount);
                                            _createNewForm();
                                          }));
                                }
                                return LoadingDesign();
                              },
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Insira seu telefone',
                            style: ThemeApp.theme.textTheme.subtitle1,
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          FormsDesign(
                              controller: _controllerPhone,
                              formatter: [_maskFormatter],
                              suffixIcon: Icon(
                                Icons.phone_android,
                                color: Colors.white,
                              )),
                          const SizedBox(
                            height: 20.0,
                          ),
                          StreamBuilder<Object>(
                            initialData: false,
                            stream: _provider.outUpdateContactsUser,
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) return LoadingDesign();
                              if (snapshot.data is Exception)
                                return Column(
                                  children: [
                                    Text(snapshot.data.toString()),
                                    ButtonDesign(
                                        text: 'Inserir um Novo Número',
                                        action: () async {
                                          FocusScope.of(context).unfocus();
                                          _userAccount.phone =
                                              _controllerPhone.text;
                                          _controllerPhone.clear();
                                          setState(() {});
                                          await _provider
                                              .updateContactsUser(_userAccount);
                                        })
                                  ],
                                );
                              if (!(snapshot.data is bool)) {
                                return Align(
                                  alignment: Alignment.center,
                                  child: ButtonDesign(
                                      text: 'Continuar',
                                      action: () async {
                                        FocusScope.of(context).unfocus();
                                        _userAccount.phone =
                                            _controllerPhone.text;
                                        _controllerPhone.clear();
                                        setState(() {});
                                        await _provider
                                            .updateContactsUser(_userAccount);
                                      }),
                                );
                              }
                              return LoadingDesign();
                            },
                          ),
                        ],
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
