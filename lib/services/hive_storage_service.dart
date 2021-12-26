import 'package:flutter_web_navigation/services/hive/db.dart';

class HiveDataStorageService {
  static final HiveDataStorageService _instance = HiveDataStorageService._();

  static final HiveDataProvider _hiveDataProvider = HiveDataProvider();

  factory HiveDataStorageService() => _instance;

  HiveDataStorageService._();

  /// Method to set User
  static logUser(String email) async {
    await _hiveDataProvider.insertData("user", {"loggedIn": email});
  }

  /// Method to get User
  static getUser() async {
    Map response = await _hiveDataProvider.readData("user");
    return ((response.isNotEmpty ? response["loggedIn"] : '') ?? '');
  }

  static logOutUser() async {
    await _hiveDataProvider.deleteData("user");
  }
}
