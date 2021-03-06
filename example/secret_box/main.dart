import 'dart:convert';

import 'package:libsodium/libsodium.dart';

void main() {
  sodiumInit(libPath: './');

  final utils = Utils();
  final secretBox = SecretBox();
  final key = secretBox.keygen();
  // final nonce = utils.randomBytesBuf(secretBox.nonceLenght);
  final nonce = Digest('ab'.codeUnits);
  final message = 'Hello world !';
  print('key = $key');
  print('nonce = $nonce');
  print('messageLength = ${message.length}');

  final cipherText = secretBox.easy(message.codeUnits, nonce.bytes, key.bytes);
  print('cipherText = $cipherText');

  final decryptedText = secretBox.openEasy(
      message.length, cipherText.bytes, nonce.bytes, key.bytes);
  final decryptedMessage = utf8.decode(decryptedText.bytes);
  print('decryptedMessage = $decryptedMessage');
}
