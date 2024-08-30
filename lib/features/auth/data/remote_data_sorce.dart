import 'package:task_manager/common/api/api_endpoints.dart';
import 'package:task_manager/common/utils/api_service.dart';
import 'package:task_manager/features/auth/data/models/login_request_model.dart';
import 'package:task_manager/features/auth/data/models/user-model.dart';
import 'package:task_manager/features/auth/domain/entities/login_entity.dart';

abstract class LoginRemoteDataSource {
  Future<UserModel> postLoginData(LoginRequestModel loginRequestModel);
}

class LoginDataSourceImpl extends LoginRemoteDataSource {
  final ApiService apiService;

  LoginDataSourceImpl(this.apiService);
  @override
  Future<UserModel> postLoginData(LoginRequestModel loginRequestModel) async {
    var response = await apiService.post(
        endPoint: Endpoints.login, data: loginRequestModel.toJson());
    UserModel user = UserModel.fromJson(response);
    return UserModel.fromJson(response);
  }
}
