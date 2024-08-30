import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/common/utils/cache_helper.dart';
import 'package:task_manager/features/auth/data/models/login_request_model.dart';
import 'package:task_manager/features/auth/presentation/controller/login_cubit/login_cubit.dart';
import 'package:task_manager/features/auth/presentation/controller/login_cubit/login_state.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:task_manager/features/home/presentation/views/home_view.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthLoading) {
            // Show loading indicator
            //showDialog(
              //context: context,
             // barrierDismissible: false,
              //builder: (context) =>


               //   Center(child: CircularProgressIndicator());
         //   );
          } else if (state is AuthFailure) {
            // Hide loading indicator and show error
            Navigator.of(context).pop(); // hide the loading indicator
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errMessage)),
            );
          } else if (state is AuthSuccess) {
            String token =state.userModel.token!;
            AuthCubit.get(context).saveToShared( token);


            CacheHelper.saveData( key: 'userId', value: state.userModel.id.toString());





            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomeView()),
            );


          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(labelText: 'Username'),
                ),
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    String username = _usernameController.text;
                    String password = _passwordController.text;
                    final loginRequest = LoginRequestModel(
                      username: username,
                      password: password,
                    );
                    AuthCubit.get(context).login(loginRequest);
                 //   BlocProvider.of<AuthCubit>(context).login(loginRequest);

                  },
                  child: Text('Login'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
