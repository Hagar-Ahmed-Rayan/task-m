import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:task_manager/common/utils/cache_helper.dart';
import 'package:task_manager/features/auth/data/models/login_request_model.dart';
import 'package:task_manager/features/auth/domain/use_cases/auth_use_case.dart';
import 'package:task_manager/features/auth/presentation/controller/login_cubit/login_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.loginUseCase) : super(AuthInitial());
  static AuthCubit get(context) => BlocProvider.of(context);
  final formKey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final LoginUseCase loginUseCase;
  Future<void> login(LoginRequestModel loginRequestModel) async {
    emit(AuthLoading());

    var result = await loginUseCase.postLoginData(loginRequestModel);
    result.fold((failure) {
      emit(AuthFailure(failure.message));
    }, (userModel) {
      userModel.token;
      saveToShared(userModel.token!);

      emit(AuthSuccess(userModel));
    });
  }

  void saveToShared(String token) {
    CacheHelper.saveData(key: 'token', value: token);
    Fluttertoast.showToast(
      msg: "Authentication sucess",
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  void validateLoginData() {
    if (formKey.currentState!.validate()) {
      String username = usernameController.text;
      String password = passwordController.text;
      final loginRequest = LoginRequestModel(
        username: username,
        password: password,
      );
      login(loginRequest);
    } else {
      print("Form is not valid");
    }
  }
}
