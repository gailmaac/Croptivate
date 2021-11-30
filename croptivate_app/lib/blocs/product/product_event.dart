part of 'product_bloc.dart';

@immutable
abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override 
  List<Object> get props => [];
}

class LoadProducts extends ProductEvent {}

class UpdateProducts extends ProductEvent {
  final List<Product> products;

  UpdateProducts(this.products);

  @override 
  List<Object> get props => [products];
}

class RemoveProducts extends ProductEvent {
  final List<Product> products;

  RemoveProducts(this.products);

  @override 
  List<Object> get props => [products];
}