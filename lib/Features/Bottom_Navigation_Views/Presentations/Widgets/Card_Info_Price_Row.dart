// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CardInfoPriceRow extends StatelessWidget {
  const CardInfoPriceRow(
      {super.key, required this.price, required this.oldPrice});
  final num price;
  final num oldPrice;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '${price.toString()}\$',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: Colors.green.shade600,
          ),
        ),
        if (price != oldPrice)
          Text(
            '${oldPrice.toString()}\$',
            style: TextStyle(
              decoration: TextDecoration.lineThrough,
              fontSize: 14.sp,
              color: Colors.grey.shade600,
            ),
          ),
      ],
    );
  }
}
