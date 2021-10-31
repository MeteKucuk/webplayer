import 'dart:io';

import 'package:path_provider/path_provider.dart';

class FileSupplier {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get cacheFile async {
    final path = await _localPath;
    return File('$path/counter.txt');
  }
}
