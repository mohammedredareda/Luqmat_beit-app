// ignore_for_file: deprecated_member_use, avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'dart:typed_data';

/// Wraps [bytes] in a `Blob` and returns its object URL — the web
/// equivalent of writing a temp file, renderable directly via
/// `Image.network` (Flutter's web `NetworkImage` renders `blob:` URLs
/// through the browser's own `<img>` element).
Future<String> saveAvatarImageBytes(Uint8List bytes) async {
  final blob = html.Blob([bytes], 'image/png');
  return html.Url.createObjectUrlFromBlob(blob);
}
