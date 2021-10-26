part of 'basket_bloc.dart';

@immutable
abstract class BasketState extends Equatable{
  const BasketState();

  @override
  List<Object?> get props => [];
}

class BasketLoading extends BasketState {
  @override
  List<Object?> get props => [];
}

class BasketLoaded extends BasketState {
  final Basket basket;

  const BasketLoaded({this.basket = const Basket()});

  @override
  List<Object?> get props => [basket];
}

class BasketError extends BasketState {
  @override
  List<Object?> get props => [];
}