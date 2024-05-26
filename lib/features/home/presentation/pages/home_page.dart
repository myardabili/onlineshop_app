import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlineshop_app/features/home/presentation/bloc/all_product/all_product_bloc.dart';
import 'package:onlineshop_app/features/home/presentation/widgets/organism/header.dart';
import 'package:onlineshop_app/features/home/presentation/widgets/organism/product_list.dart';

import '../../../../core/assets/assets.gen.dart';
import '../../../../core/components/spaces.dart';
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
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(20),
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: Header(),
          ),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          children: [
            BannerSlider(items: banners2),
            const SpaceHeight(height: 30.0),
            const MenuCategories(),
            const SpaceHeight(height: 30.0),
            const ProductList(),
          ],
        ),
      ),
    );
  }
}
