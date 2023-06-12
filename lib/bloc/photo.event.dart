part of 'photo.bloc.dart';

abstract class PhotoEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchAllPhotosEvent extends PhotoEvent {
  FetchAllPhotosEvent({required this.page, required this.perPage});
  final int page, perPage;

  @override
  List<Object> get props => [page, perPage];
}
