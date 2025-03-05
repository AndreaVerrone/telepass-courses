import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:telepass_courses/services/course_service.dart';

class AuthHandler extends ChangeNotifier {
  bool _isLoggedIn = false;
  String _username = '';
  List<String> _savedCourses = [];

  bool get isLoggedIn => _isLoggedIn;
  String get username => _username;
  List<String> get savedCourses => [..._savedCourses];

  Future<String?> login(String username, String password) async {
    final prefs = await SharedPreferences.getInstance();
    final foundPassword = prefs.getString(username);
    if (foundPassword != password) {
      return "Username o password non validi";
    }
    _isLoggedIn = true;
    _username = username;
    _fetchSavedCourses();
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
    _username = username;
    _fetchSavedCourses();
    notifyListeners();
    return null;
  }

  void logout() {
    _isLoggedIn = false;
    notifyListeners();
  }

  Future<void> _fetchSavedCourses() async {
    final prefs = await SharedPreferences.getInstance();
    _savedCourses = prefs.getStringList(username) ?? [];
    notifyListeners();
  }

  Future<void> toggleSave(Course course) async {
    final prefs = await SharedPreferences.getInstance();
    final prevSaved = prefs.getStringList(username) ?? [];
    if (prevSaved.contains(course.id)) {
      prevSaved.remove(course.id);
    } else {
      prevSaved.add(course.id);
    }
    await prefs.setStringList(username, prevSaved);
    _fetchSavedCourses();
  }
}
