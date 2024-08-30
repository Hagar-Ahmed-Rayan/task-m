import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:task_manager/common/utils/api_service.dart';
import 'package:task_manager/features/auth/data/remote_data_sorce.dart';
import 'package:task_manager/features/auth/data/repo_impl/auth_repo_impl.dart';
import 'package:task_manager/features/home/data/home_repo_impl/home_repo_impl.dart';
import 'package:task_manager/features/home/data/remote_data_source/remote_data_source.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerSingleton<ApiService>(
    ApiService(
      Dio(),
    ),
  );
  getIt.registerSingleton<AuthRepoImpl>(
    AuthRepoImpl(
      loginRemoteDataSource: LoginDataSourceImpl(
        getIt.get<ApiService>(),
      ),
    ),
  );
  getIt.registerSingleton<HomeRepoImpl>(
    HomeRepoImpl(
      homeRemoteDataSource: HomeRemoteDataSourceImpl(
        getIt.get<ApiService>(),
      ),
    ),
  );
}
