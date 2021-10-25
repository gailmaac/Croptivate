import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:croptivate_app/models/favorites_model.dart';
import 'package:croptivate_app/models/product_model.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'favorites_event.dart';
part 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  FavoritesBloc() : super(FavoritesLoading()); 

  @override
  Stream<FavoritesState> mapEventToState(
    FavoritesEvent event,
  ) async* {
    if (event is StartFavorites) {
      yield* _mapStartFavoritesToState();
    } else if (event is AddFavoritesProduct) {
      yield* _mapAddFavoritesProductToState(event, state);
    } else if (event is RemoveFavoritesProduct) {
      yield* _mapRemoveFavoritesProductToState(event, state);
    }
  }
    Stream<FavoritesState> _mapStartFavoritesToState() async* {
      yield FavoritesLoading();
      try {
        await Future<void>
        .delayed(
          Duration(
            seconds: 1
            )
          );
        yield const FavoritesLoaded();
      } catch (_) {}
    }

    Stream<FavoritesState> _mapAddFavoritesProductToState(
      AddFavoritesProduct event,
      FavoritesState state,
    ) async* {
      if (state is FavoritesLoaded) {
        try {
          yield FavoritesLoaded(
            favorites: Favorites(
              products: List
              .from(state.favorites.products)
              ..add(event.product)
              )
            );
        } catch (_) {}
      }
    }

    Stream<FavoritesState> _mapRemoveFavoritesProductToState(
      RemoveFavoritesProduct event,
      FavoritesState state,
    ) async* {
      if (state is FavoritesLoaded) {
        try {
          yield FavoritesLoaded(
            favorites: Favorites(
              products: List
              .from(state.favorites.products)
              ..remove(event.product)
              )
            );
        } catch (_) {}
      }
    }

  }