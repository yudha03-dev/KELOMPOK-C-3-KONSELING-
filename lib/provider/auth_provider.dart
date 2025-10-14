import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  String? _username;
  String? _password;
  bool _isLoggedIn = false;

  String? get username => _username;
  bool get isLoggedIn => _isLoggedIn;

  // register user (disimpan lokal)
  bool register(String username, String password) {
    if (username.isEmpty || password.isEmpty) return false;
    _username = username;
    _password = password;
    notifyListeners();
    return true;
  }

  // login user
  bool login(String username, String password) {
    if (username == _username && password == _password) {
      _isLoggedIn = true;
      notifyListeners();
      return true;
    }
    return false;
  }

  // logout
  void logout() {
    _isLoggedIn = false;
    notifyListeners();
  }
}
