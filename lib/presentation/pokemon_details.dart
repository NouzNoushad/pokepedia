import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pokepedia/data/bloc/features_bloc/features_bloc.dart';
import 'package:pokepedia/data/repositories/pokemon_repository.dart';
import 'package:pokepedia/presentation/widgets/about_tab.dart';
import 'package:pokepedia/presentation/widgets/evolution_tab.dart';
import 'package:pokepedia/presentation/widgets/status_tab.dart';
import 'package:pokepedia/utils/color.dart';
import 'package:pokepedia/utils/constants.dart';

import '../data/model/pokemon_details_response.dart';

class PokemonDetails extends StatefulWidget {
  final PokemonDetailsResponse pokemonDetails;
  const PokemonDetails({super.key, required this.pokemonDetails});

  @override
  State<PokemonDetails> createState() => _PokemonDetailsState();
}

class _PokemonDetailsState extends State<PokemonDetails>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FeaturesBloc(
        pokemonRepository: RepositoryProvider.of<PokemonRepository>(context),
      )..add(FeaturesLoadedEvent(widget.pokemonDetails.species.url)),
      child: Scaffold(
        backgroundColor: ColorPicker.background1,
        appBar: AppBar(
          title: const Text('Pokepedia'),
          backgroundColor: ColorPicker.background2,
        ),
        body: BlocConsumer<FeaturesBloc, FeaturesState>(
          listener: (context, state) {
            if (state is FeaturesErrorState) {
              Fluttertoast.showToast(msg: 'Unable to fetch data');
            }
          },
          builder: (context, state) {
            if (state is FeaturesLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: ColorPicker.background2,
                ),
              );
            }
            if (state is FeaturesLoadedState) {
              return Column(children: [
                Expanded(
                    flex: 2,
                    child: Container(
                      // color: Colors.yellow,
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      child: Stack(children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${'#'.padRight(3, '0')}${widget.pokemonDetails.id}',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              widget.pokemonDetails.name[0].toUpperCase() +
                                  widget.pokemonDetails.name
                                      .substring(1)
                                      .toLowerCase(),
                              style: const TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            ...List.generate(
                              widget.pokemonDetails.types.length,
                              (index) => Text(
                                widget.pokemonDetails.types[index].type.name,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            )
                          ],
                        ),
                        Positioned(
                            bottom: -10,
                            right: 0,
                            child: Image.network(
                              widget.pokemonDetails.sprites.other!.home
                                  .frontDefault,
                              height: 200,
                            ))
                      ]),
                    )),
                Expanded(
                    flex: 4,
                    child: Container(
                      // color: Colors.blue,
                      child: Column(children: [
                        Material(
                          color: ColorPicker.background2,
                          child: TabBar(
                            controller: tabController,
                            labelPadding: const EdgeInsets.all(10),
                            indicatorColor: ColorPicker.background1,
                            labelColor: ColorPicker.background1,
                            tabs: List.generate(pokemonTabs.length,
                                (index) => Text(pokemonTabs[index])),
                          ),
                        ),
                        Expanded(
                          child:
                              TabBarView(controller: tabController, children: [
                            AboutPokemon(
                              pokemonSpecies: state.pokemon,
                              pokemonDetails: widget.pokemonDetails,
                            ),
                            PokemonStatus(
                                pokemonSpecies: state.pokemon,
                                pokemonDetails: widget.pokemonDetails),
                            PokemonEvolution(
                                pokemonSpecies: state.pokemon,
                                pokemonDetails: widget.pokemonDetails),
                          ]),
                        ),
                      ]),
                    )),
              ]);
            }
            return Container();
          },
        ),
      ),
    );
  }
}
