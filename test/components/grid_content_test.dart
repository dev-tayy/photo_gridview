import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:photo_view/components/components.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('GridContent - Displayed Content', (WidgetTester tester) async {
    // Arrange
    const title = 'Sample Title';
    const artist = 'Sample Artist';
    const imageUrl = 'https://example.com/image.jpg';
    // Act
    await mockNetworkImagesFor(() => tester.pumpWidget(
          MaterialApp(
            home: Material(
              child: GridContent(
                title: title,
                artist: artist,
                url: imageUrl,
                onPressed: () {},
              ),
            ),
          ),
        ));

    // Assert
    expect(find.text(title), findsOneWidget);
    expect(find.text('By: $artist'), findsOneWidget);
    expect(find.byType(CupertinoButton), findsOneWidget);
    expect(find.byType(CachedNetworkImage), findsOneWidget);
  });

  testWidgets('GridContent - Placeholder Shown when Loading Image',
      (WidgetTester tester) async {
    // Arrange
    const title = 'Sample Title';
    const artist = 'Sample Artist';
    const imageUrl = 'https://example.com/image.jpg';

    // Act
    await mockNetworkImagesFor(() => tester.pumpWidget(
          MaterialApp(
            home: Material(
              child: GridContent(
                title: title,
                artist: artist,
                url: imageUrl,
                onPressed: () {},
              ),
            ),
          ),
        ));

    // Assert
    expect(find.byType(TextLoadingView), findsOneWidget);
  });

}
