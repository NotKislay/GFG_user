import 'package:path_provider/path_provider.dart';

class DownloadsPath {
  static String? _downloadsPath;

  static Future<void> init() async {
    final dir = await getDownloadsDirectory();
    _downloadsPath = dir?.path;
  }

  static String? get path => _downloadsPath;
}
