import 'package:encrypt/encrypt.dart';

class EncryptData {
  late Encrypter encrypter;
  EncryptData() {
    encrypter =
        Encrypter(AES(Key.fromUtf8('my 32 length key................')));
  }

  Encrypted encrypty(String text) {
    final iv = IV.fromLength(16);
    final encrypted = encrypter.encrypt(text, iv: iv);
    return encrypted;
  }

  String decrypty(String encrypty) {
    final value = Encrypted.fromBase16(encrypty);
    final iv = IV.fromLength(16);
    final decrypted = encrypter.decrypt(value, iv: iv);
    return decrypted;
  }
}
