import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/category/category_bloc.dart';
import '../category_button.dart';

class MenuCategories extends StatefulWidget {
  const MenuCategories({super.key});

  @override
  State<MenuCategories> createState() => _MenuCategoriesState();
}

class _MenuCategoriesState extends State<MenuCategories> {
  @override
  void initState() {
    context.read<CategoryBloc>().add(OnGetCategory());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, state) {
        if (state is CategoryLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is CategoryFailure) {
          return Text(state.message);
        }
        if (state is CategoryLoaded) {
          return SizedBox(
            height: 34,
            child: ListView.separated(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: state.category.length,
              itemBuilder: (context, index) {
                return CategoryButton(
                  imagePath: state.category[index].image ?? '',
                  label: state.category[index].name ?? '',
                  onPressed: () {},
                );
              },
              separatorBuilder: (context, index) => const SizedBox(width: 16),
            ),
          );
        }
        return const SizedBox.shrink();
        // return Row(
        //   children: [
        //     Flexible(
        //       child: CategoryButton(
        //         imagePath: Assets.images.categories.menuBestseller.path,
        //         label: 'Bestseller',
        //         onPressed: () {},
        //       ),
        //     ),
        //     Flexible(
        //       child: CategoryButton(
        //         imagePath: Assets.images.categories.menuFlashsale.path,
        //         label: 'Flashsale',
        //         onPressed: () {},
        //       ),
        //     ),
        //     Flexible(
        //       child: CategoryButton(
        //         imagePath: Assets.images.categories.menuToprated.path,
        //         label: 'Toprated',
        //         onPressed: () {},
        //       ),
        //     ),
        //     Flexible(
        //       child: CategoryButton(
        //         imagePath: Assets.images.categories.menuMore.path,
        //         label: 'More',
        //         onPressed: () {},
        //       ),
        //     ),
        //   ],
        // );
      },
    );
  }
}
