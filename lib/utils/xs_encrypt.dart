import 'dart:convert';
import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart';
/// EnDecode Util.
class XsEncrypt {
  /// md5 加密
  static String encodeMd5(String data) {
    var content = new Utf8Encoder().convert(data);
    var digest = md5.convert(content);
    return hex.encode(digest.bytes);
  }

  /// Base64加密
  static String encodeBase64(String data) {
    var content = utf8.encode(data);
    var digest = base64Encode(content);
    return digest;
  }

  /// Base64解密
  static String decodeBase64(String data) {

    return String.fromCharCodes(base64Decode(data));
  }


  //AES加密-CBC模式
  static aesEncrypt(plainText,String k,String v) {
    try {
      final key = Key.fromUtf8(k);
      final iv = IV.fromUtf8(v);
      final encrypter = Encrypter(AES(key, mode: AESMode.cbc));
      final encrypted = encrypter.encrypt(plainText, iv: iv);
      return encrypted.base64;
    } catch (err) {
      print("aes encode error:$err");
      return plainText;
    }
  }

  //AES解密-CBC模式
  static dynamic aesDecrypt(encrypted,String k,String v) {
    try {
      final key = Key.fromUtf8(k);
      final iv = IV.fromUtf8(v);
      final encrypter = Encrypter(AES(key, mode: AESMode.cbc));
      final decrypted = encrypter.decrypt64(encrypted, iv: iv);
      return decrypted;
    } catch (err) {
      print("aes decode error:$err");
      return encrypted;
    }
  }
}
