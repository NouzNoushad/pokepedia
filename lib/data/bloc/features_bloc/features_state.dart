part of 'features_bloc.dart';

sealed class FeaturesState extends Equatable {
  const FeaturesState();

  @override
  List<Object> get props => [];
}

final class FeaturesInitial extends FeaturesState {}

final class FeaturesLoading extends FeaturesState {}

class FeaturesLoadedState extends FeaturesState {
  final PokemonSpeciesResponse pokemon;
  const FeaturesLoadedState(this.pokemon);

  @override
  List<Object> get props => [pokemon];
}

class FeaturesErrorState extends FeaturesState {
  final String error;
  const FeaturesErrorState(this.error);

  @override
  List<Object> get props => [error];
}
