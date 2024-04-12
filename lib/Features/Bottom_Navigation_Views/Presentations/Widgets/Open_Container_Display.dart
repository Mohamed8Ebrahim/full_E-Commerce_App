// ignore_for_file: file_names

import 'package:animations/animations.dart';
import 'package:e_commerce/Features/Bottom_Navigation_Views/Data/Models/products_model.dart';
import 'package:e_commerce/Features/Bottom_Navigation_Views/Presentations/Views/Product_Details_View.dart';
import 'package:flutter/material.dart';

class OpenContainerDisplay extends StatelessWidget {
  const OpenContainerDisplay({
    super.key,
    required this.closedBuilder,
    required this.item,
    this.vertical = 16,
    this.horizontal = 24,
  });
  final Widget Function(BuildContext, void Function()) closedBuilder;
  final ProductsModel item;
  final double vertical;
  final double horizontal;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: vertical, horizontal: horizontal),
      child: OpenContainer(
        openBuilder: (context, action) {
          return ProductDetailsView(item: item);
        },
        closedShape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        clipBehavior: Clip.none,
        transitionDuration: const Duration(milliseconds: 600),
        transitionType: ContainerTransitionType.fade,
        closedColor: Colors.tealAccent.shade200,
        closedElevation: 5,
        closedBuilder: closedBuilder,
      ),
    );
  }
}
