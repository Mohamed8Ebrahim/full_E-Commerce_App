part of 'cart_cubit.dart';

@immutable
sealed class CartState {}

final class CartInitial extends CartState {}

final class CartLoading extends CartState {}

final class CartSuccess extends CartState {}

final class CartFailure extends CartState {
  final String message;

  CartFailure(this.message);
}

final class AddAndRemoveCartLoading extends CartState {
  final String id;

  AddAndRemoveCartLoading(this.id);
}

final class AddAndRemoveCartSuccess extends CartState {}

final class AddAndRemoveCartFailure extends CartState {
  final String message;
  AddAndRemoveCartFailure(this.message);
}

final class AddCartSuccess extends CartState {}

final class AddCartFailure extends CartState {
  final String message;
  AddCartFailure(this.message);
}
