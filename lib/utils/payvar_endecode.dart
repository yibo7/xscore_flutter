// import 'dart:convert';
// import 'package:convert/convert.dart';
// import 'package:crypto/crypto.dart';
// import 'package:encrypt/encrypt.dart';
// import 'package:newpayvarapp/utils/StringUtil.dart';
//
// import 'endecode_util.dart';
// /// EnDecode Util.
// class PayVarEnDecode {
//   /// md5 加密
//   static String encodeMd5(String data) {
//     return EnDecodeUtil.encodeMd5("$data-b59cc1d5ffb74827");
//   }
//   static String whiteAddressMd5(String address,String coinName,String publicKey) {
//     if(StringUtil.isEmpty(address)||StringUtil.isEmpty(coinName)||StringUtil.isEmpty(publicKey)){
//       return null;
//     }
//     return EnDecodeUtil.encodeMd5("$coinName$address$publicKey");
//   }
//
//   static const String _aesKey = "1d3bdd0c4ff7bb63";
//   static const String _aesVi = "5b07104c62c54533";
//   //AES加密-CBC模式
//   static aesEncrypt(plainText) {
//     try {
//       final key = Key.fromUtf8(_aesKey);
//       final iv = IV.fromUtf8(_aesVi);
//       final encrypter = Encrypter(AES(key, mode: AESMode.cbc));
//       final encrypted = encrypter.encrypt(plainText, iv: iv);
//       return encrypted.base64;
//     } catch (err) {
//       print("aes encode error:$err");
//       return plainText;
//     }
//   }
//
//   //AES解密-CBC模式
//   static dynamic aesDecrypt(encrypted) {
//     try {
//       final key = Key.fromUtf8(_aesKey);
//       final iv = IV.fromUtf8(_aesVi);
//       final encrypter = Encrypter(AES(key, mode: AESMode.cbc));
//       final decrypted = encrypter.decrypt64(encrypted, iv: iv);
//       return decrypted;
//     } catch (err) {
//       print("aes decode error:$err");
//       return encrypted;
//     }
//   }
// }
