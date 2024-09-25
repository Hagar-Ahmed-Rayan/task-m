import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/common/utils/service_locator.dart';
import 'package:task_manager/features/auth/data/repo_impl/auth_repo_impl.dart';
import 'package:task_manager/features/auth/domain/use_cases/auth_use_case.dart';
import 'package:task_manager/features/auth/presentation/controller/login_cubit/login_cubit.dart';
import 'package:task_manager/features/auth/presentation/controller/login_cubit/login_state.dart';
import 'package:task_manager/features/auth/presentation/views/widgets/custom_text_field.dart';
import 'package:task_manager/features/home/presentation/views/home_view.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: BlocProvider(
        create: (context) => AuthCubit(
          LoginUseCase(
            getIt.get<AuthRepoImpl>(),
          ),
        ),
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
         if (state is AuthFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.errMessage)),
              );
            } else if (state is AuthSuccess) {
            //  AuthCubit.get(context).saveToShared(state.userModel.token!);


              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HomeView()),
              );
            }
          },
          builder: (context, state) {
            return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: BlocProvider.of<AuthCubit>(context)
                      .formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CustomTextField(
                        controller: BlocProvider.of<AuthCubit>(context)
                            .usernameController,
                        hintText: 'Enter your Username',
                        isPassword: false,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your username';
                          }

                          return null;
                        },
                      ),
                      CustomTextField(
                        hintText: 'Enter your Password',
                        controller: BlocProvider.of<AuthCubit>(context)
                            .passwordController,
                        isPassword: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }

                          return null;
                        },
                      ),

                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          BlocProvider.of<AuthCubit>(context)
                              .validateLoginData();
                        },
                        child: const Text('Login'),
                      ),
                    ],
                  ),
                ));
          },
        ),
      ),
    );
  }
}

