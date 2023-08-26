part of 'evolution_bloc.dart';

sealed class EvolutionState extends Equatable {
  const EvolutionState();
  
  @override
  List<Object> get props => [];
}

final class EvolutionInitial extends EvolutionState {}

final class EvolutionLoading extends EvolutionState {}

class EvolutionLoadedState extends EvolutionState {
  final List<PokemonSpeciesResponse> evolutionList;
  const EvolutionLoadedState(this.evolutionList);

  @override
  List<Object> get props => [evolutionList];
}

class EvolutionErrorState extends EvolutionState {
  final String error;
  const EvolutionErrorState(this.error);

  @override
  List<Object> get props => [error];
}
