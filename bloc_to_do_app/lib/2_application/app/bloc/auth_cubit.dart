import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_cubit_state.dart';

class AuthCubit extends Cubit<AuthCubitState> {
  AuthCubit() : super(AuthInitial(isLoggedIn: false)) {
    authStateChanged(alo: 'test');
  }

  void authStateChanged({String? alo}) {
    final bool isLoggedIn = true;
    emit(AuthInitial(isLoggedIn: isLoggedIn, userId: alo));

    debugPrint('fetchingData');
  }

  Future<void> initialize() async {
    debugPrint('fetchingData');
  }
}
