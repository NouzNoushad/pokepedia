import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:pokepedia/data/model/pokemon_details_response.dart';
import 'package:pokepedia/data/model/pokemon_response.dart';

import '../../utils/end_point.dart';
import '../model/pokemon_evolution_response.dart';
import '../model/pokemon_species_response.dart';

class PokemonRepository {
  Client baseClient = Client();
  List<String> evolutionUrls = [];

  Future<List<PokemonDetailsResponse>> getPokemonList() async {
    List<PokemonDetailsResponse> pokemonDetails;
    String endPoint = EndPoints.pokemonListEndPoint();
    Uri url = Uri.parse(endPoint);
    var response = await baseClient.get(url);
    if (response.statusCode == 200) {
      PokemonResponse pokemon = pokemonResponseFromJson(response.body);
      var pokemonResult = pokemon.results;
      debugPrint('////////// response: ${pokemonResult[0].name}');
      pokemonDetails = await Future.wait(
        pokemonResult.map((pokemon) async {
          return await getPokemon(pokemon.url);
        }).toList(),
      );
    } else {
      throw Exception('Could not fetch pokemon');
    }
    return pokemonDetails;
  }

  Future<PokemonDetailsResponse> getPokemon(String pokemonUrl) async {
    PokemonDetailsResponse pokemonDetailsResponse;
    Uri url = Uri.parse(pokemonUrl);
    var response = await baseClient.get(url);
    if (response.statusCode == 200) {
      pokemonDetailsResponse = pokemonDetailsResponseFromJson(response.body);
      // debugPrint(
      //     '////////// response: ${pokemonDetailsResponse.sprites.other!.home.frontDefault}');
    } else {
      throw Exception('Could not fetch pokemon details');
    }
    return pokemonDetailsResponse;
  }

  Future<PokemonSpeciesResponse> getPokemonSpecies(String speciesUrl) async {
    PokemonSpeciesResponse pokemonSpeciesResponse;
    Uri url = Uri.parse(speciesUrl);
    var response = await baseClient.get(url);
    if (response.statusCode == 200) {
      pokemonSpeciesResponse = pokemonSpeciesResponseFromJson(response.body);
      // debugPrint(
      //     '////////// response: ${pokemonSpeciesResponse.baseHappiness}');
    } else {
      throw Exception('Could not fetch pokemon species');
    }
    return pokemonSpeciesResponse;
  }

  Future<List<PokemonSpeciesResponse>> getPokemonEvolution(
      String evolutionUrl) async {
    List<PokemonSpeciesResponse> pokemonEvolutionList;
    evolutionUrls = [];
    Uri url = Uri.parse(evolutionUrl);
    var response = await baseClient.get(url);
    if (response.statusCode == 200) {
      var pokemonEvolutionResponse =
          pokemonEvolutionResponseFromJson(response.body);
      debugPrint('////////// response: ${pokemonEvolutionResponse.chain}');
      pokemonEvolutionList =
          await loopEvolutionChain(pokemonEvolutionResponse.chain.evolvesTo);
    } else {
      throw Exception('Could not fetch pokemon species');
    }
    return pokemonEvolutionList;
  }

  Future<List<PokemonSpeciesResponse>> loopEvolutionChain(
      List<Chain> evolutionList) async {
    if (evolutionList.isNotEmpty) {
      for (Chain evolution in evolutionList) {
        loopEvolutionChain(evolution.evolvesTo);
        evolutionUrls.add(evolution.species.url);
      }
    }
    debugPrint('////////////// evolution url chain : $evolutionUrls');
    List<PokemonSpeciesResponse> pokemonList =
        await Future.wait(evolutionUrls.map((url) async {
      return await getPokemonSpecies(url);
    }).toList());
    return pokemonList;
  }
}
