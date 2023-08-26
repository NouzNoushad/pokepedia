import 'package:flutter/material.dart';
import 'package:pokepedia/data/bloc/pokemon_bloc/pokemon_bloc.dart';
import 'package:pokepedia/routes/route_string.dart';
import 'package:pokepedia/routes/routes.dart';
import 'package:pokepedia/utils/color.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'data/bloc/card_bloc/card_bloc.dart';
import 'data/repositories/card_repository.dart';
import 'data/repositories/pokemon_repository.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => PokemonRepository(),
        ),
        RepositoryProvider(
          create: (context) => CardRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => PokemonBloc(
              pokemonRepository:
                  RepositoryProvider.of<PokemonRepository>(context),
            )..add(const PokemonLoadedEvent()),
          ),
          BlocProvider(
            create: (context) => CardBloc(
              cardRepository: RepositoryProvider.of<CardRepository>(context),
            )..add(const CardLoadedEvent()),
          ),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme:
                ColorScheme.fromSeed(seedColor: ColorPicker.colorScheme),
          ),
          debugShowCheckedModeBanner: false,
          onGenerateRoute: Routes.onGenerateRoute,
          initialRoute: RouteString.pokemon,
        ),
      ),
    );
  }
}
