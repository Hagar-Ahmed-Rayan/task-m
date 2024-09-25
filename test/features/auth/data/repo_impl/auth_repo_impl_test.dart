import 'package:flutter_test/flutter_test.dart';
import 'package:task_manager/common/utils/api_service.dart';
import 'package:task_manager/common/utils/service_locator.dart';
import 'package:task_manager/features/auth/data/models/login_request_model.dart';
import 'package:task_manager/features/auth/data/remote_data_sorce.dart';
import 'package:task_manager/features/auth/data/repo_impl/auth_repo_impl.dart';

void main() {
  setupServiceLocator();

  test('login', () async{
    final loginRequest = LoginRequestModel(

      username: 'emilys',
      password: 'emilyspass',
      expiresInMins: 30, // optional, defaults to 60

    );
    final authRepoImplTest=await AuthRepoImpl(

      loginRemoteDataSource: LoginDataSourceImpl(
        getIt.get<ApiService>(),
      ),
    ).login(loginRequest);

    expect(authRepoImplTest.isRight(), true);

  });
}