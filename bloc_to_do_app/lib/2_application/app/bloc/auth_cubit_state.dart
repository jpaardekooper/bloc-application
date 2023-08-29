part of 'auth_cubit.dart';

abstract class AuthCubitState {}

class AuthInitial extends AuthCubitState {
  final bool isLoggedIn;
  final String? userId;

  AuthInitial({required this.isLoggedIn, this.userId});
}
