import 'package:shared_preferences/shared_preferences.dart';

import '../models/login_model.dart';

class AuthLocalDatasource {
  final key = 'auth_data';

  Future<void> saveAuthData(LoginModel loginModel) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, loginModel.toJson());
  }

  Future<void> removeAuthData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }

  Future<LoginModel?> getAuthData() async {
    final prefs = await SharedPreferences.getInstance();
    final authData = prefs.getString(key);
    if (authData != null) {
      return LoginModel.fromJson(authData);
    } else {
      return null;
    }
  }

  Future<bool> isAuth() async {
    final prefs = await SharedPreferences.getInstance();
    final authData = prefs.getString(key);
    if (authData != null) {
      return true;
    } else {
      return false;
    }
  }
}
