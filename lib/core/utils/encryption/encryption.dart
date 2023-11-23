import 'package:encrypt/encrypt.dart' as encryption;

class Encryption {
  static final encryption.Key key = encryption.Key.fromUtf8('e33b5c9c6c0998bc');
  static final encryption.IV iv = encryption.IV.fromLength(16);
  static final encryption.Encrypter encrypt = encryption.Encrypter(
    encryption.AES(key, mode: encryption.AESMode.cbc, padding: 'PKCS7'),
  );

  static String encryptObject(String object) {
    final encryption.Encrypted encrypted = encrypt.encrypt(
      object,
      iv: iv,
    );
    return encrypted.base64;
  }

  static String decryptObject(String response) {
    final String decrypted = encrypt.decrypt64(
      response,
      iv: iv,
    );
    return decrypted;
  }
}
