import 'package:dartz/dartz.dart';

import 'package:dio/dio.dart';
import 'package:task_manager/common/errors/failure.dart';
import 'package:task_manager/features/auth/data/models/login_request_model.dart';
import 'package:task_manager/features/auth/data/models/user-model.dart';
import 'package:task_manager/features/auth/data/remote_data_sorce.dart';
import 'package:task_manager/features/auth/domain/repos/auth_repo.dart';

class AuthRepoImpl extends AuthRepo {
  final LoginRemoteDataSource loginRemoteDataSource;

  AuthRepoImpl({required this.loginRemoteDataSource});

  @override
  Future<Either<Failure, UserModel>> login(
      LoginRequestModel loginRequestModel) async {
    UserModel? userModel;

    try {
       userModel=await loginRemoteDataSource.postLoginData(loginRequestModel);

      return right(userModel);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDiorError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }
}
