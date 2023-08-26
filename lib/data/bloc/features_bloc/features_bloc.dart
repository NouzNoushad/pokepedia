import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pokepedia/data/repositories/pokemon_repository.dart';

import '../../model/pokemon_species_response.dart';

part 'features_event.dart';
part 'features_state.dart';

class FeaturesBloc extends Bloc<FeaturesEvent, FeaturesState> {
  final PokemonRepository pokemonRepository;
  FeaturesBloc({
    required this.pokemonRepository,
  }) : super(FeaturesInitial()) {
    on<FeaturesLoadedEvent>(pokemonFeatures);
  }

  FutureOr<void> pokemonFeatures(
      FeaturesLoadedEvent event, Emitter<FeaturesState> emit) async {
    emit(FeaturesLoading());
    try {
      PokemonSpeciesResponse pokemon =
          await pokemonRepository.getPokemonSpecies(event.speciesUrl);
      emit(FeaturesLoadedState(pokemon));
    } catch (error) {
      emit(FeaturesErrorState(error.toString()));
    }
  }
}
