import 'package:crypto/crypto.dart';
import 'dart:convert';

String md5HashConvert(String password){
   var bytes = utf8.encode(password); // data being hashed

  String passwordTomd5Hash = md5.convert(bytes).toString(); 

  return passwordTomd5Hash;
}