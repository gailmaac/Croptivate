part of 'basket_bloc.dart';

@immutable
abstract class BasketEvent extends Equatable{
  const BasketEvent();

  @override 
  List<Object> get props => [];
}

class BasketStarted extends BasketEvent {
  @override 
  List<Object> get props => [];
}

class BasketProductAdded extends BasketEvent {
  final Product product;

  const BasketProductAdded(this.product);
  
  @override 
  List<Object> get props => [product];
}

class BasketProductRemoved extends BasketEvent {
  final Product product;

  const BasketProductRemoved(this.product);

  @override 
  List<Object> get props => [product];
}

