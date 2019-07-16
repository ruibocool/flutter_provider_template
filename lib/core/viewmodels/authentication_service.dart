import 'dart:async';

import 'package:flutter_provider_template/core/models/user.dart';
import 'package:flutter_provider_template/core/services/api.dart';
import 'package:flutter_provider_template/core/viewmodels/base_model.dart';

class AuthenticationService extends BaseModel {
  final Api _api;

  AuthenticationService({Api api}) : _api = api;

  StreamController<User> _userController = StreamController<User>();

  Stream<User> get user => _userController.stream;

  Future<bool> login(int userId) async {
    setBusy(true);
    var fetchedUser = await _api.getUserProfile(userId);

    var hasUser = fetchedUser != null;
    if (hasUser) {
      _userController.add(fetchedUser);
    }
    setBusy(false);
    return hasUser;
  }
}
