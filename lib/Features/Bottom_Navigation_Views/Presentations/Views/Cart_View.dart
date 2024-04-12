// ignore_for_file: file_names

import 'package:e_commerce/Core/Shared/No_Items_Message.dart';
import 'package:e_commerce/Core/Util/Helper/Show_Message.dart';
import 'package:e_commerce/Features/Bottom_Navigation_Views/Data/Models/products_model.dart';
import 'package:e_commerce/Features/Bottom_Navigation_Views/Manager/Cart_Cubit/cart_cubit.dart';
import 'package:e_commerce/Core/Shared/Views_Background.dart';
import 'package:e_commerce/Features/Bottom_Navigation_Views/Presentations/Widgets/Drawer_Menue.dart';
import 'package:e_commerce/Features/Bottom_Navigation_Views/Presentations/Widgets/Open_Container_Display.dart';
import 'package:e_commerce/Features/Bottom_Navigation_Views/Presentations/Widgets/Product_Info_Card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce/Features/Bottom_Navigation_Views/Manager/Home_Cubit/home_cubit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    final cartCubit = context.watch<CartCubit>();
    final homeCubit = context.watch<HomeCubit>();
    return Scaffold(
      appBar: AppBar(title: const Text("Cart")),
      drawer: const DrawerMenue(),
      body: ViewsBackground(
        child: BlocConsumer<CartCubit, CartState>(
          listener: (context, state) {
            if (state is CartFailure) {
              ShowMessage().showMessage(state.message, context, Colors.red);
            }
          },
          builder: (context, state) {
            if (state is CartLoading) {
              return Center(
                  child: LoadingAnimationWidget.staggeredDotsWave(
                      color: Colors.green.shade100, size: 50));
            }
            final carts = cartCubit.carts;
            return carts.isNotEmpty
                ? _buildCarts(carts, cartCubit, homeCubit, context, state)
                : const NoItemsMessage(message: 'No Items in your Cart');
          },
        ),
      ),
    );
  }

  Widget _buildCarts(List<ProductsModel> carts, CartCubit cartCubit,
      HomeCubit homeCubit, BuildContext context, CartState state) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        ListView.separated(
          separatorBuilder: (context, index) => const Gap(10),
          physics: const BouncingScrollPhysics(),
          itemCount: carts.length,
          itemBuilder: (context, index) {
            final cart = carts[index];
            return OpenContainerDisplay(
                closedBuilder: (context, action) => ProductInfoCard(
                    product: cart,
                    onPressed: () async {
                      await homeCubit.changeFavorites(id: cart.id.toString());
                    },
                    color: homeCubit.favoritesIds.contains(cart.id.toString())
                        ? Colors.red
                        : Colors.grey,
                    icon: homeCubit.favoritesIds.contains(cart.id.toString())
                        ? Icons.favorite
                        : Icons.favorite_border,
                    onPressedDelete: () async {
                      await cartCubit.addAndRemoveCart(id: cart.id.toString());
                    }),
                item: cart);
          },
        ),
        Positioned(
          bottom: 10.h,
          child: Row(
            children: [
              Text(
                'Total Price: ',
                style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(198, 255, 30, 98)),
              ),
              Text(
                '\$${cartCubit.totalPrice}',
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Colors.green),
              ),
            ],
          ),
        )
      ],
    );
  }
}
