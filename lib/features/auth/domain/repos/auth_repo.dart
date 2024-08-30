import 'package:dartz/dartz.dart';
import 'package:task_manager/common/errors/failure.dart';
import 'package:task_manager/features/auth/data/models/login_request_model.dart';
import 'package:task_manager/features/auth/data/models/user-model.dart';

abstract class AuthRepo {
  Future<Either<Failure, UserModel>> login(LoginRequestModel loginRequestModel);
}
