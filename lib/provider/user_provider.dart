import 'package:flutter/cupertino.dart';
import 'package:ludo_app/models/user.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(
    id: '',
    name: '',
    email: '',
    password: '',
  );

  User get user => _user;

  void setUser(String data) {
    _user = User.fromJson(data);
    notifyListeners();
  }

  void setUserFromMap(Map<String, dynamic> data) {
    _user = User.fromMap(data);
  }

  void setUserFromModel(User user) {
    _user = user;
    notifyListeners();
  }
}
