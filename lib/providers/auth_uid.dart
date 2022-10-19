import 'package:flutter/cupertino.dart';

class AuthUID with ChangeNotifier {
  //Set the uid returned by Firebase here.
  //Maintain a single copy of it.
  String _uid = '';

  //Username
  String _username = '';

  //Did fetch once
  bool _fetchedOnce = false;

  String get uid {
    return _uid;
  }

  String get username {
    return _username;
  }

  bool get fetchedOnce {
    return _fetchedOnce;
  }

  void setUid(String id) {
    _uid = id;
  }

  void setUsername(String username) {
    _username = username;
    notifyListeners();
  }

  void setFetchedOnce(bool fetchedOnce) {
    _fetchedOnce = fetchedOnce;
  }
}
