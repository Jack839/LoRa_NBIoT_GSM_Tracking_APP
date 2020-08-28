
import 'package:flutter/widgets.dart';
import 'package:lora_gpstracking2/models/user.dart';
import 'package:lora_gpstracking2/services/user.dart';

class AuthNotifier with ChangeNotifier {
  User _user;

  User get user => _user;

  void setUser(User user) {
    _user = user;
    notifyListeners();
  }
}