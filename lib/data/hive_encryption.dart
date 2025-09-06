// Optional encryption helper
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';


class HiveEncryption {
static const _storage = FlutterSecureStorage();
static const _prefix = 'hive_aes_key_';


static Future<HiveAesCipher?> cipherFor(String boxName) async {
if (kIsWeb) return null; // avoid secure storage on web
final keyName = '$_prefix$boxName';
var b64 = await _storage.read(key: keyName);
if (b64 == null) {
final key = Hive.generateSecureKey();
b64 = base64Encode(key);
await _storage.write(key: keyName, value: b64);
}
final keyBytes = base64Decode(b64);
return HiveAesCipher(keyBytes);
}
}