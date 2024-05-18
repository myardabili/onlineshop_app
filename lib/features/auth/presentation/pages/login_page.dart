import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:onlineshop_app/features/auth/data/datasource/auth_local_datasource.dart';
import 'package:onlineshop_app/features/auth/presentation/bloc/login/login_bloc.dart';
import 'package:onlineshop_app/core/components/circle_loading.dart';

import '../../../../core/assets/assets.gen.dart';
import '../../../../core/components/buttons.dart';
import '../../../../core/components/spaces.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/router/app_router.dart';
import '../../../firebase_messaging/firebase_messaging_remote_datasource.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 40.0),
        children: [
          const Text(
            'Login Account',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Text(
            'Hello, welcome back to our account',
            style: TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SpaceHeight(height: 50.0),
          const SpaceHeight(height: 60.0),
          TextFormField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: 'Email ID',
              prefixIcon: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Assets.icons.email.svg(),
              ),
            ),
          ),
          const SpaceHeight(height: 20.0),
          TextFormField(
            controller: passwordController,
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Password',
              prefixIcon: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Assets.icons.password.svg(),
              ),
            ),
          ),
          const SpaceHeight(height: 50.0),
          BlocConsumer<LoginBloc, LoginState>(
            listener: (context, state) async {
              if (state is LoginFailure) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(state.message)));
              }
              if (state is LoginLoaded) {
                AuthLocalDatasource().saveAuthData(state.data);
                await FirebaseMessagingRemoteDatasource().initialize();
                context.goNamed(
                  RouteConstants.root,
                  pathParameters: PathParameters().toMap(),
                );
              }
            },
            builder: (context, state) {
              if (state is LoginLoading) {
                return const Center(
                  child: CircleLoading(),
                );
              }
              return Button.filled(
                onPressed: () {
                  context.read<LoginBloc>().add(OnLoginEvent(
                        email: emailController.text,
                        password: passwordController.text,
                      ));
                },
                label: 'Login',
              );
            },
          ),
          //   const SpaceHeight(height: 50.0),
          // const Row(
          //   children: [
          //     Flexible(child: Divider()),
          //     SizedBox(width: 14.0),
          //     Text('OR'),
          //     SizedBox(width: 14.0),
          //     Flexible(child: Divider()),
          //   ],
          // ),
          // const SpaceHeight(height: 50.0),
          // Button.outlined(
          //   onPressed: () {},
          //   label: 'Login with Google',
          //   icon: Assets.images.google.image(height: 20.0),
          // ),
          const SpaceHeight(height: 50.0),
          InkWell(
            onTap: () {
              context.goNamed(RouteConstants.register);
            },
            child: const Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'Not Registered yet? ',
                    style: TextStyle(
                      color: AppColors.primary,
                    ),
                  ),
                  TextSpan(
                    text: 'Create an Account',
                    style: TextStyle(
                      color: AppColors.grey,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
