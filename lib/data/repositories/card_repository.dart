import 'package:flutter/material.dart';
import 'package:pokepedia/utils/end_point.dart';
import 'package:http/http.dart' as http;

import '../model/pokemon_card_response.dart';

class CardRepository {
  Future<List<Cards>> getPokemonCards() async {
    List<Cards> cards = [];
    Uri url = Uri.parse(EndPoints.pokemonCardsUrl);
    var response = await http.get(url);
    debugPrint('////////////////// cards: ${response.statusCode == 200}');
    if (response.statusCode == 200) {
      debugPrint('////////////////// cards: ${response.body}');
      PokemonCardResponse pokemonCardResponse =
          pokemonCardResponseFromJson(response.body);

      cards = pokemonCardResponse.cards;
    } else {
      throw Exception('Unable to connect');
    }
    return cards;
  }
}
