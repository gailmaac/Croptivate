part of 'favorites_bloc.dart';

@immutable
abstract class FavoritesState extends Equatable {
  const FavoritesState();

  @override
  List<Object?> get props => [];
}

class FavoritesLoading extends FavoritesState {}

class FavoritesLoaded extends FavoritesState {
  final Favorites favorites;

  const FavoritesLoaded({this.favorites = const Favorites()});

  @override
  List<Object?> get props => [favorites];
}

class FavoritesError extends FavoritesState {}
