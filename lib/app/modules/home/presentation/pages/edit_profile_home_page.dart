import 'dart:io';

import '../../../../core/presentation/controller/app_state.dart';
import '../../../../core/presentation/widgets/buttons_design.dart';
import '../../../../core/presentation/widgets/form_desing.dart';
import '../../../../core/utils/colors/colors_utils.dart';
import '../controllers/bloc/get_user_home_bloc.dart';
import '../controllers/bloc/update_user_home_bloc.dart';
import '../controllers/events/home_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/presentation/widgets/loading_desing.dart';
import '../../../../core/services/image_service.dart';
import '../../../../core/theme/theme_app.dart';
import '../../../../core/utils/widgets_utils.dart';
import '../../domain/entities/user_result_home.dart';

class EditProfileHomePage extends StatefulWidget {
  final UserResultHome? user;
  final GetUserHomeBloc? blocGetUser;
  EditProfileHomePage({Key? key, this.user, required this.blocGetUser})
      : super(key: key);

  @override
  State<EditProfileHomePage> createState() => _EditProfileHomePageState();
}

class _EditProfileHomePageState extends State<EditProfileHomePage> {
  final _blocUpdateUser = Modular.get<UpdateUserHomeBloc>();

  late UserResultHome userResultHome;
  TextEditingController _controllerName = TextEditingController();
  @override
  void initState() {
    userResultHome = widget.user!;
    super.initState();
    _controllerName = TextEditingController(text: userResultHome.name);
  }

  File? _file;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Modular.to.pop(),
            icon: Icon(Icons.arrow_back_ios)),
        title: Text(
          'Editar Perfil',
          style: ThemeApp.theme.textTheme.headline3,
        ),
        centerTitle: true,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  borderRadius: BorderRadius.circular(50.0),
                  onTap: () {
                    WidgetUtils.showOkDialog(
                        context,
                        'Escolha uma Imagem',
                        'Escolha uma imagem para o seu perfil',
                        'Fechar',
                        () => Modular.to.pop(),
                        content: Column(
                          children: [
                            InkWell(
                              child: Text(
                                '1. Câmera',
                                style: ThemeApp.theme.textTheme.headline2,
                              ),
                              onTap: () async {
                                final file =
                                    await ImageServiceImpl(ImagePicker())
                                        .getImage();
                                _file = file;
                                setState(() {});
                                Modular.to.pop();
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            InkWell(
                              child: Text(
                                '2. Galeria',
                                style: ThemeApp.theme.textTheme.headline2,
                              ),
                              onTap: () async {
                                final file =
                                    await ImageServiceImpl(ImagePicker())
                                        .getImage(isCamera: false);
                                _file = file;
                                setState(() {});
                                Modular.to.pop();
                              },
                            ),
                          ],
                        ));
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 110,
                    width: 110,
                    decoration: BoxDecoration(
                        image: userResultHome.photo.isNotEmpty
                            ? _file != null
                                ? DecorationImage(
                                    image: FileImage(_file!), fit: BoxFit.cover)
                                : DecorationImage(
                                    image: NetworkImage(userResultHome.photo),
                                    fit: BoxFit.cover)
                            : null,
                        shape: BoxShape.circle,
                        border: Border.all(color: ColorUtils.whiteColor)),
                    child: Icon(
                      Icons.photo_camera_outlined,
                      size: 40,
                      color: userResultHome.photo.isNotEmpty
                          ? ColorUtils.whiteColor.withOpacity(.5)
                          : ColorUtils.whiteColor,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Seu nome',
                      style: ThemeApp.theme.textTheme.subtitle1),
                ),
                FormsDesign(controller: _controllerName),
              ],
            ),
            BlocConsumer<UpdateUserHomeBloc, AppState>(
                bloc: _blocUpdateUser,
                listener: (context, state) {
                  if (state is ErrorState) {
                    WidgetUtils.showOkDialog(context, 'Atualizar Usuário',
                        state.message!, 'Fechar', () => Modular.to.pop());
                  }
                  if (state is SuccessUpdateUserState) {
                    WidgetUtils.showOkDialog(
                        context,
                        'Atualizar Usuário',
                        'Usuário alterado com sucesso!',
                        'Fechar',
                        () => Modular.to.pop());
                  }
                },
                builder: (context, data) {
                  if (data is ProcessingState) {
                    return LoadingDesign();
                  }

                  return SizedBox(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: ButtonDesign(
                          text: 'Atualizar',
                          action: () async {
                            if (!(data is ProcessingState)) {
                              if (_file != null) {
                                final imageUrl = await _blocUpdateUser.saveFile(
                                    _file!, widget.user!.tokenId);
                                userResultHome.photo = imageUrl;
                              }
                              userResultHome.name = _controllerName.text;
                              _blocUpdateUser
                                  .add(UpdateUserHomeEvent(userResultHome));
                              widget.blocGetUser!.add(GetUserHomeEvent());
                            }
                          }));
                }),
          ],
        ),
      ),
    );
  }
}
