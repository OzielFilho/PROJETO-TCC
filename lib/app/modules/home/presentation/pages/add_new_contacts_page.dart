import 'package:app/app/modules/home/presentation/controllers/bloc/chat/add_new_contacts_bloc.dart';
import 'package:app/app/modules/home/presentation/controllers/bloc/get_user_home_bloc.dart';
import 'package:app/app/modules/home/presentation/controllers/events/home_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../../../core/presentation/controller/app_state.dart';
import '../../../../core/presentation/widgets/buttons_design.dart';
import '../../../../core/presentation/widgets/form_desing.dart';
import '../../../../core/presentation/widgets/loading_desing.dart';
import '../../../../core/theme/theme_app.dart';
import '../../../../core/utils/colors/colors_utils.dart';
import '../../../../core/utils/widgets_utils.dart';

class AddNewContactsPage extends StatefulWidget {
  final GetUserHomeBloc bloc;
  final String tokenId;
  const AddNewContactsPage(
      {Key? key, required this.tokenId, required this.bloc})
      : super(key: key);

  @override
  State<AddNewContactsPage> createState() => _AddNewContactsPageState();
}

class _AddNewContactsPageState extends State<AddNewContactsPage> {
  final _blocAddContacts = Modular.get<AddNewContactsBloc>();
  List<FormsDesign> _formsContacts = [];
  var _maskFormatter = new MaskTextInputFormatter(
      mask: '(##)#####-####',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);
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

  @override
  void initState() {
    _createNewForm();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Modular.to.pop();
            },
            icon: Icon(Icons.arrow_back_ios)),
        title: Text(
          'Adicionar novos contatos',
          style: ThemeApp.theme.textTheme.headline3,
        ),
        centerTitle: true,
      ),
      body: BlocConsumer(
        bloc: _blocAddContacts,
        listener: (context, state) {
          if (state is NetworkErrorState) {
            WidgetUtils.showOkDialog(
                context, 'Internet Indisponível', state.message!, 'Reload', () {
              Modular.to.pop(context);
            }, permanentDialog: false);
          }
          if (state is SuccessAddNewContactsState) {
            WidgetUtils.showSnackBar(context, 'Contato adicionado com sucesso',
                actionText: '', onTap: () {});
            widget.bloc.add(GetUserHomeEvent());
            Modular.to.pop();
            Modular.to.pop();
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      'Insira novos contatos de confiança',
                      style: ThemeApp.theme.textTheme.subtitle1,
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
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
                  if (state is ErrorState) ...[
                    AnimatedContainer(
                      duration: Duration(seconds: 5),
                      curve: Curves.ease,
                      child: Text(
                        state.message!,
                        style: ThemeApp.theme.textTheme.subtitle1,
                      ),
                    ),
                  ],
                  const SizedBox(
                    height: 10.0,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: (state is ProcessingState)
                        ? Center(child: LoadingDesign())
                        : ButtonDesign(
                            text: 'Adicionar',
                            action: () {
                              FocusScope.of(context).unfocus();

                              _contactsText = _formsContacts
                                  .map((e) => e.controller.text)
                                  .toList();
                              _blocAddContacts.add(AddNewContactsEvent(
                                _contactsText,
                                widget.tokenId,
                              ));
                            }),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
