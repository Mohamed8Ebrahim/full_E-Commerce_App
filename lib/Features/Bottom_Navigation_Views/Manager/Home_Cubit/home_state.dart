part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

// banners
final class BannersLoading extends HomeState {}

final class BannersSuccess extends HomeState {}

final class BannersFailure extends HomeState {
  final String errorMessage;

  BannersFailure(this.errorMessage);
}

// categories
final class CategoryLoading extends HomeState {}

final class CategorySuccess extends HomeState {
  final List<CategoryModel> categories;
  CategorySuccess(this.categories);
}

final class CategoryFailure extends HomeState {
  final String errorMessage;
  CategoryFailure(this.errorMessage);
}

// products
final class ProductsLoading extends HomeState {}

final class ProductsSuccess extends HomeState {}

final class ProductsFailure extends HomeState {
  final String errorMessage;
  ProductsFailure(this.errorMessage);
}

// filter
final class FilterProductsSuccss extends HomeState {}

// clear
final class ClearFilterSuccss extends HomeState {}

// favorites
final class FavoritesLoading extends HomeState {}

final class FavoritesSuccess extends HomeState {
  final List<ProductsModel> products;
  FavoritesSuccess(this.products);
}

final class FavoritesFailure extends HomeState {
  final String errorMessage;
  FavoritesFailure(this.errorMessage);
}

// change favorites
final class ChangeFavoritesLoading extends HomeState {
  final String id;

  ChangeFavoritesLoading(this.id);
}

final class ChangeFavoritesSuccess extends HomeState {
  final List<ProductsModel> products;
  ChangeFavoritesSuccess(this.products);
}

final class ChangeFavoritesFailure extends HomeState {
  final String errorMessage;
  ChangeFavoritesFailure(this.errorMessage);
}

// categories details
final class CategoryDetailsLoading extends HomeState {}

final class CategoryDetailsSuccess extends HomeState {}

final class CategoryDetailsFailure extends HomeState {
  final String errorMessage;
  CategoryDetailsFailure(this.errorMessage);
}
