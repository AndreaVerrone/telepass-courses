import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthHandler extends ChangeNotifier {
  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;

  Future<String?> login(String username, String password) async {
    final prefs = await SharedPreferences.getInstance();
    final foundPassword = prefs.getString(username);
    if (foundPassword != password) {
      return "Username o password non validi";
    }
    _isLoggedIn = true;
    notifyListeners();
    return null;
  }

  Future<String?> register(
    String username,
    String password,
    String repeatedPassword,
  ) async {
    if (password != repeatedPassword) {
      return "Le password inserite sono diverse. Controlla che siano uguali e riprova";
    }
    final prefs = await SharedPreferences.getInstance();
    final alreadyUsed = prefs.getString(username) != null;
    if (alreadyUsed) {
      return "Esiste già un utente con questo username";
    }
    prefs.setString(username, password);
    _isLoggedIn = true;
    notifyListeners();
    return null;
  }

  void logout() {
    _isLoggedIn = false;
    notifyListeners();
  }
}
