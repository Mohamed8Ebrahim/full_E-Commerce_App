// ignore_for_file: file_names

import 'package:e_commerce/Core/Util/Helper/Show_Message.dart';
import 'package:e_commerce/Features/Bottom_Navigation_Views/Manager/Home_Cubit/home_cubit.dart';
import 'package:e_commerce/Features/Bottom_Navigation_Views/Presentations/Widgets/Build_Loading_Indicator.dart';
import 'package:e_commerce/Features/Bottom_Navigation_Views/Presentations/Widgets/Items_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BannerPart extends StatefulWidget {
  const BannerPart({super.key});

  @override
  State<BannerPart> createState() => _BannerPartState();
}

class _BannerPartState extends State<BannerPart> {
  late PageController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PageController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<HomeCubit>(context);
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) async {
        if (state is BannersFailure) {
          ShowMessage().showMessage(state.errorMessage, context, Colors.red);
        }
      },
      builder: (context, state) {
        return cubit.bannerModels.isNotEmpty
            ? Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildBannerView(cubit),
                    const SizedBox(height: 10),
                    _buildIndicator(cubit),
                  ],
                ),
              )
            : const BuildLoadingIndicator();
      },
    );
  }

  Widget _buildBannerView(HomeCubit cubit) {
    return SizedBox(
      height: 150.sp,
      width: double.infinity,
      child: PageView.builder(
        controller: _controller,
        physics: const BouncingScrollPhysics(),
        itemCount: cubit.bannerModels.length,
        itemBuilder: (_, index) => SizedBox(
          height: 200.sp,
          child: ItemsImages(
            imageUrl: cubit.bannerModels[index].image ?? '',
          ),
        ),
      ),
    );
  }

  Widget _buildIndicator(HomeCubit cubit) {
    return Center(
      child: cubit.bannerModels.isEmpty
          ? const SizedBox()
          : SmoothPageIndicator(
              controller: _controller,
              count: cubit.bannerModels.length,
              effect: SlideEffect(
                radius: 20.sp,
                dotWidth: 8.w,
                dotHeight: 9.h,
                paintStyle: PaintingStyle.stroke,
                strokeWidth: 2.sp,
                dotColor: Colors.grey,
                activeDotColor: Colors.indigo,
              ),
            ),
    );
  }
}
