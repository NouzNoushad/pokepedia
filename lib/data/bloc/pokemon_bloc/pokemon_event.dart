part of 'pokemon_bloc.dart';

sealed class PokemonEvent extends Equatable {
  const PokemonEvent();

  @override
  List<Object> get props => [];
}

class PokemonLoadedEvent extends PokemonEvent {
  const PokemonLoadedEvent();

  @override
  List<Object> get props => [];
}
