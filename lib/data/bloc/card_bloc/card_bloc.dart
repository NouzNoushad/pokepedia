import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pokepedia/data/repositories/card_repository.dart';

import '../../model/pokemon_card_response.dart';

part 'card_event.dart';
part 'card_state.dart';

class CardBloc extends Bloc<CardEvent, CardState> {
  final CardRepository cardRepository;
  CardBloc({required this.cardRepository}) : super(CardInitial()) {
    on<CardLoadedEvent>(fetchPokemonCards);
  }

  FutureOr<void> fetchPokemonCards(
      CardLoadedEvent event, Emitter<CardState> emit) async {
    emit(CardLoading());
    try {
      List<Cards> cards = await cardRepository.getPokemonCards();
      emit(CardLoadedState(cards));
    } catch (error) {
      emit(CardErrorState(error.toString()));
    }
  }
}
