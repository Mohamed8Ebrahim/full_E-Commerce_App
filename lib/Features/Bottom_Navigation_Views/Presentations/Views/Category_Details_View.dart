// ignore_for_file: file_names

import 'package:e_commerce/Core/Util/Helper/Show_Message.dart';
import 'package:e_commerce/Features/Bottom_Navigation_Views/Manager/Cart_Cubit/cart_cubit.dart';
import 'package:e_commerce/Features/Bottom_Navigation_Views/Manager/Home_Cubit/home_cubit.dart';
import 'package:e_commerce/Core/Shared/Views_Background.dart';
import 'package:e_commerce/Features/Bottom_Navigation_Views/Presentations/Widgets/Open_Container_Display.dart';
import 'package:e_commerce/Features/Bottom_Navigation_Views/Presentations/Widgets/Product_Item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CategoryDetailsView extends StatelessWidget {
  const CategoryDetailsView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<HomeCubit>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Category Details"),
      ),
      body: ViewsBackground(
        child: BlocConsumer<HomeCubit, HomeState>(
          listener: (context, state) {
            if (state is ProductsFailure) {
              if (state is CategoryDetailsFailure) {
                ShowMessage()
                    .showMessage(state.errorMessage, context, Colors.red);
              }
            } else if (state is ChangeFavoritesFailure) {
              ShowMessage()
                  .showMessage(state.errorMessage, context, Colors.red);
            }
          },
          builder: (context, state) {
            if (state is CategoryDetailsLoading) {
              return Center(
                  child: LoadingAnimationWidget.staggeredDotsWave(
                color: Colors.green.shade100,
                size: 50.spMin,
              ));
            }
            return CustomScrollView(slivers: [
              SliverToBoxAdapter(child: _buildProductList(context, cubit))
            ]);
          },
        ),
      ),
    );
  }

  Widget _buildProductList(BuildContext context, HomeCubit cubit) {
    final cartCubit = BlocProvider.of<CartCubit>(context);
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 20.h,
          crossAxisSpacing: 20.w,
          childAspectRatio: 0.75,
        ),
        itemCount: cubit.categoryDetails.length,
        itemBuilder: (context, index) {
          final product = cubit.categoryDetails[index];
          return OpenContainerDisplay(
            item: product,
            vertical: 0,
            horizontal: 0,
            closedBuilder: (context, action) => ProductItem(
              product: product,
              cartCubit: cartCubit,
              cubit: cubit,
            ),
          );
        },
      ),
    );
  }
}
