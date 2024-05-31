import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/assets/assets.gen.dart';
import '../../../../core/components/buttons.dart';
import '../../../../core/components/circle_loading.dart';
import '../../../../core/components/spaces.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/router/app_router.dart';
import '../../data/models/register_request_model.dart';
import '../bloc/register/register_bloc.dart';
import '../widgets/custom_textformfield.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final nameController = TextEditingController();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  'Create Account',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SpaceHeight(height: 10.0),
              const Center(
                child: Text(
                  'Fill your information below to create a new account.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SpaceHeight(height: 30.0),
              const Text(
                'Name',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SpaceHeight(height: 10.0),
              CustomTextFormField(
                controller: nameController,
                hintText: 'John Doe',
              ),
              const SpaceHeight(height: 20.0),
              const Text(
                'Email',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SpaceHeight(height: 10.0),
              CustomTextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                hintText: 'example@gmail.com',
              ),
              const SpaceHeight(height: 20.0),
              const Text(
                'Phone Number',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SpaceHeight(height: 10.0),
              CustomTextFormField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                hintText: '085*******',
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
                obscureText: true,
                hintText: '**********',
              ),
              const SpaceHeight(height: 30.0),
              BlocConsumer<RegisterBloc, RegisterState>(
                builder: (context, state) {
                  if (state is RegisterLoading) {
                    return const Center(
                      child: CircleLoading(),
                    );
                  }
                  return Button.filled(
                    onPressed: () {
                      final requestModel = RegisterRequestModel(
                        name: nameController.text,
                        email: emailController.text,
                        password: passwordController.text,
                        phone: phoneController.text,
                      );
                      context.read<RegisterBloc>().add(OnRegister(
                            model: requestModel,
                          ));
                    },
                    label: 'Sign Up',
                  );
                },
                listener: (context, state) {
                  if (state is RegisterFailure) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(state.message)));
                  }
                  if (state is RegisterLoaded) {
                    context.goNamed(RouteConstants.login);
                  }
                },
              ),
              const SpaceHeight(height: 40.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Already have an account?',
                    style: TextStyle(
                      color: AppColors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SpaceWidth(width: 4),
                  InkWell(
                    onTap: () {
                      context.goNamed(RouteConstants.login);
                    },
                    child: const Text(
                      'Sign In',
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
    );
  }
}
