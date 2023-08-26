import 'package:flutter/material.dart';
import 'package:pokepedia/data/model/pokemon_species_response.dart';
import 'package:pokepedia/utils/color.dart';

import '../../data/model/pokemon_details_response.dart';

class AboutPokemon extends StatefulWidget {
  final PokemonSpeciesResponse pokemonSpecies;
  final PokemonDetailsResponse pokemonDetails;
  const AboutPokemon(
      {super.key, required this.pokemonSpecies, required this.pokemonDetails});

  @override
  State<AboutPokemon> createState() => _AboutPokemonState();
}

class _AboutPokemonState extends State<AboutPokemon> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      children: [
        Text(
          widget.pokemonSpecies.flavorTextEntries[1].flavorText
              .replaceAll('\n', ''),
          style: const TextStyle(fontSize: 15, height: 1.5),
        ),
        const SizedBox(
          height: 8,
        ),
        const Text(
          'Pokepedia Data',
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: ColorPicker.background2),
        ),
        const SizedBox(
          height: 10,
        ),
        pokemonData(
            title: 'Category', data: widget.pokemonSpecies.genera[7].genus),
        pokemonData(
            title: 'Height', data: '${widget.pokemonDetails.height / 10} m'),
        pokemonData(
            title: 'Weight', data: '${widget.pokemonDetails.weight / 10} kg'),
        pokemonData(
            title: 'Capture Rate',
            data: '${widget.pokemonSpecies.captureRate}'),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Expanded(
              child: Text(
                'Abilities',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: List.generate(
                    widget.pokemonDetails.abilities.length,
                    (index) => Text(
                      widget.pokemonDetails.abilities[index].ability.name,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ).toList(),
                )),
          ],
        ),
        const Text(
          'Training',
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: ColorPicker.background2),
        ),
        const SizedBox(
          height: 10,
        ),
        pokemonData(
            title: 'Catch Rate', data: '${widget.pokemonSpecies.captureRate}'),
        pokemonData(
            title: 'Base Happiness',
            data: '${widget.pokemonSpecies.baseHappiness}'),
        pokemonData(
            title: 'Growth Rate', data: widget.pokemonSpecies.growthRate.name),
      ],
    );
  }

  Widget pokemonData({required String title, required String data}) => Padding(
        padding: const EdgeInsets.only(bottom: 5),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  data,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}
