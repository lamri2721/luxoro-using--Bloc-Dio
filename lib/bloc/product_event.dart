part of 'product_bloc.dart';

abstract class ProductEvent {}

class GetProductsEvent extends ProductEvent {}

class AddProductEvent extends ProductEvent {
  final ProductModel product;

  AddProductEvent(this.product);
}

class UpdateProductEvent extends ProductEvent {
  final ProductModel product;

  UpdateProductEvent(this.product);
}

class DeleteProductEvent extends ProductEvent {
  final int id;

  DeleteProductEvent(this.id);
}
