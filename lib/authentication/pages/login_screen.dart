import 'package:flutter/material.dart';
import 'package:hola_mundo/authentication/blocs/login_bloc.dart';
import 'package:hola_mundo/injector.dart';
import 'package:lottie/lottie.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  late LoginBloc _loginBloc;

  @override
  void initState() {
    super.initState();
    _loginBloc = Injector.get<LoginBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Lottie.asset(
                  'assets/login.json',
                  width: 200,
                  height: 200,
                ),
              ),
              Text(
                'Insert your credentials to login into your account',
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email is required';
                  }
                  if (!value.contains('@')) {
                    return 'Invalid email';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  hintText: 'Enter your password',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Password is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32.0),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ValueListenableBuilder(
                  valueListenable: _loginBloc.isLoading,
                  builder: (context, isLoading, child) {
                    return ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          try {
                            await _loginBloc.login(
                              _emailController.text,
                              _passwordController.text,
                            );
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(e.toString()),
                              ),
                            );
                          } finally {
                            _loginBloc.isLoading.value = false;
                          }
                        }
                      },
                      child: isLoading
                          ? const CircularProgressIndicator()
                          : const Text('Login'),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
