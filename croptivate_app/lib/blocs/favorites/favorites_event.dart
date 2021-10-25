part of 'favorites_bloc.dart';

@immutable
abstract class FavoritesEvent extends Equatable {
  const FavoritesEvent();

  @override
  List<Object> get props => [];

}

class StartFavorites extends FavoritesEvent {}

class AddFavoritesProduct extends FavoritesEvent {
  final Product product;

  const AddFavoritesProduct(this.product);

  @override
  List<Object> get props => [product];
}

class RemoveFavoritesProduct extends FavoritesEvent {
  final Product product;

  const RemoveFavoritesProduct(this.product);

  @override
  List<Object> get props => [product];
}