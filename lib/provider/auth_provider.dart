import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  String _token = "";
  int expires_in = 0;

  bool get isAuth {
    return _token.isNotEmpty;
  }

  Future<void> _authenticattion(
      String email, String password, String type) async {
    try {
      const url = 'http://apiforlearning.zendvn.com/api/auth/login';
      final res = await http.post(Uri.parse(url),
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8"
          },
          body: jsonEncode({"email": email, "password": password}));

      final jsonData = jsonDecode(res.body);

      _token = jsonData["access_token"];
      expires_in = jsonData["expires_in"];
      notifyListeners();
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      final userData = jsonEncode({"token": _token});
      await prefs.setString("userData", userData);
    } catch (e) {
      Future.error(e);
    }
  }

  void login(String email, String password) {
    _authenticattion(email, password, "login");
  }

  Future<bool> autoLogin() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      if (!prefs.containsKey("userData")) {
        return false;
      }

      // final userData = jsonDecode(prefs.getString("userData") ?? "");
      return true;
    } catch (e) {
      return false;
    }
  }

  void logout() async {
    _token = "";
    expires_in = 0;
    notifyListeners();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove("userData");
  }
}
