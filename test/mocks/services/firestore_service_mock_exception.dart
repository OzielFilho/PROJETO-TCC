import 'package:app/app/core/services/firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreServiceMockException implements FirestoreService {
  dynamic mock;
  FirestoreServiceMockException({mock}) : this.mock = mock ?? 'sucesso';

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
    throw Exception();
  }

  @override
  Future<Map<String, dynamic>> getDocument(
      String collectionPath, String documentPath) async {
    callGetDocument += 1;
    throw Exception();
  }

  @override
  Stream<DocumentSnapshot<Map<String, dynamic>>> getDocumentSnapshot(
      String collectionPath, String documentPath) async* {
    callGetDocumentSnapshot += 1;
    throw Exception();
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
