import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tiny_gift/view/bloc/auth_bloc.dart';
import 'package:tiny_gift/view/pages/main_page.dart';

class LoginPage extends StatelessWidget {

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthInitial) {
            return Center(
              child: Column(
                children: [
                  TextField(
                    controller: usernameController,
                    decoration: InputDecoration(labelText: "Username"),
                  ),
                  TextField(
                    controller: passwordController,
                    decoration: InputDecoration(labelText: "Password"),
                    obscureText: true,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      final username = usernameController.text;
                      final password = passwordController.text;
                      BlocProvider.of<AuthBloc>(context).add(
                        AuthenticateUserEvent(username, password),
                      );
                    },
                    child: Text("Login"),
                  ),
                ],
              ),
            );
          } else if (state is Authenticated) {
            // return Center(child: Text('Authenticated: ${state.token}'));
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => MyHomePage(title:  usernameController.text),
                ),
              );
            });
          } else if (state is AuthFailure) {
            return Center(child: Text('Failed: ${state.message}'));
          }
          return Container();
        },
      ),
    );
  }
}
