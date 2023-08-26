import 'package:flutter/material.dart';
import 'package:pokepedia/data/model/pokemon_details_response.dart';
import 'package:pokepedia/presentation/pokemon_details.dart';
import 'package:pokepedia/routes/route_string.dart';
import 'package:pokepedia/presentation/pokemons.dart';
import 'package:pokepedia/utils/color.dart';

class Routes {
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteString.pokemon:
        return MaterialPageRoute(
            settings: const RouteSettings(name: RouteString.pokemon),
            builder: (context) => const PokemonHome());
      case RouteString.pokemonDetails:
        return MaterialPageRoute(
            settings: const RouteSettings(name: RouteString.pokemonDetails),
            builder: (context) =>  PokemonDetails(pokemonDetails: settings.arguments as PokemonDetailsResponse,));
      default:
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            backgroundColor: ColorPicker.background1,
            appBar: AppBar(title: const Text('Error')),
            body: const Center(child: Text('Route Error')),
          ),
        );
    }
  }
}
