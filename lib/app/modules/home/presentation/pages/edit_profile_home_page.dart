import 'package:app/app/core/presentation/widgets/buttons_design.dart';
import 'package:app/app/core/presentation/widgets/form_desing.dart';
import 'package:app/app/core/utils/colors/colors_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../core/theme/theme_app.dart';
import '../../domain/entities/user_result_home.dart';

class EditProfileHomePage extends StatefulWidget {
  final UserResultHome? user;

  EditProfileHomePage({Key? key, this.user}) : super(key: key);

  @override
  State<EditProfileHomePage> createState() => _EditProfileHomePageState();
}

class _EditProfileHomePageState extends State<EditProfileHomePage> {
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
                  onTap: () {},
                  child: Container(
                    alignment: Alignment.center,
                    height: 110,
                    width: 110,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: ColorUtils.whiteColor)),
                    child: Icon(
                      Icons.photo_camera_outlined,
                      size: 40,
                      color: ColorUtils.whiteColor,
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
                FormsDesign(
                    controller: TextEditingController(text: widget.user!.name)),
              ],
            ),
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: ButtonDesign(text: 'Atualizar', action: () {})),
          ],
        ),
      ),
    );
  }
}
