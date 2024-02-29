import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onlineshop_app/core/router/app_router.dart';
import 'package:onlineshop_app/features/home/data/datasources/category_remote_datasource.dart';
import 'package:onlineshop_app/features/home/data/datasources/product_remote_datasource.dart';
import 'package:onlineshop_app/features/home/presentation/bloc/all_product/all_product_bloc.dart';
import 'package:onlineshop_app/features/home/presentation/bloc/checkout/checkout_bloc.dart';
import 'package:onlineshop_app/features/home/presentation/bloc/category/category_bloc.dart';
import 'package:onlineshop_app/features/home/presentation/bloc/product_category/product_category_bloc.dart';

import 'core/constants/app_colors.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appRouter = AppRouter();
    final router = appRouter.router;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => CategoryBloc(CategoryRemoteDatasource()),
        ),
        BlocProvider(
          create: (_) => AllProductBloc(ProductRemoteDatasource()),
        ),
        BlocProvider(
          create: (_) => ProductCategoryBloc(ProductRemoteDatasource()),
        ),
        BlocProvider(
          create: (_) => CheckoutBloc(),
        ),
      ],
      child: MaterialApp.router(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
          textTheme: GoogleFonts.dmSansTextTheme(
            Theme.of(context).textTheme,
          ),
          appBarTheme: AppBarTheme(
            color: AppColors.white,
            titleTextStyle: GoogleFonts.quicksand(
              color: AppColors.primary,
              fontSize: 18.0,
              fontWeight: FontWeight.w700,
            ),
            iconTheme: const IconThemeData(
              color: AppColors.black,
            ),
            centerTitle: true,
            shape: Border(
              bottom: BorderSide(
                color: AppColors.black.withOpacity(0.05),
              ),
            ),
          ),
        ),
        routerDelegate: router.routerDelegate,
        routeInformationParser: router.routeInformationParser,
        routeInformationProvider: router.routeInformationProvider,
        // home: const TestPage(),
      ),
    );
  }
}
