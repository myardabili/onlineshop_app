import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:onlineshop_app/features/home/presentation/bloc/all_product/all_product_bloc.dart';
import 'package:onlineshop_app/features/home/presentation/widgets/organism/header.dart';
import 'package:onlineshop_app/features/home/presentation/widgets/organism/product_best_seller.dart';
import 'package:onlineshop_app/features/home/presentation/widgets/organism/product_list.dart';

import '../../../../core/assets/assets.gen.dart';
import '../../../../core/components/search_input.dart';
import '../../../../core/components/spaces.dart';
import '../../../../core/router/app_router.dart';
import '../widgets/banner_slider.dart';
import '../widgets/organism/menu_categories.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late TextEditingController searchController;

  final List<String> banners1 = [
    Assets.images.banner1.path,
    Assets.images.banner1.path,
  ];
  final List<String> banners2 = [
    Assets.images.banner2.path,
    Assets.images.banner2.path,
    Assets.images.banner2.path,
  ];

  @override
  void initState() {
    context.read<AllProductBloc>().add(OnGetAllProduct());
    searchController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20.0),
          children: [
            const Header(),
            const SpaceHeight(height: 30.0),
            SearchInput(
              controller: searchController,
              onTap: () {
                context.pushReplacementNamed(
                  RouteConstants.root,
                  pathParameters: PathParameters(
                    rootTab: RootTab.explore,
                  ).toMap(),
                );
              },
            ),
            const SpaceHeight(height: 30.0),
            const MenuCategories(),
            const SpaceHeight(height: 30.0),
            BannerSlider(items: banners1),
            // const SpaceHeight(height: 30.0),
            // TitleContent(
            //   title: 'Categories',
            //   onSeeAllTap: () {},
            // ),
            const SpaceHeight(height: 30.0),
            const Text(
              'Best Seller',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SpaceHeight(height: 30.0),
            const ProductBestSeller(),
            const SpaceHeight(height: 30.0),
            const ProductList(),
          ],
        ),
      ),
    );
  }
}
