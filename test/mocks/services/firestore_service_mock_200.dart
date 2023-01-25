import 'package:app/app/core/services/firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreServiceMock200 implements FirestoreService {
  dynamic mock;
  FirestoreServiceMock200({mock}) : this.mock = mock ?? 'sucesso';

  int callCreateDocument = 0;
  int callExistDocument = 0;
  int callGetDocument = 0;
  int callGetDocumentSnapshot = 0;
  int callRemoveDocument = 0;
  int callUpdateDocument = 0;

  @override
  Future<void> createDocument(String collectionPath, String documentPath,
      Map<String, dynamic>? data) async {
    callCreateDocument += 1;
  }

  @override
  Future<bool> existDocument(String collectionPath, String documentPath) async {
    callExistDocument += 1;
    return Future.value(true);
  }

  @override
  Future<Map<String, dynamic>> getDocument(
      String collectionPath, String documentPath) async {
    callGetDocument += 1;
    return Future.value({});
  }

  @override
  Stream<DocumentSnapshot<Map<String, dynamic>>> getDocumentSnapshot(
      String collectionPath, String documentPath) async* {
    callGetDocumentSnapshot += 1;
    Future.value({});
  }

  @override
  Future<void> removeDocument(
      String collectionPath, String documentPath) async {
    callRemoveDocument += 1;
  }

  @override
  Future<void> updateDocument(String collectionPath, String documentPath,
      Map<String, dynamic>? data) async {
    callUpdateDocument += 1;
  }
}
