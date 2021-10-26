import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:croptivate_app/models/basket_model.dart';
import 'package:croptivate_app/models/product_model.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'basket_event.dart';
part 'basket_state.dart';

class BasketBloc extends Bloc<BasketEvent, BasketState> {
  BasketBloc() : super(BasketLoading()); 

    @override 
    Stream<BasketState> mapEventToState(
      BasketEvent event,
    ) async* {
      if (event is BasketStarted) {
        yield* _mapBasketStartedToState();
      } else if (event is BasketProductAdded) {
        yield* _mapBasketProductAddedToState(event, state);
      } else if (event is BasketProductRemoved) {
        yield* _mapBasketProductRemovedToState(event, state);
      }
    }
    Stream<BasketState> _mapBasketStartedToState() async* {
      yield BasketLoading();
      try {
        await Future<void>
        .delayed(
          Duration(
            seconds: 1
            )
          );
        yield BasketLoaded();
      } catch (_) {}
    }

  Stream<BasketState> _mapBasketProductAddedToState(
    BasketProductAdded event,
    BasketState state
  ) async* {
    if (state is BasketLoaded) {
      try {
        yield BasketLoaded(
          basket: Basket(
            products: List
            .from(state.basket.products)
            ..add(event.product)));
      } catch (_) {}
    }
  }

  Stream<BasketState> _mapBasketProductRemovedToState(
    BasketProductRemoved event,
    BasketState state
  ) async* {
    if (state is BasketLoaded) {
      try {
        yield BasketLoaded(
          basket: Basket(
            products: List
            .from(state.basket.products)
            ..remove(event.product)));
      } catch (_) {}
    }
  }
}

