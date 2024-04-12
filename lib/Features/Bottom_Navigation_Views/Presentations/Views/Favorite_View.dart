// ignore_for_file: file_names

import 'package:e_commerce/Core/Shared/No_Items_Message.dart';
import 'package:e_commerce/Core/Util/Helper/Show_Message.dart';
import 'package:e_commerce/Features/Bottom_Navigation_Views/Manager/Cart_Cubit/cart_cubit.dart';
import 'package:e_commerce/Features/Bottom_Navigation_Views/Manager/Home_Cubit/home_cubit.dart';
import 'package:e_commerce/Features/Bottom_Navigation_Views/Presentations/Widgets/Drawer_Menue.dart';
import 'package:e_commerce/Features/Bottom_Navigation_Views/Presentations/Widgets/Open_Container_Display.dart';
import 'package:e_commerce/Features/Bottom_Navigation_Views/Presentations/Widgets/Product_Info_Card.dart';
import 'package:e_commerce/Features/Bottom_Navigation_Views/Presentations/Widgets/Search_TextField.dart';
import 'package:e_commerce/Core/Shared/Views_Background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class FavoriteView extends StatelessWidget {
  const FavoriteView({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<HomeCubit>();
    final cartCubit = context.watch<CartCubit>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite'),
      ),
      drawer: const DrawerMenue(),
      body: ViewsBackground(
        child: BlocConsumer<HomeCubit, HomeState>(
          listener: (context, state) {
            if (state is FavoritesFailure) {
              ShowMessage()
                  .showMessage(state.errorMessage, context, Colors.red);
            }
          },
          builder: (context, state) {
            if (state is FavoritesLoading) {
              return Center(
                  child: LoadingAnimationWidget.staggeredDotsWave(
                      color: Colors.green.shade100, size: 50.sp));
            }
            return Column(
              children: [
                SearchTextField(
                  onChanged: (value) {
                    cubit.filterProducts(input2: value);
                  },
                ),
                Expanded(
                  child: cubit.favorites.isEmpty
                      ? const NoItemsMessage(
                          message: 'No Items in your Favorites')
                      : ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          itemCount: cubit.searchListFavorite.isEmpty
                              ? cubit.favorites.length
                              : cubit.searchListFavorite.length,
                          separatorBuilder: (context, index) => const Gap(10),
                          itemBuilder: (context, index) {
                            final product = cubit.favorites[index];
                            final cartContainsProductId = cartCubit.cartsId
                                .contains(product.id.toString());
                            return OpenContainerDisplay(
                                closedBuilder: (context, action) =>
                                    ProductInfoCard(
                                        product: product,
                                        onPressed: () async {
                                          await cartCubit.addAndRemoveCart(
                                              id: product.id.toString());
                                        },
                                        color: cartContainsProductId
                                            ? Colors.green.shade700
                                            : Colors.grey.shade400,
                                        icon: Icons.add_shopping_cart,
                                        onPressedDelete: () async {
                                          await cubit.changeFavorites(
                                              id: product.id.toString());
                                        }),
                                item: product);
                          },
                        ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
