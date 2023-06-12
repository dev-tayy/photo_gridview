import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:photo_view/bloc/photo.bloc.dart';
import 'package:photo_view/data/photo.repository.dart';

class MockPhotoRepository extends Mock implements PhotoRepository {}

void main() {
  group('PhotoBloc', () {
    late PhotoRepository photoRepository;
    late PhotoBloc photoBloc;

    setUp(() {
      photoRepository = MockPhotoRepository();
      photoBloc = PhotoBloc(photoRepository);
    });

    tearDown(() {
      photoBloc.close();
    });

    test('initial state is PhotoInitial', () {
      expect(photoBloc.state, equals(PhotoInitial()));
    });

    blocTest<PhotoBloc, PhotoState>(
      'emits [FetchAllPhotosLoading, FetchAllPhotosSuccess] when FetchAllPhotosEvent is added',
      build: () {
        when(() => photoRepository.fetchAllPhotos(
                page: any(named: 'page'), perPage: any(named: 'perPage')))
            .thenAnswer((_) async =>
                const Right(([], 1))); // Mock the repository's response
        return photoBloc;
      },
      act: (bloc) => bloc.add(FetchAllPhotosEvent(page: 1, perPage: 10)),
      expect: () => [
        FetchAllPhotosLoading(),
        FetchAllPhotosSuccess(photos: const [], lastPage: 1),
      ],
    );

    blocTest<PhotoBloc, PhotoState>(
      'emits [FetchAllPhotosLoading, FetchAllPhotosError] when FetchAllPhotosEvent throws an error',
      build: () {
        when(() => photoRepository.fetchAllPhotos(
                page: any(named: 'page'), perPage: any(named: 'perPage')))
            .thenAnswer((_) async => const Left(
                'Error')); // Mock the repository's response with an error
        return photoBloc;
      },
      act: (bloc) => bloc.add(FetchAllPhotosEvent(page: 1, perPage: 10)),
      expect: () => [
        FetchAllPhotosLoading(),
        FetchAllPhotosError(error: 'Error'),
      ],
    );

    group('FetchAllPhotosEvent', () {
      test('props should return correct values', () {
        final event1 = FetchAllPhotosEvent(page: 1, perPage: 10);
        final event2 = FetchAllPhotosEvent(page: 1, perPage: 10);
        final event3 = FetchAllPhotosEvent(page: 2, perPage: 10);

        expect(event1.props, equals([1, 10]));
        expect(event2.props, equals([1, 10]));
        expect(event3.props, equals([2, 10]));

        expect(event1.props, equals(event2.props));
        expect(event1.props, isNot(equals(event3.props)));
      });
    });
  });
}
