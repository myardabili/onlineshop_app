import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:onlineshop_app/core/components/circle_loading.dart';
import 'package:onlineshop_app/core/components/components.dart';
import 'package:onlineshop_app/core/router/app_router.dart';
import 'package:onlineshop_app/features/address/data/models/address_request_model.dart';
import 'package:onlineshop_app/features/address/data/models/city_model.dart';
import 'package:onlineshop_app/features/address/data/models/province_model.dart';
import 'package:onlineshop_app/features/address/data/models/subdistrict_model.dart';
import 'package:onlineshop_app/features/address/presentation/bloc/add_address/add_address_bloc.dart';
import 'package:onlineshop_app/features/address/presentation/bloc/city/city_bloc.dart';
import 'package:onlineshop_app/features/address/presentation/bloc/province/province_bloc.dart';
import 'package:onlineshop_app/features/address/presentation/bloc/subdistrict/subdistrict_bloc.dart';

import '../bloc/get_address/get_address_bloc.dart';

class AddAddressPage extends StatefulWidget {
  const AddAddressPage({super.key});

  @override
  State<AddAddressPage> createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final zipCodeController = TextEditingController();
  final phoneNumberController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    addressController.dispose();
    zipCodeController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    context.read<ProvinceBloc>().add(OnGetProvince());
    super.initState();
  }

  Province selectedProvince = Province(
    province: '',
    provinceId: '',
  );

  City selectedCity = City(
    cityId: '',
  );

  Subdistrict selectedSubdistrict = Subdistrict(
    subdistrictId: '',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Adress'),
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20.0),
        children: [
          CustomTextField(
            controller: nameController,
            label: 'Full Name',
          ),
          const SpaceHeight(height: 24.0),
          CustomTextField(
            controller: addressController,
            label: 'Address',
          ),
          const SpaceHeight(height: 24.0),
          BlocBuilder<ProvinceBloc, ProvinceState>(
            builder: (context, state) {
              if (state is ProvinceLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is ProvinceLoaded) {
                final data = state.provinces;
                selectedProvince = data.first;
                return CustomDropdown<Province>(
                  value: selectedProvince,
                  items: data,
                  label: 'Province',
                  onChanged: (value) {
                    setState(() {
                      selectedProvince = value!;
                      context.read<CityBloc>().add(
                            OnGetCity(provinceId: selectedProvince.provinceId!),
                          );
                    });
                  },
                );
              }
              return const SizedBox.shrink();
            },
          ),
          const SpaceHeight(height: 24.0),
          BlocBuilder<CityBloc, CityState>(
            builder: (context, state) {
              if (state is CityLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is CityLoaded) {
                final data = state.cities;
                selectedCity = data.first;
                return CustomDropdown<City>(
                  value: selectedCity,
                  items: data,
                  label: 'City',
                  onChanged: (value) {
                    setState(() {
                      selectedCity = value!;
                      context.read<SubdistrictBloc>().add(
                            OnGetSubdistrict(cityId: selectedCity.cityId!),
                          );
                    });
                  },
                );
              }
              return const CustomDropdown(
                value: '-',
                items: ['-'],
                label: 'Subdistrict',
              );
            },
          ),
          const SpaceHeight(height: 24.0),
          BlocBuilder<SubdistrictBloc, SubdistrictState>(
            builder: (context, state) {
              if (state is SubdistrictLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is SubdistrictLoaded) {
                final data = state.subdistricts;
                selectedSubdistrict = data.first;
                return CustomDropdown<Subdistrict>(
                  value: selectedSubdistrict,
                  items: data,
                  label: 'Subdistrict',
                  onChanged: (value) {
                    setState(() {
                      selectedSubdistrict = value!;
                    });
                  },
                );
              }
              return const CustomDropdown(
                value: '-',
                items: ['-'],
                label: 'Subdistrict',
              );
            },
          ),
          const SpaceHeight(height: 24.0),
          CustomTextField(
            controller: zipCodeController,
            label: 'Postal Code',
          ),
          const SpaceHeight(height: 24.0),
          CustomTextField(
            controller: phoneNumberController,
            label: 'Phone Number',
          ),
          const SpaceHeight(height: 24.0),
          BlocConsumer<AddAddressBloc, AddAddressState>(
            listener: (context, state) {
              if (state is AddAddressLoaded) {
                context.read<GetAddressBloc>().add(OnGetAddress());
                context.goNamed(
                  RouteConstants.address,
                  pathParameters: PathParameters(
                    rootTab: RootTab.order,
                  ).toMap(),
                );
              }
              if (state is AddAddressFailure) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(state.message)));
              }
            },
            builder: (context, state) {
              if (state is AddAddressLoading) {
                return const CircleLoading();
              }
              if (state is AddAddressLoaded) {}
              return Button.filled(
                onPressed: () {
                  context.read<AddAddressBloc>().add(
                        OnAddAddress(
                          model: AddressRequestModel(
                            name: nameController.text,
                            fullAddress: addressController.text,
                            provId: selectedProvince.provinceId,
                            cityId: selectedCity.cityId,
                            subdistrictId: selectedSubdistrict.subdistrictId,
                            postalCode: zipCodeController.text,
                            phone: phoneNumberController.text,
                            isDefault: 0,
                          ),
                        ),
                      );
                },
                label: 'Add Address',
              );
            },
          ),
        ],
      ),
    );
  }
}
