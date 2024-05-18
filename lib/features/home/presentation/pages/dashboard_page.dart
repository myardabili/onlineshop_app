import 'package:flutter/material.dart';
import 'package:onlineshop_app/features/profile/presentation/pages/profile_page.dart';

import '../../../../core/assets/assets.gen.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../orders/presentation/pages/cart_page.dart';
import 'home_page.dart';

class DashboardPage extends StatefulWidget {
  final int currentTab;
  const DashboardPage({
    super.key,
    required this.currentTab,
  });

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late int _selectedIndex;
  final List<Widget> _pages = [
    const HomePage(),
    const Center(
      child: Text('This Page 2'),
    ),
    const CartPage(),
    const ProfilePage(),
  ];

  void _onItemTapped(int index) {
    _selectedIndex = index;
    setState(() {});
  }

  @override
  void initState() {
    _selectedIndex = widget.currentTab;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: _pages),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        selectedItemColor: AppColors.primary,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Assets.icons.home.svg(
              colorFilter: const ColorFilter.mode(
                AppColors.grey,
                BlendMode.srcIn,
              ),
            ),
            activeIcon: Assets.icons.home.svg(),
            label: 'HOME',
          ),
          BottomNavigationBarItem(
            icon: Assets.icons.search.svg(
              colorFilter: const ColorFilter.mode(
                AppColors.grey,
                BlendMode.srcIn,
              ),
            ),
            activeIcon: Assets.icons.search.svg(),
            label: 'EXPLORE',
          ),
          BottomNavigationBarItem(
            icon: Assets.icons.order.svg(
              colorFilter: const ColorFilter.mode(
                AppColors.grey,
                BlendMode.srcIn,
              ),
            ),
            activeIcon: Assets.icons.order.svg(),
            label: 'ORDER',
          ),
          BottomNavigationBarItem(
            icon: Assets.icons.person.svg(
              colorFilter: const ColorFilter.mode(
                AppColors.grey,
                BlendMode.srcIn,
              ),
            ),
            activeIcon: Assets.icons.person.svg(),
            label: 'PROFILE',
          ),
        ],
      ),
    );
  }
}
