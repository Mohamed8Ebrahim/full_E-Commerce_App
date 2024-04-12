// ignore_for_file: file_names

import 'package:e_commerce/Features/Bottom_Navigation_Views/Data/Models/products_model.dart';
import 'package:e_commerce/Features/Bottom_Navigation_Views/Presentations/Widgets/Custom_Product_Evaluates.dart';
import 'package:e_commerce/Features/Bottom_Navigation_Views/Presentations/Widgets/Items_images.dart';
import 'package:e_commerce/Core/Shared/Views_Background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductDetailsView extends StatefulWidget {
  const ProductDetailsView({super.key, required this.item});
  final ProductsModel item;

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  bool _showMore = true;
  late PageController _controller;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: _currentIndex);
    _controller.addListener(() {
      setState(() {
        _currentIndex = _controller.page!.round();
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ViewsBackground(
          child: CustomScrollView(
            slivers: [
              _buildAppBar(),
              _buildImagesListView(),
              _buildDetailsText(),
            ],
          ),
        ),
      ),
    );
  }

  SliverAppBar _buildAppBar() {
    return SliverAppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      automaticallyImplyLeading: false,
      pinned: true,
      title: const Text("Product Details"),
      expandedHeight: 380.h,
      flexibleSpace: FlexibleSpaceBar(
        background: PageView.builder(
            itemCount: widget.item.images?.length,
            controller: _controller,
            itemBuilder: (context, index) {
              return ItemsImages(
                  imageUrl: widget.item.images?.elementAt(index) ?? '');
            }),
      ),
    );
  }

  SliverToBoxAdapter _buildImagesListView() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.all(8.0.spMin),
        child: SizedBox(
          height: 45.h,
          child: Align(
            alignment: Alignment.center,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: widget.item.images?.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    _controller.animateToPage(index,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.linear);
                  },
                  child: Container(
                    padding: EdgeInsets.all(5.spMin),
                    margin: EdgeInsets.symmetric(horizontal: 5.w),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: _currentIndex == index
                            ? Colors.blue
                            : Colors.black26,
                        width: _currentIndex == index ? 2.w : 1.w,
                      ),
                    ),
                    child:
                        ItemsImages(imageUrl: widget.item.images?[index] ?? ""),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildDetailsText() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.all(8.0.spMin),
        child: Column(
          children: [
            SizedBox(height: 8.h),
            Text(
              "\$${widget.item.price.toString()}",
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: Colors.green.shade700,
              ),
            ),
            SizedBox(height: 8.h),
            CustomProductEvaluates(name: widget.item.name ?? ''),
            SizedBox(height: 8.h),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Details:',
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
              ),
            ),
            Text(
              widget.item.description ?? '',
              textAlign: TextAlign.center,
              maxLines: _showMore ? 5 : null,
              overflow: TextOverflow.fade,
              style: TextStyle(fontSize: 16.sp),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _showMore = !_showMore;
                });
              },
              child: Text(_showMore ? "Show more" : "Show less"),
            ),
          ],
        ),
      ),
    );
  }
}
