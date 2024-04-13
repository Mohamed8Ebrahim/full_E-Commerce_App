// ignore_for_file: file_names, use_build_context_synchronously

import 'package:e_commerce/Core/Util/App_Router.dart';
import 'package:e_commerce/Features/Bottom_Navigation_Views/Data/Models/category_model.dart';
import 'package:e_commerce/Features/Bottom_Navigation_Views/Manager/Home_Cubit/home_cubit.dart';
import 'package:e_commerce/Core/Shared/Views_Background.dart';
import 'package:e_commerce/Features/Bottom_Navigation_Views/Presentations/Widgets/Drawer_Menue.dart';
import 'package:e_commerce/Features/Bottom_Navigation_Views/Presentations/Widgets/Items_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class CategoryView extends StatelessWidget {
  const CategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    List<CategoryModel> categories =
        BlocProvider.of<HomeCubit>(context).categoriesData;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Categories"),
      ),
      drawer: const DrawerMenue(),
      body: ViewsBackground(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12.h,
              crossAxisSpacing: 10.w,
              childAspectRatio: .77,
            ),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  HomeCubit.get(context)
                      .getCategoryDetails(id: categories[index].id.toString());
                  GoRouter.of(context).push(AppRouter.categoryDetails,
                      extra: categories[index].id.toString());
                },
                child: Card(
                  color: Colors.blue.shade100,
                  child: Column(
                    children: [
                      Expanded(
                          child: ItemsImages(
                              imageUrl: categories[index].image ?? '')),
                      SizedBox(height: 10.h),
                      Text(
                        categories[index].name ?? '',
                        style: TextStyle(
                            fontSize: 14.sp, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
