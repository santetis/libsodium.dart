import 'dart:ffi';

import 'package:libsodium/src/ffi/cstring.dart';

import '../ffi/dylib_utils.dart';

import 'signatures.dart';
import 'types.dart';

class SodiumBindings {
  DynamicLibrary sodium;

  int Function() sodium_init;
  void Function(Pointer<Uint8> out, CString message, int length)
      crypto_hash_sha256;

  SodiumBindings({String path = './'}) {
    sodium = dlopenPlatformSpecific('sodium', path: path);
    sodium_init = sodium
        .lookup<NativeFunction<sodium_init_t>>('sodium_init')
        .asFunction();

    crypto_hash_sha256 = sodium
        .lookup<NativeFunction<crypto_hash_sha256_t>>('crypto_hash_sha256')
        .asFunction();
  }
}
