import 'package:app/app/modules/home/infra/models/details_contact_chat_model.dart';

import '../../../core/services/firebase_auth_service.dart';
import '../../../core/services/firestore_service.dart';
import '../infra/datasources/chat_home_datasource.dart';

class ChatHomeFromFirebase implements ChatHomeDatasource {
  final FirebaseAuthService authService;
  final FirestoreService firestoreService;

  ChatHomeFromFirebase(this.authService, this.firestoreService);

  @override
  Future<List<DetailsContactChatModel>> getListDetailsContactFromPhoneChat(
      {List<String>? phones}) async {
    List<DetailsContactChatModel> result = [];
    phones!.map((phone) async {
      final existDocument =
          await firestoreService.existDocument('contacts', phone);
      if (existDocument) {
        final tokenId = await firestoreService.getDocument('contacts', phone);
        final user =
            await firestoreService.getDocument('users', tokenId['tokenId']);
        user.addAll({'tokenId': tokenId['tokenId']});
        result.add(DetailsContactChatModel.fromDocument(user));
      }
    }).toList();

    return result;
  }
}
