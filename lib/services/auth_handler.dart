import 'package:shared_preferences/shared_preferences.dart';

class AuthHandler {
  static Future<String?> login(String username, String password) async {
    final prefs = await SharedPreferences.getInstance();
    final foundPassword = prefs.getString(username);
    if (foundPassword != password) {
      return "Username o password non validi";
    }
    return null;
  }

  static Future<String?> register(
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
    return null;
  }
}
