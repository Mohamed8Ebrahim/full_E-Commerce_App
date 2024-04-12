// ignore_for_file: avoid_print

import 'package:e_commerce/Core/Util/Helper/End_Point.dart';
import 'package:e_commerce/Features/Bottom_Navigation_Views/Data/Models/products_model.dart';
import 'package:e_commerce/Features/Bottom_Navigation_Views/Data/Repository/repo.dart';
import 'package:e_commerce/Features/Bottom_Navigation_Views/Data/Repository/repo_Impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());
  final Repo repo = RepoImpl();
  static CartCubit get(context) => BlocProvider.of(context);
  // get cart
  List<ProductsModel> carts = [];
  Set<String> cartsId = {};
  int totalPrice = 0;
  Future<void> getCart() async {
    emit(CartLoading());
    carts.clear();
    final response = await repo.get(EndPoint.carts);
    response.fold((failure) => emit(CartFailure(failure.errorMessage)),
        (response) {
      totalPrice = response[ApiKey.data]['total'].toInt();
      if (response[ApiKey.status]) {
        for (final dynamic item in response[ApiKey.data]['cart_items']) {
          carts.add(ProductsModel.fromJson(item['product']));
          cartsId.add(item['product']['id'].toString());
        }
        emit(CartSuccess());
      } else {
        emit(CartFailure(response[ApiKey.message].toString()));
      }
    });
  }

  // add or clear cart
  Future<void> addAndRemoveCart({required String id}) async {
    setIsAddedToCart(id, true);
    final result = await repo.post(EndPoint.carts, data: {"product_id": id});
    result.fold((failure) {
      emit(CartFailure(failure.errorMessage));
      setIsAddedToCart(id, false);
    }, (response) async {
      if (response[ApiKey.status]) {
        if (cartsId.contains(id)) {
          cartsId.remove(id);
          carts.removeWhere((product) => product.id.toString() == id);
        } else {
          cartsId.add(id);
        }
        setIsAddedToCart(id, false);
        await getCart();
        emit(AddAndRemoveCartSuccess());
      } else {
        emit(AddAndRemoveCartFailure(response[ApiKey.message].toString()));
      }
    });
  }

  Map<String, bool> isAddOrRemoveToCart = {};
  void setIsAddedToCart(String id, bool isLoading) {
    isAddOrRemoveToCart[id] = isLoading;
    emit(AddAndRemoveCartLoading(id));
  }
}
