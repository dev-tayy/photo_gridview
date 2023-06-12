part of 'photo.bloc.dart';

abstract class PhotoState extends Equatable {
  @override
  List<Object> get props => [];
}

class PhotoInitial extends PhotoState {}

class FetchAllPhotosLoading extends PhotoState {}

class FetchAllPhotosSuccess extends PhotoState {
  FetchAllPhotosSuccess({required this.photos, required this.lastPage});
  final List<PhotoModel> photos;
  final int lastPage;
  @override
  List<Object> get props => [photos, lastPage];
}

class FetchAllPhotosError extends PhotoState {
  FetchAllPhotosError({required this.error});
  final String error;
  @override
  List<Object> get props => [error];
}
