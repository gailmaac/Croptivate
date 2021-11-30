import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:croptivate_app/models/product_model.dart';
import 'package:croptivate_app/repository/product/product_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository _productRepository;
  StreamSubscription? _productSubscription;

  ProductBloc(
    {required ProductRepository productRepository}) 
      : _productRepository = productRepository, 
        super(ProductLoading()); 
    
    @override
    Stream<ProductState> mapEventToState(
      ProductEvent event,
    ) async* {
      if (event is LoadProducts) {
        yield* _mapLoadProductsToState();
      }
      if (event is UpdateProducts) {
        yield* _mapUpdateProductsToState(event);
      }
      if (event is RemoveProducts) {
        yield* _mapRemoveProductsToState(event, state);
      }
    }

  Stream<ProductState> _mapLoadProductsToState() async* {
    _productSubscription?.cancel();
    _productSubscription = _productRepository
    .getAllProducts()
    .listen((products) => add(UpdateProducts(products)));
  }

  Stream<ProductState> _mapUpdateProductsToState(
      UpdateProducts event) async* {
    yield ProductLoaded(products: event.products);
  }

  Stream<ProductState> _mapRemoveProductsToState(
      RemoveProducts event,
      ProductState state) 
    async* {
      if(state is ProductLoaded) {
        try {
          yield ProductLoaded(
            products: List
            .from(state.products)
            ..remove(event.products)
          );
        } catch (_) {}
      }
  }
}
