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
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        children: [
          Container(
            height: 89,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.primary,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.light,
                      width: 3,
                    ),
                  ),
                  child: CircleAvatar(
                    radius: 30,
                    child: ClipOval(
                      child: Image.network(
                        'https://cdn-icons-png.flaticon.com/512/4128/4128349.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const SpaceWidth(width: 12),
                BlocBuilder<UserBloc, UserState>(
                  builder: (context, state) {
                    if (state is UserLoading) {
                      return const CircleLoading();
                    }
                    if (state is UserLoaded) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            state.user.name!,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: AppColors.light,
                            ),
                          ),
                          const SpaceHeight(height: 4),
                          Text(
                            state.user.email!,
                            style: const TextStyle(
                              fontSize: 14,
                              color: AppColors.light,
                            ),
                          ),
                        ],
                      );
                    }
                    return const SizedBox();
                  },
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.edit,
                    color: AppColors.light,
                  ),
                ),
              ],
            ),
          ),
          const SpaceHeight(height: 30),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.white,
              boxShadow: [
                BoxShadow(
                  color: AppColors.black.withOpacity(0.2),
                  blurRadius: 6,
                ),
              ],
            ),
            child: Column(
              children: [
                ListTileItem(
                  label: 'Your Profile',
                  leading: Assets.icons.user.svg(
                    colorFilter: const ColorFilter.mode(
                      AppColors.primary,
                      BlendMode.srcIn,
                    ),
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 16,
                    color: AppColors.primary,
                  ),
                  onTap: () {
                    context.pushNamed(
                      RouteConstants.profileDetail,
                      pathParameters: PathParameters(
                        rootTab: RootTab.profile,
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
                  trailing: const Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 16,
                    color: AppColors.primary,
                  ),
                  onTap: () {
                    context.pushNamed(
                      RouteConstants.orderList,
                      pathParameters: PathParameters(
                        rootTab: RootTab.profile,
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
                  trailing: const Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 16,
                    color: AppColors.primary,
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
                  trailing: const Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 16,
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
                      trailing: const Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 16,
                        color: AppColors.primary,
                      ),
                      onTap: () {
                        context.read<LogoutBloc>().add(OnLogoutEvent());
                      },
                    );
                  },
                ),
              ],
            ),
          ),
          const SpaceHeight(height: 20),
          const Text(
            'More',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SpaceHeight(height: 20),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.white,
              boxShadow: [
                BoxShadow(
                  color: AppColors.black.withOpacity(0.2),
                  blurRadius: 6,
                ),
              ],
            ),
            child: Column(
              children: [
                ListTileItem(
                  label: 'Legal and Policies',
                  leading: const Icon(
                    Icons.shield_outlined,
                    color: AppColors.primary,
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 16,
                    color: AppColors.primary,
                  ),
                  onTap: () {},
                ),
                const SpaceHeight(height: 8),
                ListTileItem(
                  label: 'Help & Support',
                  leading: const Icon(
                    Icons.contact_support_outlined,
                    color: AppColors.primary,
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 16,
                    color: AppColors.primary,
                  ),
                  onTap: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
