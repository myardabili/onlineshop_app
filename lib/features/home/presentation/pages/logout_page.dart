import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:onlineshop_app/core/router/app_router.dart';
import 'package:onlineshop_app/features/auth/presentation/bloc/logout/logout_bloc.dart';
import 'package:onlineshop_app/features/home/presentation/widgets/circle_loading.dart';

class LogoutPage extends StatefulWidget {
  const LogoutPage({super.key});

  @override
  State<LogoutPage> createState() => _LogoutPageState();
}

class _LogoutPageState extends State<LogoutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocConsumer<LogoutBloc, LogoutState>(
          listener: (context, state) {
            if (state is LogoutFailure) {
              context.goNamed(
                RouteConstants.login,
                // pathParameters: PathParameters().toMap(),
              );
              // ScaffoldMessenger.of(context)
              //     .showSnackBar(SnackBar(content: Text(state.message)));
            }
            if (state is LogoutLoaded) {
              context.goNamed(RouteConstants.root,
                  pathParameters: PathParameters().toMap());
            }
          },
          builder: (context, state) {
            if (state is LogoutLoading) {
              return const CircleLoading();
            }
            return ElevatedButton(
              onPressed: () {
                context.read<LogoutBloc>().add(OnLogoutEvent());
              },
              child: const Text('Logout'),
            );
          },
        ),
      ),
    );
  }
}
