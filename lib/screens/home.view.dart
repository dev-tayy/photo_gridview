import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:photo_view/bloc/photo.bloc.dart';
import 'package:photo_view/components/components.dart';
import 'package:photo_view/data/photo.model.dart';
import 'package:photo_view/screens/photo.view.dart';

class MyHomePage extends HookWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final photoBloc = BlocProvider.of<PhotoBloc>(context);
    final photos = useState(getPhotos);
    final lastPage = useState(1000);
    final currentPage = useState(1);
    final isLoading = useState(photos.value.isEmpty);
    final isOnStart = useState(isLoading.value);
    final scrollController = useScrollController();

    //fetch and cache photos on initialization of widget
    useMemoized(() {
      if (photos.value.isEmpty) {
        isLoading.value = true;
        photoBloc
            .add(FetchAllPhotosEvent(page: currentPage.value, perPage: 10));
      }
    }, []);

    //infinity scroll pagination implementation
    useEffect(() {
      scrollController.addListener(() {
        if (lastPage.value != currentPage.value) {
          if (scrollController.position.maxScrollExtent ==
              scrollController.offset) {
            currentPage.value++;
            photoBloc
                .add(FetchAllPhotosEvent(page: currentPage.value, perPage: 10));
          }
        }
      });
      return () => scrollController.removeListener(() {});
    }, []);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: BlocListener(
                bloc: photoBloc,
                listener: (context, state) {
                  if (state is FetchAllPhotosLoading) {
                    isLoading.value = true;
                    if (!isOnStart.value) toast('Please wait...');
                  }
                  if (state is FetchAllPhotosSuccess) {
                    isOnStart.value = false;
                    photos.value.addAll(state.photos);
                    lastPage.value = state.lastPage;
                  }
                  if (state is FetchAllPhotosError) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                        state.error,
                        style: const TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Colors.redAccent,
                    ));
                  }
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 20),
                    const Text(
                      'Hello, Good day 👋',
                      style: TextStyle(
                        fontSize: 26,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'View latest photos from amazing artists all over the world on Unsplash',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Expanded(
                      child: Visibility(
                        visible: !(isLoading.value && isOnStart.value),
                        replacement: Transform.scale(
                          scale: 0.6,
                          child: const TextLoadingView(),
                        ),
                        child: GridView.builder(
                          controller: scrollController,
                          itemCount: photos.value.length,
                          shrinkWrap: true,
                          padding: const EdgeInsets.only(bottom: 10),
                          physics: const BouncingScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 200,
                            childAspectRatio: 3 / 4.2,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 10,
                          ),
                          itemBuilder: (context, index) {
                            final photo = photos.value[index];
                            return GridContent(
                              title: photo.altDescription ?? '',
                              url: photo.urls!.regular!,
                              artist: photo.user!.firstName!,
                              onPressed: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return PhotoView(photo: photo);
                                }));
                              },
                            );
                          },
                        ),
                      ),
                    )
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
