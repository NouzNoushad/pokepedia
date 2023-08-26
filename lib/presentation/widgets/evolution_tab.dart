import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pokepedia/data/bloc/evolution_bloc/evolution_bloc.dart';
import 'package:pokepedia/data/repositories/pokemon_repository.dart';
import 'package:pokepedia/utils/color.dart';
import 'package:pokepedia/utils/end_point.dart';

import '../../data/model/pokemon_details_response.dart';
import '../../data/model/pokemon_species_response.dart';

class PokemonEvolution extends StatefulWidget {
  final PokemonSpeciesResponse pokemonSpecies;
  final PokemonDetailsResponse pokemonDetails;
  const PokemonEvolution(
      {super.key, required this.pokemonSpecies, required this.pokemonDetails});

  @override
  State<PokemonEvolution> createState() => _PokemonEvolutionState();
}

class _PokemonEvolutionState extends State<PokemonEvolution> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EvolutionBloc(
        pokemonRepository: RepositoryProvider.of<PokemonRepository>(context),
      )..add(EvolutionLoadedEvent(widget.pokemonSpecies.evolutionChain.url)),
      child: BlocConsumer<EvolutionBloc, EvolutionState>(
        listener: (context, state) {
          if (state is EvolutionErrorState) {
            Fluttertoast.showToast(msg: 'Unable to fetch data');
          }
        },
        builder: (context, state) {
          if (state is EvolutionLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: ColorPicker.background2,
              ),
            );
          }
          if (state is EvolutionLoadedState) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: ListView.separated(
                itemCount: state.evolutionList.length,
                separatorBuilder: (context, index) => const SizedBox(
                  height: 10,
                ),
                itemBuilder: (context, index) {
                  var evolution = state.evolutionList[index];
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 80,
                        backgroundColor: ColorPicker.backgroundLight2,
                        child: Image.network(
                          EndPoints.getImage(evolution.id),
                          // height: 100,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      RotatedBox(
                        quarterTurns: 1,
                        child: Text(
                          evolution.name,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
