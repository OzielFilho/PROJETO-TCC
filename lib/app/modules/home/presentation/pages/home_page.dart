import 'dart:async';

import 'package:app/app/core/presentation/controller/app_state.dart';
import 'package:app/app/core/presentation/widgets/svg_design.dart';
import 'package:app/app/core/services/volume_actions_service.dart';
import 'package:app/app/core/theme/theme_app.dart';
import 'package:app/app/core/utils/colors/colors_utils.dart';
import 'package:app/app/core/utils/constants/widgets_utils.dart';
import 'package:app/app/modules/home/presentation/controllers/bloc/get_user_home_bloc.dart';
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
  Completer<GoogleMapController> _controller = Completer();

  @override
  void initState() {
    _actionsServiceImpl.initialization(['(85)98828-6381']);
    _blocGetUserHome.add(GetUserHomeEvent());
    _blocCurrentPositionHome.add(GetCurrentLocationEvent());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetUserHomeBloc, AppState>(
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
                                height: 105,
                                width: MediaQuery.of(context).size.width * .08,
                                decoration: BoxDecoration(
                                    color: ColorUtils.primaryColor,
                                    borderRadius: BorderRadius.circular(60.0)),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    InkWell(
                                        onTap: () {
                                          setState(() {
                                            _optionsShow = !_optionsShow;
                                          });
                                        },
                                        child: SvgDesign(
                                          path:
                                              'assets/images/svg/button_arrow_back_up.svg',
                                        )),
                                    InkWell(
                                        onTap: () {},
                                        child: SvgDesign(
                                          path:
                                              'assets/images/svg/button_chat.svg',
                                        )),
                                    InkWell(
                                        onTap: () {},
                                        child: SvgDesign(
                                          path:
                                              'assets/images/svg/button_config.svg',
                                        )),
                                    InkWell(
                                        onTap: () {},
                                        child: SvgDesign(
                                          path:
                                              'assets/images/svg/button_phone.svg',
                                        ))
                                  ],
                                ),
                              ),
                            )
                          : MaterialButton(
                              onPressed: () {
                                setState(() {
                                  _optionsShow = !_optionsShow;
                                });
                              },
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
              body: BlocConsumer<GetCurrentLocationBloc, AppState>(
                  listener: (context, state) {
                    if (state is ErrorState) {
                      WidgetUtils.showOkDialog(context, 'Localização',
                          state.message!, 'Reload', () {});
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
                          _controller.complete(controller);
                        },
                      );
                    }
                    return Scaffold(
                      body: Container(),
                    );
                  }),
            );
          }

          return Scaffold(
            body: Container(),
          );
        });
  }
}
