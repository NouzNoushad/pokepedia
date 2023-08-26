part of 'card_bloc.dart';

sealed class CardEvent extends Equatable {
  const CardEvent();

  @override
  List<Object> get props => [];
}

class CardLoadedEvent extends CardEvent {
  const CardLoadedEvent();

  @override
  List<Object> get props => [];
}