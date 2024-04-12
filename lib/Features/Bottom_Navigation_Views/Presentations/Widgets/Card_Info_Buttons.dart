// ignore_for_file: file_names

import 'package:e_commerce/Features/Bottom_Navigation_Views/Data/Models/products_model.dart';
import 'package:e_commerce/Features/Bottom_Navigation_Views/Manager/Cart_Cubit/cart_cubit.dart';
import 'package:e_commerce/Features/Bottom_Navigation_Views/Manager/Home_Cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CardInfoButtons extends StatelessWidget {
  const CardInfoButtons(
      {super.key,
      this.onPressed,
      this.color,
      this.icon,
      this.onPressedDelete,
      required this.product});
  final void Function()? onPressedDelete;
  final void Function()? onPressed;
  final Color? color;
  final IconData? icon;
  final ProductsModel product;
  @override
  Widget build(BuildContext context) {
    final cubit = HomeCubit.get(context);
    final cartCubit = CartCubit.get(context);
    final isCartItemInCart =
        cartCubit.isAddOrRemoveToCart[product.id.toString()] ?? false;
    final isFavoriteItemInFavorite =
        cubit.isAddOrRemoveToFavorite[product.id.toString()] ?? false;
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      OutlinedButton(
        onPressed: onPressed,
        child: Icon(
          icon,
          color: color,
        ),
      ),
      isCartItemInCart || isFavoriteItemInFavorite
          ? LoadingAnimationWidget.hexagonDots(color: Colors.green, size: 20)
          : IconButton(
              onPressed: onPressedDelete,
              icon: const Icon(Icons.delete, color: Colors.red),
            ),
    ]);
  }
}
