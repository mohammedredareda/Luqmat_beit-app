import 'dart:io';
import 'dart:typed_data';

import 'package:path_provider/path_provider.dart';

/// Writes [bytes] to a fresh file in the temp directory and returns its
/// path, so `ProfileAvatarPicker` can render it with `Image.file` exactly
/// like a freshly-picked image.
Future<String> saveAvatarImageBytes(Uint8List bytes) async {
  final dir = await getTemporaryDirectory();
  final file = File('${dir.path}/avatar_${DateTime.now().microsecondsSinceEpoch}.png');
  await file.writeAsBytes(bytes, flush: true);
  return file.path;
}
