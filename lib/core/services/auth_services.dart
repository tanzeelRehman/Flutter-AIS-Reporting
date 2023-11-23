import 'dart:async';
import 'dart:convert';
import 'package:ais_reporting/core/services/secure_storage_service.dart';
import 'package:ais_reporting/core/services/user_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../features/authentication/login/data/modals/login_response_modal.dart';


class AuthServices {
  final _secureStorage = SecureStorageService();

  /// This method is to check if user is logged in or not, will return null if no user found
  Future<LoginResponseModel?> checkIfUserLoggedIn() async {
    final result = await _secureStorage.read(key: 'user');
    if (result == null) {
      return null;
    } else {
      final map = jsonDecode(result);
      return LoginResponseModel.fromJson(map);
    }
  }

  Future<void> logoutUser(BuildContext context) async {
    _secureStorage.delete(key: 'user');
    context.read<UserProvider>().setLoggedInUser(null);
  }
}
