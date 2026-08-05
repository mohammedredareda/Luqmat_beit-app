// Persists cropped avatar PNG bytes somewhere renderable by
// `Image.network` (web) or `Image.file` (mobile/desktop), returning that
// path/URL — implemented per-platform since web has no filesystem to
// write to. See `saveAvatarImageBytes` in the platform-specific file.
export 'avatar_image_saver_io.dart' if (dart.library.html) 'avatar_image_saver_web.dart';
