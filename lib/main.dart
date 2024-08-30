import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/common/utils/cache_helper.dart';
import 'package:task_manager/common/utils/service_locator.dart';
import 'package:task_manager/features/auth/data/repo_impl/auth_repo_impl.dart';
import 'package:task_manager/features/auth/domain/use_cases/auth_use_case.dart';
import 'package:task_manager/features/auth/presentation/controller/login_cubit/login_cubit.dart';
import 'package:task_manager/features/home/data/home_repo_impl/home_repo_impl.dart';
import 'package:task_manager/features/home/domain/usecases/home_usecase.dart';
import 'package:task_manager/features/home/presentation/controller/home_cubit/home_cubit.dart';

import 'features/auth/presentation/views/auth_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();

  setupServiceLocator();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => AuthCubit(
                  LoginUseCase(
                    getIt.get<AuthRepoImpl>(),
                  ),
                )),
        BlocProvider(
            create: (context) => HomeCubit(
                  HomeUseCase(
                    getIt.get<HomeRepoImpl>(),
                  ),
                )),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: Colors.blueAccent,
          ),
          useMaterial3: false,
        ),
        home: LoginScreen(),
      ),
    );
  }
}
