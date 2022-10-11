import 'package:app/app/core/utils/colors/colors_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../core/theme/theme_app.dart';

class TutorialPage extends StatefulWidget {
  const TutorialPage({Key? key}) : super(key: key);

  @override
  State<TutorialPage> createState() => _TutorialPageState();
}

class _TutorialPageState extends State<TutorialPage> {
  PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          PageView(
            scrollDirection: Axis.horizontal,
            pageSnapping: true,
            physics: BouncingScrollPhysics(),
            controller: _controller,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 400,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(
                                  'assets/images/gifs/tutorial_chat.png'))),
                    ),
                    Text(
                      'Chat',
                      style: ThemeApp.theme.textTheme.headline1,
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      'Envie mensagens para seus contatos de confiança cadastrados no aplicativo.',
                      style: ThemeApp.theme.textTheme.subtitle1,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Navegue até o icone de menu na página principal e selecione o icone de conversa para acessar o chat.',
                      style: ThemeApp.theme.textTheme.subtitle1,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 400,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(
                                  'assets/images/gifs/tutorial_sos.png'))),
                    ),
                    Text(
                      'Botão SOS',
                      style: ThemeApp.theme.textTheme.headline1,
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      'Telefone para contatos emergência para denunciar a violência',
                      style: ThemeApp.theme.textTheme.subtitle1,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Clique no icone com o nome "SOS" para acessar a funcionalidade.',
                      style: ThemeApp.theme.textTheme.subtitle1,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 400,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(
                                  'assets/images/gifs/tutorial_urgent.png'))),
                    ),
                    Text(
                      'Urgência com os botões de volume',
                      style: ThemeApp.theme.textTheme.headline1,
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      'Use os botões de volume para enviar uma mensagem de socorro para seus contatos de confiança.',
                      style: ThemeApp.theme.textTheme.subtitle1,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Clique 3x no botão de volume e mensagem será enviada.',
                      style: ThemeApp.theme.textTheme.subtitle1,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextButton(
                  onPressed: () => Modular.to.pushReplacementNamed('/home/'),
                  child: Text(
                    'Avançar',
                    style: ThemeApp.theme.textTheme.subtitle1,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.16,
                ),
                Row(
                  children: [
                    IconButton(
                        color: ColorUtils.whiteColor,
                        iconSize: 30,
                        onPressed: () {
                          if (_controller.page! > 0) {
                            _controller.previousPage(
                                duration: Duration(milliseconds: 500),
                                curve: Curves.ease);
                          }
                        },
                        icon: Icon(Icons.arrow_back_ios_new_rounded)),
                    IconButton(
                        color: ColorUtils.whiteColor,
                        iconSize: 30,
                        onPressed: () {
                          if (_controller.page! < 2) {
                            _controller.nextPage(
                                duration: Duration(milliseconds: 500),
                                curve: Curves.ease);
                          }
                        },
                        icon: Icon(Icons.arrow_forward_ios_rounded)),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
