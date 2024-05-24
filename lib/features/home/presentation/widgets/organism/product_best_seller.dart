// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:onlineshop_app/api/urls.dart';
// import 'package:onlineshop_app/features/home/presentation/bloc/all_product/all_product_bloc.dart';
// import 'package:onlineshop_app/core/components/circle_loading.dart';

// class ProductBestSeller extends StatefulWidget {
//   const ProductBestSeller({super.key});

//   @override
//   State<ProductBestSeller> createState() => _ProductBestSellerState();
// }

// class _ProductBestSellerState extends State<ProductBestSeller> {
//   @override
//   void initState() {
//     context.read<AllProductBloc>().add(OnGetAllProduct());
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<AllProductBloc, AllProductState>(
//       builder: (context, state) {
//         if (state is AllProductLoading) {
//           return const CircleLoading();
//         }
//         if (state is AllProductFailure) {
//           return Text(state.message);
//         }
//         if (state is AllProductLoaded) {
//           return SizedBox(
//             height: 180,
//             child: ListView.separated(
//               shrinkWrap: true,
//               scrollDirection: Axis.horizontal,
//               itemCount: state.product.length,
//               itemBuilder: (context, index) {
//                 return Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Container(
//                       height: 130,
//                       width: 130,
//                       decoration: BoxDecoration(
//                         color: const Color(0xffD9D9D9),
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                       child: Image.network(
//                         state.product[index].image!.contains('http')
//                             ? state.product[index].image!
//                             : '${URLs.baseUrlImage}${state.product[index].image}',
//                       ),
//                     ),
//                     const SizedBox(height: 4),
//                     Text(
//                       state.product[index].name!,
//                       style: TextStyle(
//                         fontSize: 13,
//                         fontWeight: FontWeight.w500,
//                         color: Colors.black.withOpacity(0.5),
//                       ),
//                     ),
//                     const SizedBox(height: 8),
//                     Text(
//                       '${state.product[index].price}',
//                       style: const TextStyle(
//                         fontSize: 12,
//                         fontWeight: FontWeight.w500,
//                         color: Colors.black,
//                       ),
//                     ),
//                   ],
//                 );
//               },
//               separatorBuilder: (context, index) => const SizedBox(width: 16),
//             ),
//           );
//         }
//         return const SizedBox.shrink();
//       },
//     );
//   }
// }
