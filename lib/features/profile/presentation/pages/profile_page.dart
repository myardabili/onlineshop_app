// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:onlineshop_app/core/components/spaces.dart';
import 'package:onlineshop_app/features/profile/presentation/bloc/user/user_bloc.dart';

import '../../../../core/assets/assets.gen.dart';
import '../../../../core/components/circle_loading.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/router/app_router.dart';
import '../../../auth/presentation/bloc/logout/logout_bloc.dart';
import '../widgets/list_tile_item.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    context.read<UserBloc>().add(OnGetUser());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          CircleAvatar(
            radius: 30,
            child: ClipOval(
              child: Image.network(
                'https://cdn-icons-png.flaticon.com/512/4128/4128349.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SpaceHeight(height: 12),
          BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              if (state is UserLoading) {
                return const CircleLoading();
              }
              if (state is UserLoaded) {
                return Center(
                  child: Text(
                    state.user.name!,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                );
              }
              return const Text('No user');
            },
          ),
          const SpaceHeight(height: 30),
          ListTileItem(
            label: 'Your Profile',
            leading: Assets.icons.user.svg(
              colorFilter: const ColorFilter.mode(
                AppColors.primary,
                BlendMode.srcIn,
              ),
            ),
            onTap: () {
              context.pushNamed(
                RouteConstants.orderList,
                pathParameters: PathParameters(
                  rootTab: RootTab.account,
                ).toMap(),
              );
            },
          ),
          const SpaceHeight(height: 8),
          ListTileItem(
            label: 'My Orders',
            leading: Assets.icons.bag.svg(
              colorFilter: const ColorFilter.mode(
                AppColors.primary,
                BlendMode.srcIn,
              ),
            ),
            onTap: () {
              context.pushNamed(
                RouteConstants.orderList,
                pathParameters: PathParameters(
                  rootTab: RootTab.account,
                ).toMap(),
              );
            },
          ),
          const SpaceHeight(height: 8),
          ListTileItem(
            label: 'Payment Method',
            leading: Assets.icons.creditcard.svg(
              colorFilter: const ColorFilter.mode(
                AppColors.primary,
                BlendMode.srcIn,
              ),
            ),
            onTap: () {},
          ),
          const SpaceHeight(height: 8),
          ListTileItem(
            label: 'Settings',
            leading: const Icon(
              Icons.settings_sharp,
              color: AppColors.primary,
            ),
            onTap: () {},
          ),
          const SpaceHeight(height: 8),
          BlocConsumer<LogoutBloc, LogoutState>(
            listener: (context, state) {
              if (state is LogoutFailure) {
                context.goNamed(
                  RouteConstants.login,
                );
              }
              if (state is LogoutLoaded) {
                context.goNamed(RouteConstants.root,
                    pathParameters: PathParameters().toMap());
              }
              return;
            },
            builder: (context, state) {
              if (state is LogoutLoading) {
                return const CircleLoading();
              }
              return ListTileItem(
                label: 'Logout',
                leading: const Icon(
                  Icons.login_outlined,
                ),
                onTap: () {
                  context.read<LogoutBloc>().add(OnLogoutEvent());
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
