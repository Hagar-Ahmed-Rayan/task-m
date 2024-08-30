import 'package:dartz/dartz.dart';
import 'package:task_manager/common/errors/failure.dart';
import 'package:task_manager/features/auth/data/models/login_request_model.dart';
import 'package:task_manager/features/auth/data/models/user-model.dart';
import 'package:task_manager/features/auth/domain/entities/login_entity.dart';
import 'package:task_manager/features/auth/domain/repos/auth_repo.dart';



class LoginUseCase  {
  final AuthRepo authRepo;

  LoginUseCase(this.authRepo);

  @override
  Future<Either<Failure, UserModel>> postLoginData(LoginRequestModel loginRequestModel ) async {
    return await authRepo.login(
        loginRequestModel
    );
  }
}