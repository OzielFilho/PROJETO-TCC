import 'dart:async';

import 'package:app/app/core/presentation/controller/app_state.dart';
import 'package:app/app/core/services/volume_actions_service.dart';
import 'package:app/app/core/theme/theme_app.dart';
import 'package:app/app/core/utils/colors/colors_utils.dart';
import 'package:app/app/modules/home/presentation/controllers/bloc/get_user_home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../core/presentation/widgets/loading_desing.dart';
import '../controllers/events/home_event.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  VolumeActionsServiceImpl _actionsServiceImpl = VolumeActionsServiceImpl();
  final _blocGetUserHome = Modular.get<GetUserHomeBloc>();

  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  void initState() {
    _actionsServiceImpl.initialization(['(85)98828-6381']);
    _blocGetUserHome.add(GetUserHomeEvent());
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
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                    MaterialButton(
                      onPressed: () {},
                      child: Container(
                        width: MediaQuery.of(context).size.width * .1,
                        height: 25,
                        decoration: BoxDecoration(
                          color: ColorUtils.primaryColor,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: SvgPicture.asset(
                            'assets/images/svg/options.svg',
                            color: ColorUtils.whiteColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.startTop,
              body: GoogleMap(
                zoomControlsEnabled: false,
                myLocationEnabled: true,
                buildingsEnabled: false,
                indoorViewEnabled: false,
                compassEnabled: false,
                mapType: MapType.normal,
                initialCameraPosition: _kGooglePlex,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
              ),
            );
          }

          return Scaffold(
            body: Container(),
          );
        });
  }
}
