import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokepedia/data/bloc/pokemon_bloc/pokemon_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pokepedia/presentation/pokemon_cards.dart';
import 'package:pokepedia/routes/route_string.dart';
import '../utils/color.dart';

class PokemonHome extends StatefulWidget {
  const PokemonHome({super.key});

  @override
  State<PokemonHome> createState() => _PokemonHomeState();
}

class _PokemonHomeState extends State<PokemonHome> {
  int selectedIndex = 0;

  switchPages(int index) {
    switch (index) {
      case 0:
        return const PokemonList();
      case 1:
        return const PokemonCards();
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPicker.backgroundLight2,
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
          backgroundColor: ColorPicker.background2,
          selectedFontSize: 17,
          selectedItemColor: ColorPicker.background1,
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.w500,
          ),
          unselectedFontSize: 17,
          unselectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.w500,
          ),
          iconSize: 0,
          items: const [
            BottomNavigationBarItem(
              label: 'Pokemon',
              icon: Icon(Icons.gamepad),
            ),
            BottomNavigationBarItem(
              label: 'Cards',
              icon: Icon(Icons.gamepad),
            ),
          ]),
      body: switchPages(selectedIndex),
    );
  }
}

class PokemonList extends StatelessWidget {
  const PokemonList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPicker.backgroundLight2,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: ColorPicker.background2,
        title: const Text('Pokepedia'),
        centerTitle: true,
      ),
      body: BlocConsumer<PokemonBloc, PokemonState>(
        listener: (context, state) {
          if (state is PokemonErrorState) {
            Fluttertoast.showToast(msg: 'Unable to fetch data');
          }
        },
        builder: (context, state) {
          if (state is PokemonLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: ColorPicker.background2,
              ),
            );
          }
          if (state is PokemonLoadedState) {
            return GridView.builder(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                itemCount: state.pokemon.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 4,
                    mainAxisSpacing: 4,
                    childAspectRatio: 1.2),
                itemBuilder: (context, index) {
                  var pokemon = state.pokemon[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, RouteString.pokemonDetails,
                          arguments: pokemon);
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      color: ColorPicker.background1,
                      child: Column(children: [
                        Image.network(
                          pokemon.sprites.other!.home.frontDefault,
                          scale: 5,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          pokemon.name[0].toUpperCase() +
                              pokemon.name.substring(1).toLowerCase(),
                          style: const TextStyle(
                            fontSize: 18,
                            letterSpacing: 1.2,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ]),
                    ),
                  );
                });
          }
          return Container();
        },
      ),
    );
  }
}
