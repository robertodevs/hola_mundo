import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hola_mundo/authentication/services/login_service.dart';

class LoginBloc {
  final ValueNotifier<bool> isLoading = ValueNotifier(false);

  final LoginService loginService;

  LoginBloc({required this.loginService});

  Future<void> login(String email, String password) async {
    isLoading.value = true;
    await loginService.login(email, password);
    isLoading.value = false;
  }

  Future<void> logout() async {
    await loginService.logout();
  }

  Stream<User?> get onAuthStateChanged => loginService.onAuthStateChanged;
}
