// ignore_for_file: file_names

import 'package:e_commerce/Core/Util/Helper/Show_Message.dart';
import 'package:e_commerce/Features/Bottom_Navigation_Views/Data/Models/products_model.dart';
import 'package:e_commerce/Features/Bottom_Navigation_Views/Manager/Cart_Cubit/cart_cubit.dart';
import 'package:e_commerce/Features/Bottom_Navigation_Views/Manager/Home_Cubit/home_cubit.dart';
import 'package:e_commerce/Features/Bottom_Navigation_Views/Presentations/Widgets/Items_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({
    super.key,
    required this.product,
    required this.cubit,
    this.cartCubit,
  });

  final ProductsModel product;
  final HomeCubit cubit;
  final CartCubit? cartCubit;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartCubit, CartState>(
      listener: (context, state) {
        if (state is AddAndRemoveCartFailure) {
          ShowMessage().showMessage(state.message, context, Colors.red);
        }
      },
      builder: (context, state) {
        final cartsId = cartCubit?.cartsId ?? {};
        return Stack(
          clipBehavior: Clip.none,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ItemsImages(imageUrl: product.image ?? ''),
                  SizedBox(height: 8.h),
                  Text(
                    product.name ?? '',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              '${product.price ?? ''}\$',
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.green.shade800,
                              ),
                            ),
                            SizedBox(width: 8.w),
                            if (product.price != product.oldPrice)
                              Text(
                                '${product.oldPrice ?? ''}\$',
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: Colors.red.shade400,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                          ],
                        ),
                        InkWell(
                          onTap: () async {
                            await cubit.changeFavorites(
                              id: product.id.toString(),
                            );
                          },
                          child: Icon(
                            Icons.favorite,
                            size: 18.sp,
                            color: cubit.favoritesIds
                                    .contains(product.id.toString())
                                ? Colors.red
                                : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned.fromRect(
              rect: Rect.fromLTWH(145, -25, 40.w, 40.h),
              child: IconButton(
                onPressed: () async {
                  await cartCubit?.addAndRemoveCart(
                    id: product.id.toString(),
                  );
                },
                icon: Icon(
                  Icons.add_shopping_cart,
                  color: cartsId.contains(product.id.toString())
                      ? Colors.green
                      : Colors.grey.shade400,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
