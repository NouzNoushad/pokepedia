part of 'pokemon_bloc.dart';

sealed class PokemonState extends Equatable {
  const PokemonState();

  @override
  List<Object> get props => [];
}

final class PokemonInitial extends PokemonState {}

final class PokemonLoading extends PokemonState {}

class PokemonLoadedState extends PokemonState {
  final List<PokemonDetailsResponse> pokemon;
  const PokemonLoadedState(
    this.pokemon,
  );

  @override
  List<Object> get props => [pokemon];
}

class PokemonErrorState extends PokemonState {
  final String error;
  const PokemonErrorState(this.error);

  @override
  List<Object> get props => [error];
}
