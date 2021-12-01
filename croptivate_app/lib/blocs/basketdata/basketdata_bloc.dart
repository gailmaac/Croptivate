import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:croptivate_app/blocs/basket/basket_bloc.dart';
import 'package:croptivate_app/models/basket_model.dart';
import 'package:croptivate_app/models/basketdata_model.dart';
import 'package:croptivate_app/models/product_model.dart';
import 'package:croptivate_app/repository/basket/basketdata_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'basketdata_event.dart';
part 'basketdata_state.dart';

class BasketdataBloc extends Bloc<BasketdataEvent, BasketdataState> {
  final BasketBloc _basketBloc;
  final BasketDataRepository _basketDataRepository;
  StreamSubscription? _basketSubscription;
  StreamSubscription? _basketdataSubscription;

  BasketdataBloc({
    required BasketBloc basketBloc,
    required BasketDataRepository basketDataRepository,
  })  : _basketBloc = basketBloc,
        _basketDataRepository = basketDataRepository,
        super(basketBloc.state is BasketLoaded
            ? BasketdataLoaded(
              products: (basketBloc.state as BasketLoaded).basket.products,
              total: (basketBloc.state as BasketLoaded).basket.subtotalString,
            )
            : BasketdataLoading()) {
              _basketSubscription = basketBloc.stream.listen((state) {
                if (state is BasketLoaded) {
                  add(UpdateBasketdata(basket: state.basket));
                }
              });
            }

  @override
  Stream<BasketdataState> mapEventToState(
    BasketdataEvent event,
  ) async* {
    if (event is UpdateBasketdata) {
      yield* _mapUpdateBasketdataToState(event, state);
    }
    if (event is ConfirmBasketdata) {
      yield* _mapConfirmBasketdataToState(event, state);
    }
  }

  Stream<BasketdataState> _mapUpdateBasketdataToState(
    UpdateBasketdata event, 
    BasketdataState state
  ) async* {
    if (state is BasketdataLoaded) {
      yield BasketdataLoaded(
        products: event.basket?.products ?? state.products,
        total: event.basket?.subtotalString ?? state.total
      );
    }
  }

  Stream<BasketdataState> _mapConfirmBasketdataToState(
    ConfirmBasketdata event, 
    BasketdataState state
  ) async* {
    _basketdataSubscription?.cancel();
    if (state is BasketdataLoaded) {
      try {
        await _basketDataRepository.addBasket(event.basketData);
        print("Done");
        yield BasketdataLoading();
      } catch (_) {}
    }
  }
}
