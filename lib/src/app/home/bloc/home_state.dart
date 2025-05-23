part of 'home_bloc.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

final class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final XFile? file;

  const HomeLoaded(this.file);
}

class HomeLoadingError extends HomeState {
  final String message;

  const HomeLoadingError(this.message);
}
