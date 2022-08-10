import 'package:app/app/modules/home/domain/usecases/get_current_position.dart';
import 'package:app/app/modules/home/domain/usecases/get_user_home.dart';
import 'package:app/app/modules/home/domain/usecases/logout_user.dart';
import 'package:app/app/modules/home/infra/repositories/home_repository_impl.dart';
import 'package:app/app/modules/home/presentation/controllers/bloc/get_user_home_bloc.dart';
import 'package:app/app/modules/home/presentation/controllers/bloc/logout_user_bloc.dart';
import 'package:app/app/modules/home/presentation/pages/chat_page_home.dart';
import 'package:app/app/modules/home/presentation/pages/configuration_home_page.dart';
import 'package:app/app/modules/home/presentation/pages/emergence_phones_home_page.dart';
import 'package:app/app/modules/home/presentation/pages/home_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'domain/usecases/get_list_contacts_with_message_chat.dart';
import 'domain/usecases/get_list_details_contact_from_phone_chat.dart';
import 'external/chat_home_from_firebase.dart';
import 'external/home_information.dart';
import 'infra/repositories/chat_home_repository_impl.dart';
import 'presentation/controllers/bloc/get_current_location_bloc.dart';
import 'presentation/controllers/bloc/get_list_contacts_with_message_chat_bloc.dart';
import 'presentation/controllers/bloc/get_list_details_contact_from_phone_chat_bloc.dart';

class HomeModule extends Module {
  @override
  List<Bind> get binds => [
        Bind((i) => HomeInformation(i(), i(), i())),
        Bind((i) => ChatHomeFromFirebase(i(), i())),
        Bind((i) => HomeRepositoryImpl(i())),
        Bind((i) => ChatHomeRepositoryImpl(i())),
        Bind((i) => LogoutUser(i())),
        Bind((i) => GetUserHome(i())),
        Bind((i) => GetCurrentPosition(i())),
        Bind((i) => GetCurrentLocationBloc(i())),
        Bind((i) => GetUserHomeBloc(i())),
        Bind((i) => GetListDetailsContactFromPhoneChat(i())),
        Bind((i) => GetListDetailsContactFromPhoneChatBloc(i())),
        Bind((i) => LogoutUserBloc(i())),
        Bind((i) => GetListContactsWithMessageChat(i())),
        Bind((i) => GetListContactsWithMessageChatBloc(i())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(Modular.initialRoute,
            child: (context, args) => HomePage(),
            transition: TransitionType.leftToRight,
            duration: Duration(milliseconds: 500)),
        ChildRoute('/configurations_home',
            child: (context, args) => ConfigurationsHomePage(),
            transition: TransitionType.leftToRight,
            duration: Duration(milliseconds: 500)),
        ChildRoute('/chat_home',
            child: (context, args) => ChatPageHome(
                contacts: args.data['contacts'], tokenId: args.data['tokenId']),
            transition: TransitionType.leftToRight,
            duration: Duration(milliseconds: 500)),
        ChildRoute('/emergence_phones_home',
            child: (context, args) => EmergencePhonesHome(),
            transition: TransitionType.leftToRight,
            duration: Duration(milliseconds: 500)),
      ];
}
