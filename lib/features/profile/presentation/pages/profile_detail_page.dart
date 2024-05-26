import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlineshop_app/core/components/circle_loading.dart';
import 'package:onlineshop_app/core/components/components.dart';
import 'package:onlineshop_app/features/profile/presentation/widgets/list_tile_item.dart';

import '../../../../core/assets/assets.gen.dart';
import '../../../../core/constants/app_colors.dart';
import '../bloc/user/user_bloc.dart';

class ProfileDetailPage extends StatefulWidget {
  const ProfileDetailPage({super.key});

  @override
  State<ProfileDetailPage> createState() => _ProfileDetailPageState();
}

class _ProfileDetailPageState extends State<ProfileDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Profile'),
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
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
              radius: 40,
              child: ClipOval(
                child: Image.network(
                  'https://cdn-icons-png.flaticon.com/512/4128/4128349.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SpaceHeight(height: 20),
          BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              if (state is UserLoading) {
                return const CircleLoading();
              }
              if (state is UserLoaded) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Username',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SpaceHeight(height: 10),
                    Card.outlined(
                      child: ListTileItem(
                        label: state.user.name!,
                        onTap: () {},
                        leading: Assets.icons.user.svg(
                          colorFilter: const ColorFilter.mode(
                            AppColors.primary,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),
                    const SpaceHeight(height: 20),
                    const Text(
                      'Email',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SpaceHeight(height: 10),
                    Card.outlined(
                      child: ListTileItem(
                        label: state.user.email!,
                        onTap: () {},
                        leading: const Icon(
                          Icons.email_outlined,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                    const SpaceHeight(height: 20),
                    const Text(
                      'Phone',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SpaceHeight(height: 10),
                    Card.outlined(
                      child: ListTileItem(
                        label: state.user.phone!,
                        onTap: () {},
                        leading: const Icon(
                          Icons.phone,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ],
                );
              }
              return const SizedBox();
            },
          ),
        ],
      ),
    );
  }
}
