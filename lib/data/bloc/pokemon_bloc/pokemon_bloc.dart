import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pokepedia/data/repositories/pokemon_repository.dart';

import '../../model/pokemon_details_response.dart';

part 'pokemon_event.dart';
part 'pokemon_state.dart';

class PokemonBloc extends Bloc<PokemonEvent, PokemonState> {
  final PokemonRepository pokemonRepository;
  PokemonBloc({required this.pokemonRepository}) : super(PokemonInitial()) {
    on<PokemonLoadedEvent>(fetchPokemon);
  }

  FutureOr<void> fetchPokemon(
      PokemonLoadedEvent event, Emitter<PokemonState> emit) async {
    emit(PokemonLoading());
    try {
      List<PokemonDetailsResponse> pokemon =
          await pokemonRepository.getPokemonList();
      emit(PokemonLoadedState(pokemon));
    } catch (error) {
      emit(PokemonErrorState(error.toString()));
    }
  }
}
