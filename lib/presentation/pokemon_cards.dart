import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pokepedia/presentation/widgets/image_viewer.dart';
import 'package:pokepedia/utils/color.dart';

import '../data/bloc/card_bloc/card_bloc.dart';

class PokemonCards extends StatelessWidget {
  const PokemonCards({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPicker.background1,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: ColorPicker.background2,
        title: const Text('Pokepedia'),
        centerTitle: true,
      ),
      body: BlocConsumer<CardBloc, CardState>(
        listener: (context, state) {
          if (state is CardErrorState) {
            Fluttertoast.showToast(msg: 'Unable to fetch data');
          }
        },
        builder: (context, state) {
          if (state is CardLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: ColorPicker.background2,
              ),
            );
          }
          if (state is CardLoadedState) {
            return GridView.builder(
                itemCount: state.cards.length,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 4,
                    mainAxisSpacing: 15),
                itemBuilder: (context, index) {
                  var card = state.cards[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => Scaffold(
                            backgroundColor: ColorPicker.background3,
                            body: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: ImageViewer(
                                imageProvider: NetworkImage(
                                  card.imageUrlHiRes,
                                ),
                                loadingBuilder: (context, event) {
                                  if (event == null) {
                                    return Container(
                                      color: ColorPicker.background3,
                                      child: const Center(
                                        child: Text(
                                          "0%",
                                          style: TextStyle(
                                              color: ColorPicker.background1),
                                        ),
                                      ),
                                    );
                                  }

                                  final value = event.cumulativeBytesLoaded /
                                      (event.expectedTotalBytes ??
                                          event.cumulativeBytesLoaded);

                                  final percentage = (100 * value).floor();
                                  return Container(
                                      color: ColorPicker.background3,
                                      child: Center(
                                        child: Text(
                                          "$percentage%",
                                          style: const TextStyle(
                                              color: ColorPicker.background1),
                                        ),
                                      ));
                                },
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    child: Image.network(
                      card.imageUrl,
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
