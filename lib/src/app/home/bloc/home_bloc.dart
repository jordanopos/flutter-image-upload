import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_image_picker/src/app/home/repository/home_repository.dart';
import 'package:image_picker/image_picker.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository homeRepository;

  HomeBloc(this.homeRepository) : super(HomeInitial()) {
    on<HomeEvent>((event, emit) async {
      if (event is PickFile) {
        try {
          emit(HomeLoading());

          XFile? pickedFile = await homeRepository.pickImage(event.imageSource);

          emit(HomeLoaded(pickedFile));
        } catch (e) {
          emit(HomeLoadingError(e.toString()));
        }
      } else if (event is RemoveFile) {
        emit(HomeInitial());
      }
    });
  }
}
