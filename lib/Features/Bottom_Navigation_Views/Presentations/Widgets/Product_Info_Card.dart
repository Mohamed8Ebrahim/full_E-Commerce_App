// ignore_for_file: file_names

import 'package:e_commerce/Features/Bottom_Navigation_Views/Data/Models/products_model.dart';
import 'package:e_commerce/Features/Bottom_Navigation_Views/Presentations/Widgets/Card_Info_Buttons.dart';
import 'package:e_commerce/Features/Bottom_Navigation_Views/Presentations/Widgets/Card_Info_Price_Row.dart';
import 'package:e_commerce/Features/Bottom_Navigation_Views/Presentations/Widgets/Items_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class ProductInfoCard extends StatelessWidget {
  const ProductInfoCard(
      {super.key,
      required this.product,
      this.onPressed,
      this.onPressedDelete,
      this.color,
      this.icon});
  final ProductsModel product;
  final void Function()? onPressedDelete;
  final void Function()? onPressed;
  final Color? color;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            flex: 2,
            child: ItemsImages(
              imageUrl: product.image ?? '',
              aspectRatio: 0.77,
              fit: BoxFit.cover,
            )),
        Gap(10.w),
        Expanded(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                  product.name ?? '',
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.blue.shade900,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Gap(8.0.h),
                CardInfoPriceRow(
                    price: product.price!, oldPrice: product.oldPrice!),
                Gap(8.0.h),
                CardInfoButtons(
                  onPressed: onPressed,
                  color: color,
                  icon: icon,
                  onPressedDelete: onPressedDelete,
                  product: product,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
