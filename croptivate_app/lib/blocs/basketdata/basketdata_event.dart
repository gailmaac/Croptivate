part of 'basketdata_bloc.dart';

@immutable
abstract class BasketdataEvent extends Equatable {
  const BasketdataEvent();

  @override
  List<Object?> get props => [];
}

class UpdateBasketdata extends BasketdataEvent {
  final Basket? basket;

  UpdateBasketdata({this.basket});

  @override
  List<Object?> get props => [basket];
}

class ConfirmBasketdata extends BasketdataEvent {
  final BasketData basketData;

  ConfirmBasketdata({required this.basketData});

  @override
  List<Object?> get props => [basketData];
}
