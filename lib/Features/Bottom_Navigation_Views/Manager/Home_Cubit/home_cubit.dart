// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:e_commerce/Core/Util/Helper/End_Point.dart';
import 'package:e_commerce/Features/Bottom_Navigation_Views/Data/Models/banner_model.dart';
import 'package:e_commerce/Features/Bottom_Navigation_Views/Data/Models/category_model.dart';
import 'package:e_commerce/Features/Bottom_Navigation_Views/Data/Models/products_model.dart';
import 'package:e_commerce/Features/Bottom_Navigation_Views/Data/Repository/repo.dart';
import 'package:e_commerce/Features/Bottom_Navigation_Views/Data/Repository/repo_Impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  final Repo repo = RepoImpl();
  static HomeCubit get(context) => BlocProvider.of(context);

  // banners
  List<BannerModel> bannerModels = [];
  Future<void> getBannerData() async {
    bannerModels.clear();

    emit(BannersLoading());
    final response = await repo.get(EndPoint.banners);
    response.fold((failure) => emit(BannersFailure(failure.errorMessage)),
        (response) {
      if (response[ApiKey.status] == true) {
        for (final dynamic item in response[ApiKey.data]) {
          bannerModels.add(BannerModel.fromJson(item));
        }
        emit(BannersSuccess());
      } else {
        emit(BannersFailure(response[ApiKey.message].toString()));
      }
    });
  }

  // categories
  List<CategoryModel> categoriesData = [];
  Future<void> getCategories() async {
    emit(CategoryLoading());

    final response = await repo.get(EndPoint.categories);
    response.fold((failure) => emit(CategoryFailure(failure.errorMessage)),
        (response) {
      if (response[ApiKey.status] == true) {
        categoriesData = (response[ApiKey.data][ApiKey.data] as List)
            .map((dynamic e) => CategoryModel.fromJson(e))
            .toList();
        emit(CategorySuccess(categoriesData));
      } else {
        emit(CategoryFailure(response[ApiKey.message].toString()));
      }
    });
  }

  // get Category Details
  List<ProductsModel> categoryDetails = [];
  Future<void> getCategoryDetails({required String id}) async {
    emit(CategoryDetailsLoading());
    final response = await repo.get('${EndPoint.categories}/$id');
    response
        .fold((failure) => emit(CategoryDetailsFailure(failure.errorMessage)),
            (response) async {
      if (response[ApiKey.status] == true) {
        categoryDetails = (response[ApiKey.data][ApiKey.data] as List)
            .map((dynamic e) => ProductsModel.fromJson(e))
            .toList();
        emit(CategoryDetailsSuccess());
      } else {
        emit(CategoryDetailsFailure(response[ApiKey.message].toString()));
      }
    });
  }

  // products
  List<ProductsModel> productsData = [];
  Future<void> getProducts() async {
    emit(ProductsLoading());
    final response = await repo.get(
      EndPoint.home,
    );
    response.fold((failure) => emit(ProductsFailure(failure.errorMessage)),
        (response) {
      if (response[ApiKey.status] == true) {
        productsData = (response[ApiKey.data][ApiKey.products] as List)
            .map((dynamic e) => ProductsModel.fromJson(e))
            .toList();
        emit(ProductsSuccess());
      } else {
        emit(ProductsFailure(response[ApiKey.message].toString()));
      }
    });
  }

  // search
  List<ProductsModel> searchList = [];
  List<ProductsModel> searchListFavorite = [];
  void filterProducts({String? input1, String? input2}) {
    searchList = productsData
        .where((element) =>
            element.name!.toLowerCase().startsWith(input1?.toLowerCase() ?? ''))
        .toList();
    searchListFavorite = favorites
        .where((element) =>
            element.name!.toLowerCase().startsWith(input2?.toLowerCase() ?? ''))
        .toList();
    emit(FilterProductsSuccss());
  }

  // clearFilter
  void clearFilter() {
    searchList = [];
    searchListFavorite = [];
    emit(ClearFilterSuccss());
  }

  // get favorites
  List<ProductsModel> favorites = [];
  Set<String> favoritesIds = {};
  Future<void> getFavorites() async {
    emit(FavoritesLoading());
    favorites.clear();
    final response = await repo.get(EndPoint.favorites);

    response.fold((failure) => emit(FavoritesFailure(failure.errorMessage)),
        (response) {
      if (response[ApiKey.status] == true) {
        for (var item in response[ApiKey.data][ApiKey.data]) {
          favorites.add(ProductsModel.fromJson(item['product']));
          favoritesIds.add(item['product']['id'].toString());
        }
        emit(FavoritesSuccess(favorites));
      } else {
        emit(FavoritesFailure(response[ApiKey.message].toString()));
      }
    });
  }

  // add or remove Favorites
  Future<void> changeFavorites({required String id}) async {
    setIsAddedToFavorite(id, true);
    final requestData = {'product_id': id};
    final response = await repo.post(EndPoint.favorites, data: requestData);
    response.fold((failure) {
      emit(ChangeFavoritesFailure(failure.errorMessage));
      setIsAddedToFavorite(id, false);
    }, (response) async {
      if (response[ApiKey.status] == true) {
        if (favoritesIds.contains(id)) {
          favoritesIds.remove(id);
          favorites.removeWhere((product) => product.id.toString() == id);
        } else {
          favoritesIds.add(id);
        }
        setIsAddedToFavorite(id, false);
        await getFavorites();
        emit(ChangeFavoritesSuccess(List.from(favorites)));
      } else {
        final errorMessage = response[ApiKey.message].toString();
        emit(ChangeFavoritesFailure(errorMessage));
      }
    });
  }

  Map<String, bool> isAddOrRemoveToFavorite = {};
  void setIsAddedToFavorite(String id, bool isLoading) {
    isAddOrRemoveToFavorite[id] = isLoading;
    emit(ChangeFavoritesLoading(id));
  }
}

extension HomeCubitExt on HomeCubit {
  Future<void> getInitialData() async {
    await Future.wait([
      getProducts(),
      getBannerData(),
      getCategories(),
      getFavorites(),
    ]);
  }
}
