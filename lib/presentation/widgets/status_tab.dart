import 'package:flutter/material.dart';
import 'package:pokepedia/utils/color.dart';

import '../../data/model/pokemon_details_response.dart';
import '../../data/model/pokemon_species_response.dart';

class PokemonStatus extends StatefulWidget {
  final PokemonSpeciesResponse pokemonSpecies;
  final PokemonDetailsResponse pokemonDetails;
  const PokemonStatus(
      {super.key, required this.pokemonSpecies, required this.pokemonDetails});

  @override
  State<PokemonStatus> createState() => _PokemonStatusState();
}

class _PokemonStatusState extends State<PokemonStatus> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: widget.pokemonDetails.stats.length,
      separatorBuilder: (context, index) => const SizedBox(
        height: 10,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      itemBuilder: (context, index) {
        final status = widget.pokemonDetails.stats[index];
        return Row(
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    status.stat.name[0].toUpperCase() +
                        status.stat.name.substring(1).toLowerCase(),
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    status.baseStat.toString(),
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              flex: 1,
              child: LinearProgressIndicator(
                value: status.baseStat / 200,
                backgroundColor: ColorPicker.backgroundLight2,
                color: ColorPicker.background2,
                minHeight: 10,
              ),
            ),
          ],
        );
      },
    );
  }
}
