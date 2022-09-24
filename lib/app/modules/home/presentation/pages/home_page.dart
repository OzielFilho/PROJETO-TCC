import 'dart:async';

import 'package:app/app/core/services/audio_service.dart';
import 'package:app/app/modules/home/presentation/controllers/bloc/chat/send_message_emergence_with_chat_bloc.dart';

import '../../../../core/presentation/controller/app_state.dart';
import '../../../../core/presentation/widgets/svg_design.dart';
import '../../../../core/services/volume_actions_service.dart';
import '../../../../core/theme/theme_app.dart';
import '../../../../core/utils/colors/colors_utils.dart';
import '../../../../core/utils/constants/encrypt_data.dart';
import '../../../../core/utils/widgets_utils.dart';
import '../controllers/bloc/get_user_home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../core/presentation/widgets/loading_desing.dart';
import '../controllers/bloc/get_current_location_bloc.dart';
import '../controllers/events/home_event.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  VolumeActionsServiceImpl _actionsServiceImpl = VolumeActionsServiceImpl();
  final _blocGetUserHome = Modular.get<GetUserHomeBloc>();
  final _blocCurrentPositionHome = Modular.get<GetCurrentLocationBloc>();
  bool _optionsShow = false;
  bool _volumeOptionsShow = false;
  void _updateOptionsShow() {
    _optionsShow = !_optionsShow;
    setState(() {});
  }

  void _updateVolumeOptionsShow() {
    _volumeOptionsShow = !_volumeOptionsShow;
    setState(() {});
  }

  Completer<GoogleMapController> _controller = Completer();

  final _controllerAudioAssets = Modular.get<AudioService>();
  final _blocSendMessageEmergence =
      Modular.get<SendMessageEmergenceWithChatBloc>();
  @override
  void initState() {
    _blocGetUserHome.add(GetUserHomeEvent());
    _blocCurrentPositionHome.add(GetCurrentLocationEvent());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetUserHomeBloc, AppState>(
        listener: (context, state) {
          if (state is SuccessGetUserState) {
            List<String> contacts = _blocGetUserHome.user!.contacts
                .map((e) => EncryptData().decrypty(e))
                .toList();
            _actionsServiceImpl.initialization(() {
              _blocSendMessageEmergence.add(SendMessageEmergenceWithChatEvent(
                  contacts,
                  _blocGetUserHome.user!.tokenId,
                  _blocCurrentPositionHome.location!));
            });
          }
          if (state is NetworkErrorState) {
            WidgetUtils.showOkDialog(
                context, 'Internet Indisponível', state.message!, 'Reload', () {
              Modular.to.pop(context);
              _blocGetUserHome.add(GetUserHomeEvent());
            }, permanentDialog: false);
          }
        },
        bloc: _blocGetUserHome,
        builder: (context, stateGetUser) {
          if (stateGetUser is ProcessingState) {
            return Scaffold(body: Center(child: LoadingDesign()));
          }
          if (stateGetUser is SuccessGetUserState) {
            return Scaffold(
              floatingActionButton: Padding(
                padding: const EdgeInsets.only(top: 16.0, right: 4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * .45,
                      height: 42,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: ColorUtils.primaryColor,
                        borderRadius: BorderRadius.circular(60.0),
                      ),
                      child: Text(
                        'Olá, ${_blocGetUserHome.user!.name}',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: ThemeApp.theme.textTheme.headline2,
                      ),
                    ),
                    AnimatedContainer(
                      duration: Duration(milliseconds: 500),
                      child: _optionsShow
                          ? Padding(
                              padding: const EdgeInsets.only(right: 28.0),
                              child: Container(
                                height: 180,
                                width: MediaQuery.of(context).size.width * .085,
                                decoration: BoxDecoration(
                                    color: ColorUtils.primaryColor,
                                    borderRadius: BorderRadius.circular(60.0)),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    InkWell(
                                        onTap: _updateOptionsShow,
                                        child: SvgDesign(
                                          path:
                                              'assets/images/svg/button_arrow_back_up.svg',
                                        )),
                                    InkWell(
                                        onTap: () {
                                          _updateOptionsShow();
                                          Modular.to.pushNamed('chat_home',
                                              arguments: {
                                                'contacts': _blocGetUserHome
                                                    .user!.contacts,
                                                'tokenId': _blocGetUserHome
                                                    .user!.tokenId,
                                                'photoUser': _blocGetUserHome
                                                    .user!.photo,
                                              });
                                        },
                                        child: SvgDesign(
                                          height: 25,
                                          width: 25,
                                          path:
                                              'assets/images/svg/button_chat.svg',
                                        )),
                                    InkWell(
                                        onTap: () {
                                          _updateOptionsShow();
                                          Modular.to.pushNamed(
                                              'configurations_home',
                                              arguments: {
                                                'user': _blocGetUserHome.user!,
                                                'bloc': _blocGetUserHome
                                              });
                                        },
                                        child: SvgDesign(
                                          height: 25,
                                          width: 25,
                                          path:
                                              'assets/images/svg/button_config.svg',
                                        )),
                                    InkWell(
                                        onTap: () {
                                          _updateOptionsShow();
                                          Modular.to.pushNamed(
                                              'emergence_phones_home');
                                        },
                                        child: SvgDesign(
                                          height: 25,
                                          width: 25,
                                          path:
                                              'assets/images/svg/button_phone.svg',
                                        ))
                                  ],
                                ),
                              ),
                            )
                          : MaterialButton(
                              onPressed: _updateOptionsShow,
                              child: Container(
                                  width: MediaQuery.of(context).size.width * .1,
                                  height: 25,
                                  decoration: BoxDecoration(
                                    color: ColorUtils.primaryColor,
                                    shape: BoxShape.circle,
                                  ),
                                  child: SvgDesign(
                                    path: 'assets/images/svg/options.svg',
                                  )),
                            ),
                    )
                  ],
                ),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.startTop,
              body: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  BlocConsumer<GetCurrentLocationBloc, AppState>(
                      listener: (context, state) {
                        if (state is ErrorState) {
                          WidgetUtils.showOkDialog(context, 'Localização',
                              state.message!, 'Reload', () {});
                        }
                        if (state is NetworkErrorState) {
                          WidgetUtils.showOkDialog(
                              context,
                              'Internet Indisponível',
                              state.message!,
                              'Reload', () {
                            Modular.to.pop(context);
                            _blocCurrentPositionHome
                                .add(GetCurrentLocationEvent());
                          }, permanentDialog: false);
                        }
                      },
                      bloc: _blocCurrentPositionHome,
                      builder: (context, stateMap) {
                        if (stateMap is ProcessingState) {
                          return Scaffold(body: Center(child: LoadingDesign()));
                        }
                        if (stateMap is SuccessGetCurrentLocationState) {
                          return GoogleMap(
                            zoomControlsEnabled: false,
                            myLocationEnabled: true,
                            mapToolbarEnabled: false,
                            myLocationButtonEnabled: false,
                            buildingsEnabled: false,
                            indoorViewEnabled: false,
                            compassEnabled: false,
                            mapType: MapType.normal,
                            initialCameraPosition:
                                _blocCurrentPositionHome.position!,
                            onMapCreated: (GoogleMapController controller) {
                              if (!_controller.isCompleted) {
                                _controller.complete(controller);
                              }
                            },
                          );
                        }
                        return Scaffold(
                          body: Container(),
                        );
                      }),
                  Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 500),
                        alignment: Alignment.bottomRight,
                        child: _volumeOptionsShow
                            ? Container(
                                height: 55,
                                width: MediaQuery.of(context).size.width * 0.7,
                                decoration: BoxDecoration(
                                    color: ColorUtils.primaryColor,
                                    borderRadius: BorderRadius.circular(60.0)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    InkWell(
                                        onTap: () async {
                                          await _controllerAudioAssets.play(
                                              path: 'assets/audios/police.wav');
                                        },
                                        child: SvgDesign(
                                          path:
                                              'assets/images/svg/button_police_icon.svg',
                                        )),
                                    InkWell(
                                        onTap: () async {
                                          await _controllerAudioAssets.play(
                                              path: 'assets/audios/sirene.mp3');
                                        },
                                        child: SvgDesign(
                                          path:
                                              'assets/images/svg/button_sound_icon.svg',
                                        )),
                                    InkWell(
                                        onTap: () async {
                                          await _controllerAudioAssets.play(
                                              path: 'assets/audios/bomb.mp3');
                                        },
                                        child: SvgDesign(
                                          path:
                                              'assets/images/svg/button_bomb_icon.svg',
                                        )),
                                    InkWell(
                                        onTap: _updateVolumeOptionsShow,
                                        child: SvgDesign(
                                          path:
                                              'assets/images/svg/button_arrow_back_rigth.svg',
                                        )),
                                  ],
                                ),
                              )
                            : GestureDetector(
                                onTap: _updateVolumeOptionsShow,
                                child: Container(
                                    height: 55,
                                    width: 55,
                                    alignment: Alignment.bottomRight,
                                    decoration: BoxDecoration(
                                      color: ColorUtils.primaryColor,
                                      shape: BoxShape.circle,
                                    ),
                                    child: SvgDesign(
                                      path:
                                          'assets/images/svg/button_volume.svg',
                                    )),
                              ),
                      )),
                ],
              ),
            );
          }

          return Scaffold(
            body: Container(),
          );
        });
  }
}
