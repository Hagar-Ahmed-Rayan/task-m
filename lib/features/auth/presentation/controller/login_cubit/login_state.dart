

import 'package:task_manager/features/auth/data/models/user-model.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}



class AuthFailure extends AuthState {
  final String errMessage;

  AuthFailure(this.errMessage);
}

class AuthSuccess extends AuthState {
  UserModel userModel;
  AuthSuccess(this.userModel);
}