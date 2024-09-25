import 'package:flutter_test/flutter_test.dart';
import 'package:task_manager/common/utils/api_service.dart';
import 'package:task_manager/common/utils/service_locator.dart';
import 'package:task_manager/features/auth/data/models/login_request_model.dart';
import 'package:task_manager/features/auth/data/remote_data_sorce.dart';

void main() {

  final loginRequest = LoginRequestModel(

    username: 'emilys',
    password: 'emilyspass',
    expiresInMins: 30, // optional, defaults to 60

  );

  setupServiceLocator();


  test('LoginRemoteDataSource', () async {
    final loginRemoteDataSourceTest=await LoginDataSourceImpl(getIt.get<ApiService>()).postLoginData(loginRequest);
    expect(loginRemoteDataSourceTest.gender, "female");

  });
}



