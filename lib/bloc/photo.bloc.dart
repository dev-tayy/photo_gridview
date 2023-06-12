import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_view/data/photo.model.dart';
import 'package:photo_view/data/photo.repository.dart';

part 'photo.event.dart';
part 'photo.state.dart';

class PhotoBloc extends Bloc<PhotoEvent, PhotoState> {
  PhotoBloc(this.photoRepository) : super(PhotoInitial()) {
    on<FetchAllPhotosEvent>((event, emit) async {
      emit(FetchAllPhotosLoading());
      final response = await photoRepository.fetchAllPhotos(
        page: event.page,
        perPage: event.perPage,
      );
      response.fold(
        (err) => emit(FetchAllPhotosError(error: err)),
        (data) => emit(FetchAllPhotosSuccess(
          photos: data.$1,
          lastPage: data.$2,
        )),
      );
    });
  }
  final PhotoRepository photoRepository;
}
