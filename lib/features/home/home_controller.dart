import 'package:flutter/material.dart';
import 'package:flutter_mastering_course/core/constants/storage_keys.dart';
import 'package:flutter_mastering_course/core/services/preferences_manager.dart';
import 'package:flutter_mastering_course/model/task_model.dart';

class HomeController with ChangeNotifier {
  List<TaskModel> tasksList = [];
  String? username;
  String? userImagePath;

  bool isLoading = false;

  void init() {
    loadUserData();
  }

  void loadUserData() async {
    username = PreferencesManager().getString(StorageKeys.username);
    userImagePath = PreferencesManager().getString(StorageKeys.imagePath);

    notifyListeners();
  }
}
