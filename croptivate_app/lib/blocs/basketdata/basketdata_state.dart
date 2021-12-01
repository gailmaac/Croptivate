part of 'basketdata_bloc.dart';

@immutable
abstract class BasketdataState extends Equatable {
  const BasketdataState();

  @override
  List<Object?> get props => [];
}

class BasketdataLoading extends BasketdataState {}

class BasketdataLoaded extends BasketdataState {
  final List<Product>? products;
  final String? total;
  final BasketData basketData;

  BasketdataLoaded({
    this.products,
    this.total
  }) : basketData = BasketData(
    products: products, 
    total: total);

    @override
    List<Object?> get props => [
      products, 
      total
    ];
}
