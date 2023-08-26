part of 'evolution_bloc.dart';

sealed class EvolutionEvent extends Equatable {
  const EvolutionEvent();

  @override
  List<Object> get props => [];
}

class EvolutionLoadedEvent extends EvolutionEvent {
  final String evolutionUrl;
  const EvolutionLoadedEvent(this.evolutionUrl);

  @override
  List<Object> get props => [evolutionUrl];
}
