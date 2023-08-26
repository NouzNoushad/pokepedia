import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pokepedia/data/repositories/pokemon_repository.dart';

import '../../model/pokemon_species_response.dart';

part 'evolution_event.dart';
part 'evolution_state.dart';

class EvolutionBloc extends Bloc<EvolutionEvent, EvolutionState> {
  final PokemonRepository pokemonRepository;
  EvolutionBloc({required this.pokemonRepository}) : super(EvolutionInitial()) {
    on<EvolutionLoadedEvent>(pokemonEvolution);
  }

  FutureOr<void> pokemonEvolution(
      EvolutionLoadedEvent event, Emitter<EvolutionState> emit) async {
    emit(EvolutionLoading());
    try {
      List<PokemonSpeciesResponse> evolution =
          await pokemonRepository.getPokemonEvolution(event.evolutionUrl);
      emit(EvolutionLoadedState(evolution));
    } catch (error) {
      emit(EvolutionErrorState(error.toString()));
    }
  }
}
