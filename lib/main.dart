import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onlineshop_app/core/router/app_router.dart';
import 'package:onlineshop_app/features/address/data/datasources/address_remote_datasource.dart';
import 'package:onlineshop_app/features/address/data/datasources/rajaongkir_remore_datasource.dart';
import 'package:onlineshop_app/features/address/presentation/bloc/add_address/add_address_bloc.dart';
import 'package:onlineshop_app/features/address/presentation/bloc/city/city_bloc.dart';
import 'package:onlineshop_app/features/address/presentation/bloc/get_address/get_address_bloc.dart';
import 'package:onlineshop_app/features/address/presentation/bloc/province/province_bloc.dart';
import 'package:onlineshop_app/features/address/presentation/bloc/subdistrict/subdistrict_bloc.dart';
import 'package:onlineshop_app/features/auth/data/datasource/auth_remote_datasource.dart';
import 'package:onlineshop_app/features/auth/presentation/bloc/login/login_bloc.dart';
import 'package:onlineshop_app/features/auth/presentation/bloc/logout/logout_bloc.dart';
import 'package:onlineshop_app/features/firebase_messaging/firebase_messaging_remote_datasource.dart';
import 'package:onlineshop_app/features/home/data/datasources/category_remote_datasource.dart';
import 'package:onlineshop_app/features/home/data/datasources/product_remote_datasource.dart';
import 'package:onlineshop_app/features/home/presentation/bloc/all_product/all_product_bloc.dart';
import 'package:onlineshop_app/features/home/presentation/bloc/checkout/checkout_bloc.dart';
import 'package:onlineshop_app/features/home/presentation/bloc/category/category_bloc.dart';
import 'package:onlineshop_app/features/home/presentation/bloc/product_category/product_category_bloc.dart';
import 'package:onlineshop_app/features/orders/data/datasources/cost_remote_datasource.dart';
import 'package:onlineshop_app/features/orders/data/datasources/order_remote_datasource.dart';
import 'package:onlineshop_app/features/orders/presentation/bloc/check_payment_status/check_payment_status_bloc.dart';
import 'package:onlineshop_app/features/orders/presentation/bloc/cost/cost_bloc.dart';
import 'package:onlineshop_app/features/orders/presentation/bloc/order/order_bloc.dart';

import 'core/constants/app_colors.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseMessagingRemoteDatasource().initialize();
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
          create: (contex) => CategoryBloc(CategoryRemoteDatasource()),
        ),
        BlocProvider(
          create: (contex) => AllProductBloc(ProductRemoteDatasource()),
        ),
        BlocProvider(
          create: (contex) => ProductCategoryBloc(ProductRemoteDatasource()),
        ),
        BlocProvider(
          create: (contex) => CheckoutBloc(),
        ),
        BlocProvider(
          create: (contex) => LoginBloc(AuthRemoteDatasource()),
        ),
        BlocProvider(
          create: (contex) => LogoutBloc(AuthRemoteDatasource()),
        ),
        BlocProvider(
          create: (contex) => GetAddressBloc(AddressRemoteDatasource()),
        ),
        BlocProvider(
          create: (contex) => AddAddressBloc(AddressRemoteDatasource()),
        ),
        BlocProvider(
          create: (contex) => ProvinceBloc(RajaongkirRemoteDatasource()),
        ),
        BlocProvider(
          create: (contex) => CityBloc(RajaongkirRemoteDatasource()),
        ),
        BlocProvider(
          create: (contex) => SubdistrictBloc(RajaongkirRemoteDatasource()),
        ),
        BlocProvider(
          create: (contex) => CheckoutBloc(),
        ),
        BlocProvider(
          create: (contex) => CostBloc(CostRemoteDatasource()),
        ),
        BlocProvider(
          create: (contex) => OrderBloc(OrderRemoteDatasource()),
        ),
        BlocProvider(
          create: (contex) => CheckPaymentStatusBloc(OrderRemoteDatasource()),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
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
