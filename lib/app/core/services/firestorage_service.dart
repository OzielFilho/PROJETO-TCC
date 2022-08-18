import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

abstract class FirestorageService {
  Future<void> saveArchive({String path, File? data});
  Future<String> getArchive({String path});
}

class FirestorageServiceImpl implements FirestorageService {
  final FirebaseStorage _firebaseStorage;
  FirestorageServiceImpl(this._firebaseStorage);

  @override
  Future<void> saveArchive({String? path, File? data}) async {
    await _firebaseStorage.ref().child(path!).putFile(data!);
  }

  @override
  Future<String> getArchive({String? path}) async {
    return await _firebaseStorage.ref().child(path!).getDownloadURL();
  }
}
