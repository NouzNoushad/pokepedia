part of 'card_bloc.dart';

sealed class CardState extends Equatable {
  const CardState();
  
  @override
  List<Object> get props => [];
}

final class CardInitial extends CardState {}

final class CardLoading extends CardState {}

class CardLoadedState extends CardState {
  final List<Cards> cards;
  const CardLoadedState(this.cards);

  @override
  List<Object> get props => [cards];
}

class CardErrorState extends CardState {
  final String error;
  const CardErrorState(this.error);

  @override
  List<Object> get props => [error];
}
