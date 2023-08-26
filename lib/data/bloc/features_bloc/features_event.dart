part of 'features_bloc.dart';

sealed class FeaturesEvent extends Equatable {
  const FeaturesEvent();

  @override
  List<Object> get props => [];
}

class FeaturesLoadedEvent extends FeaturesEvent {
  final String speciesUrl;
  const FeaturesLoadedEvent(this.speciesUrl);

  @override
  List<Object> get props => [speciesUrl];
}
