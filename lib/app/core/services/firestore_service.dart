import 'package:cloud_firestore/cloud_firestore.dart';

abstract class FirestoreService {
  Future<bool> existDocument(String collectionPath, String documentPath);
  Future<Map<String, dynamic>> getDocument(
      String collectionPath, String documentPath);
  Stream<DocumentSnapshot<Map<String, dynamic>>> getDocumentSnapshot(
      String collectionPath, String documentPath);
  Future<void> createDocument(
      String collectionPath, String documentPath, Map<String, dynamic>? data);
  Future<void> removeDocument(String collectionPath, String documentPath);
  Future<void> updateDocument(
      String collectionPath, String documentPath, Map<String, dynamic>? data);
}

class FirestoreServiceImpl implements FirestoreService {
  final FirebaseFirestore firestore;

  FirestoreServiceImpl(this.firestore);

  @override
  Future<bool> existDocument(String collectionPath, String documentPath) async {
    final result =
        await firestore.collection(collectionPath).doc(documentPath).get();
    return result.exists;
  }

  @override
  Future<void> createDocument(String collectionPath, String documentPath,
      Map<String, dynamic>? data) async {
    await firestore.collection(collectionPath).doc(documentPath).set(data!);
  }

  @override
  Future<Map<String, dynamic>> getDocument(
      String collectionPath, String documentPath) async {
    final result =
        await firestore.collection(collectionPath).doc(documentPath).get();
    return result.data()!;
  }

  @override
  Future<void> removeDocument(
      String collectionPath, String documentPath) async {
    return await firestore
        .collection(collectionPath)
        .doc(documentPath)
        .delete();
  }

  @override
  Future<void> updateDocument(String collectionPath, String documentPath,
      Map<String, dynamic>? data) async {
    return await firestore
        .collection(collectionPath)
        .doc(documentPath)
        .update(data!);
  }

  @override
  Stream<DocumentSnapshot<Map<String, dynamic>>> getDocumentSnapshot(
      String collectionPath, String documentPath) {
    return firestore.collection(collectionPath).doc(documentPath).snapshots();
  }
}
