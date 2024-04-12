// ignore_for_file: file_names

import 'package:e_commerce/Features/Bottom_Navigation_Views/Data/Models/products_model.dart';
import 'package:e_commerce/Features/Bottom_Navigation_Views/Manager/Cart_Cubit/cart_cubit.dart';
import 'package:e_commerce/Features/Bottom_Navigation_Views/Manager/Home_Cubit/home_cubit.dart';
import 'package:e_commerce/Features/Bottom_Navigation_Views/Presentations/Widgets/Build_Loading_Indicator.dart';
import 'package:e_commerce/Features/Bottom_Navigation_Views/Presentations/Widgets/Open_Container_Display.dart';
import 'package:e_commerce/Features/Bottom_Navigation_Views/Presentations/Widgets/Product_Item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductsPart extends StatelessWidget {
  const ProductsPart({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<HomeCubit>();
    final cartCubit = context.watch<CartCubit>();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildHeader(context),
        _buildContent(cubit, cartCubit, context),
      ],
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        children: [
          Text(
            'Products',
            style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          const Text(
            'View All',
            style: TextStyle(color: Colors.blue),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(
      HomeCubit cubit, CartCubit cartCubit, BuildContext context) {
    if (cubit.productsData.isEmpty) {
      return const BuildLoadingIndicator();
    }
    return _buildGridView(cubit, cartCubit, context);
  }

  Widget _buildGridView(
      HomeCubit cubit, CartCubit cartCubit, BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: cubit.searchList.isEmpty
          ? cubit.productsData.length
          : cubit.searchList.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 20.h,
        crossAxisSpacing: 20.w,
        childAspectRatio: .75,
      ),
      itemBuilder: (context, index) {
        final product = cubit.searchList.isEmpty
            ? cubit.productsData[index]
            : cubit.searchList[index];
        return _buildProductItem(product, index, cubit, cartCubit, context);
      },
    );
  }

  Widget _buildProductItem(ProductsModel product, int index, HomeCubit cubit,
      CartCubit cartCubit, BuildContext context) {
    return Transform.translate(
        offset: Offset(0, index.isOdd ? 28 : 0),
        child: OpenContainerDisplay(
          closedBuilder: (context, action) =>
              ProductItem(product: product, cubit: cubit, cartCubit: cartCubit),
          item: product,
          vertical: 0,
          horizontal: 0,
        ));
  }
}
