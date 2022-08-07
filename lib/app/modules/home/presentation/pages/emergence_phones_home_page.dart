import 'package:app/app/core/presentation/widgets/buttons_design.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../../../../core/theme/theme_app.dart';
import '../../infra/models/phones_emergence_model.dart';

class EmergencePhonesHome extends StatelessWidget {
  EmergencePhonesHome({Key? key}) : super(key: key);

  final List<PhonesEmergenceModel> _phones = [
    PhonesEmergenceModel('190', 'Policia Militar'),
    PhonesEmergenceModel('192', 'Samu'),
    PhonesEmergenceModel('193', 'Bombeiros')
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Modular.to.pop(),
            icon: Icon(Icons.arrow_back_ios)),
        title: Text(
          'Contatos de Emergência',
          style: ThemeApp.theme.textTheme.headline3,
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Text(
              'Selecione um contato para telefonar em caso de emergência.',
              style: ThemeApp.theme.textTheme.subtitle1,
            ),
            const SizedBox(
              height: 20.0,
            ),
            ListView.builder(
              itemBuilder: (context, index) => Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${index + 1}. ' + _phones[index].name,
                      style: ThemeApp.theme.textTheme.headline2,
                    ),
                    ButtonDesign(
                        action: () async {
                          await launchUrlString(
                              "tel://${_phones[index].phone}");
                        },
                        text: _phones[index].phone,
                        content: Icon(Icons.call)),
                  ],
                ),
              ),
              itemCount: _phones.length,
              shrinkWrap: true,
            )
          ],
        ),
      ),
    );
  }
}
