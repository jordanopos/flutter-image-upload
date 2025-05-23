part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class PickFile extends HomeEvent {
  final ImageSource imageSource;

  const PickFile(this.imageSource);
}

class RemoveFile extends HomeEvent{}
