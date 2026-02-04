import 'dart:io';

import 'package:path_provider/path_provider.dart';

class FileStorageManager {
  static final FileStorageManager _instance = FileStorageManager._();

  FileStorageManager._();

  factory FileStorageManager() {
    return _instance;
  }

  late final Directory _appDocumentsDirectory;
  late final File _path;

  Future<void> init() async {
    _appDocumentsDirectory = await getApplicationDocumentsDirectory();

    _path = File("${_appDocumentsDirectory.path}/tasks.json");
  }
}
