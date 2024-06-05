// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:onlineshop_app/core/components/circle_loading.dart';
import 'package:onlineshop_app/features/auth/data/datasource/auth_local_datasource.dart';
import 'package:onlineshop_app/features/auth/presentation/bloc/login/login_bloc.dart';
import 'package:onlineshop_app/features/profile/presentation/bloc/user/user_bloc.dart';

import '../../../../core/assets/assets.gen.dart';
import '../../../../core/components/buttons.dart';
import '../../../../core/components/spaces.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/router/app_router.dart';
import '../../../firebase_messaging/firebase_messaging_remote_datasource.dart';
import '../widgets/custom_textformfield.dart';

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
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Text(
                    'Sign In',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SpaceHeight(height: 10.0),
                const Center(
                  child: Text(
                    'Hi! Welcome back, you\'ve been missed',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SpaceHeight(height: 50.0),
                const Text(
                  'Email',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SpaceHeight(height: 10.0),
                CustomTextFormField(
                  controller: emailController,
                  hintText: 'example@gmail.com',
                  keyboardType: TextInputType.emailAddress,
                ),
                const SpaceHeight(height: 20.0),
                const Text(
                  'Password',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SpaceHeight(height: 10.0),
                CustomTextFormField(
                  controller: passwordController,
                  hintText: '************',
                  obscureText: true,
                  keyboardType: TextInputType.emailAddress,
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
                      context.read<UserBloc>().add(OnGetUser());
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
                        context.read<UserBloc>().add(OnGetUser());
                        context.read<LoginBloc>().add(OnLoginEvent(
                              email: emailController.text,
                              password: passwordController.text,
                            ));
                      },
                      label: 'Sign In',
                    );
                  },
                ),
                const SpaceHeight(height: 50.0),
                const Row(
                  children: [
                    Flexible(child: Divider()),
                    SizedBox(width: 14.0),
                    Text('Or sign in with'),
                    SizedBox(width: 14.0),
                    Flexible(child: Divider()),
                  ],
                ),
                const SpaceHeight(height: 40.0),
                Center(
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border:
                            Border.all(color: AppColors.light.withOpacity(0.5)),
                        image: DecorationImage(
                            image: Assets.images.google.provider())),
                  ),
                ),
                const SpaceHeight(height: 40.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Don\'t have an account?',
                      style: TextStyle(
                        color: AppColors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SpaceWidth(width: 4),
                    InkWell(
                      onTap: () {
                        context.goNamed(RouteConstants.register);
                      },
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.underline,
                            decorationColor: AppColors.primary),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
