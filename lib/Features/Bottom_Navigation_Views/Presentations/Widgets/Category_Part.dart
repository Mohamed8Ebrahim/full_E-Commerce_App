// ignore_for_file: file_names

import 'package:e_commerce/Core/Util/App_Router.dart';
import 'package:e_commerce/Core/Util/Helper/Show_Message.dart';
import 'package:e_commerce/Features/Bottom_Navigation_Views/Manager/Home_Cubit/home_cubit.dart';
import 'package:e_commerce/Features/Bottom_Navigation_Views/Presentations/Widgets/Build_Loading_Indicator.dart';
import 'package:e_commerce/Features/Bottom_Navigation_Views/Presentations/Widgets/Items_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class CategoryPart extends StatelessWidget {
  const CategoryPart({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<HomeCubit>(context);
    return Column(
      children: [
        _buildCategoryTitle(context),
        BlocConsumer<HomeCubit, HomeState>(
          listener: (context, state) {
            if (state is CategoryFailure) {
              ShowMessage()
                  .showMessage(state.errorMessage, context, Colors.red);
            }
          },
          builder: (context, state) {
            return cubit.categoriesData.isNotEmpty
                ? _buildCategoriesList(cubit)
                : const BuildLoadingIndicator();
          },
        ),
      ],
    );
  }

  Widget _buildCategoryTitle(context) {
    return Padding(
      padding: EdgeInsets.all(12.0.spMin),
      child: Row(
        children: [
          Text(
            'Categories',
            style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          InkWell(
            onTap: () {
              GoRouter.of(context).push(AppRouter.category);
            },
            child: const Text(
              'View All',
              style: TextStyle(color: Colors.blue),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoriesList(HomeCubit cubit) {
    return SizedBox(
      height: 90.h,
      child: ListView.separated(
        separatorBuilder: (context, index) => SizedBox(width: 10.w),
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: cubit.categoriesData.length,
        itemBuilder: (context, index) {
          final category = cubit.categoriesData[index];
          return InkWell(
            onTap: () {
              HomeCubit.get(context)
                  .getCategoryDetails(id: category.id.toString());
              GoRouter.of(context).push(AppRouter.categoryDetails);
            },
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(80.r),
              ),
              child: ItemsImages(
                imageUrl: category.image ?? '',
                borderRadius: 50.r,
              ),
            ),
          );
        },
      ),
    );
  }
}
