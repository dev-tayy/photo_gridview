import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:photo_view/data/photo.model.dart';

class MockProfileImage extends Mock implements ProfileImage {}

class MockSocial extends Mock implements Social {}

void main() {
  test('Urls - fromJson', () {
    // Arrange
    const json = {
      'raw': 'https://example.com/raw.jpg',
      'full': 'https://example.com/full.jpg',
      'regular': 'https://example.com/regular.jpg',
    };

    // Act
    final urls = Urls.fromJson(json);

    // Assert
    expect(urls.raw, json['raw']);
    expect(urls.full, json['full']);
    expect(urls.regular, json['regular']);
  });

  test('Urls - toJson', () {
    // Arrange
    var urls = Urls(
      raw: 'https://example.com/raw.jpg',
      full: 'https://example.com/full.jpg',
      regular: 'https://example.com/regular.jpg',
    );

    // Act
    final json = urls.toJson();

    // Assert
    expect(json['raw'], urls.raw);
    expect(json['full'], urls.full);
    expect(json['regular'], urls.regular);
  });

  test('User - fromJson', () {
    // Arrange
    final json = {
      'id': '1',
      'username': 'john_doe',
      'name': 'John Doe',
      'first_name': 'John',
      'last_name': 'Doe',
      'bio': 'I am a developer',
      'location': 'New York',
      'profile_image': {
        'url': 'https://example.com/profile.jpg',
      },
      'instagram_username': 'john_doe_insta',
      'social': {
        'twitter': 'john_doe_twitter',
        'facebook': 'john_doe_facebook',
      },
    };

    // Act
    final user = User.fromJson(json);

    // Assert
    expect(user.id, json['id']);
    expect(user.username, json['username']);
    expect(user.name, json['name']);
    expect(user.firstName, json['first_name']);
    expect(user.lastName, json['last_name']);
    expect(user.bio, json['bio']);
    expect(user.location, json['location']);
    expect(user.profileImage, isNotNull);
    expect(user.instagramUsername, json['instagram_username']);
    expect(user.social, isNotNull);
  });

  test('User - toJson', () {
    // Arrange
    final user = User(
      id: '1',
      username: 'john_doe',
      name: 'John Doe',
      firstName: 'John',
      lastName: 'Doe',
      bio: 'I am a developer',
      location: 'New York',
      profileImage: ProfileImage(small: 'https://example.com/profile.jpg'),
      instagramUsername: 'john_doe_insta',
      social: Social(
        twitterUsername: 'john_doe_twitter',
        instagramUsername: 'john_doe_facebook',
      ),
    );

    // Act
    final json = user.toJson();

    // Assert
    expect(json['id'], user.id);
    expect(json['username'], user.username);
    expect(json['name'], user.name);
    expect(json['first_name'], user.firstName);
    expect(json['last_name'], user.lastName);
    expect(json['bio'], user.bio);
    expect(json['location'], user.location);
    expect(json['profile_image'], isNotNull);
    expect(json['instagram_username'], user.instagramUsername);
    expect(json['social'], isNotNull);
    expect(json['social']['twitter_username'], user.social!.twitterUsername);
    expect(
        json['social']['instagram_username'], user.social!.instagramUsername);
  });

  test('Social - fromJson', () {
    // Arrange
    final json = {
      'instagram_username': 'john_doe_insta',
      'portfolio_url': 'https://example.com/portfolio',
      'twitter_username': 'john_doe_twitter',
      'paypal_email': 'john_doe_paypal@example.com',
    };

    // Act
    final social = Social.fromJson(json);

    // Assert
    expect(social.instagramUsername, json['instagram_username']);
    expect(social.portfolioUrl, json['portfolio_url']);
    expect(social.twitterUsername, json['twitter_username']);
    expect(social.paypalEmail, json['paypal_email']);
  });

  test('Social - toJson', () {
    // Arrange
    final social = Social(
      instagramUsername: 'john_doe_insta',
      portfolioUrl: 'https://example.com/portfolio',
      twitterUsername: 'john_doe_twitter',
      paypalEmail: 'john_doe_paypal@example.com',
    );

    // Act
    final json = social.toJson();

    // Assert
    expect(json['instagram_username'], social.instagramUsername);
    expect(json['portfolio_url'], social.portfolioUrl);
    expect(json['twitter_username'], social.twitterUsername);
    expect(json['paypal_email'], social.paypalEmail);
  });

  test('ProfileImage - fromJson', () {
    // Arrange
    final json = {
      'small': 'https://example.com/small.jpg',
      'medium': 'https://example.com/medium.jpg',
      'large': 'https://example.com/large.jpg',
    };

    // Act
    final profileImage = ProfileImage.fromJson(json);

    // Assert
    expect(profileImage.small, json['small']);
    expect(profileImage.medium, json['medium']);
    expect(profileImage.large, json['large']);
  });

  test('ProfileImage - toJson', () {
    // Arrange
    final profileImage = ProfileImage(
      small: 'https://example.com/small.jpg',
      medium: 'https://example.com/medium.jpg',
      large: 'https://example.com/large.jpg',
    );

    // Act
    final json = profileImage.toJson();

    // Assert
    expect(json['small'], profileImage.small);
    expect(json['medium'], profileImage.medium);
    expect(json['large'], profileImage.large);
  });

  test('PhotoModel - fromJson', () {
    // Arrange
    final json = {
      'id': '12345',
      'slug': 'photo-slug',
      'created_at': '2022-01-01',
      'width': 800,
      'height': 600,
      'color': '#FFFFFF',
      'blur_hash': 'abc123',
      'description': 'Photo description',
      'alt_description': 'Alternate description',
      'urls': {
        'raw': 'https://example.com/photo.jpg',
        'full': 'https://example.com/photo_full.jpg',
        'regular': 'https://example.com/photo_regular.jpg',
      },
    };

    // Act
    final photoModel = PhotoModel.fromJson(json);

    // Assert
    expect(photoModel.id, json['id']);
    expect(photoModel.slug, json['slug']);
    expect(photoModel.createdAt, json['created_at']);
    expect(photoModel.width, json['width']);
    expect(photoModel.height, json['height']);
    expect(photoModel.color, json['color']);
    expect(photoModel.blurHash, json['blur_hash']);
    expect(photoModel.description, json['description']);
    expect(photoModel.altDescription, json['alt_description']);
  });

  test('PhotoModel - toJson', () {
    // Arrange
    final urls = Urls(
      raw: 'https://example.com/photo.jpg',
      full: 'https://example.com/photo_full.jpg',
      regular: 'https://example.com/photo_regular.jpg',
    );
    final profileImage = ProfileImage(
      small: 'https://example.com/user_small.jpg',
      medium: 'https://example.com/user_medium.jpg',
      large: 'https://example.com/user_large.jpg',
    );
    final social = Social(
      instagramUsername: 'john_doe',
      portfolioUrl: 'https://example.com/portfolio',
      twitterUsername: 'johndoe',
      paypalEmail: 'john.doe@example.com',
    );
    final user = User(
      id: '67890',
      username: 'user123',
      name: 'John Doe',
      firstName: 'John',
      lastName: 'Doe',
      bio: 'Photographer',
      location: 'New York',
      profileImage: profileImage,
      instagramUsername: 'john_doe',
      social: social,
    );
    final photoModel = PhotoModel(
      id: '12345',
      slug: 'photo-slug',
      createdAt: '2022-01-01',
      width: 800,
      height: 600,
      color: '#FFFFFF',
      blurHash: 'abc123',
      description: 'Photo description',
      altDescription: 'Alternate description',
      urls: urls,
      user: user,
    );

    // Act
    final json = photoModel.toJson();

    // Assert
    expect(json['id'], photoModel.id);
    expect(json['slug'], photoModel.slug);
    expect(json['created_at'], photoModel.createdAt);
    expect(json['width'], photoModel.width);
    expect(json['height'], photoModel.height);
    expect(json['color'], photoModel.color);
    expect(json['blur_hash'], photoModel.blurHash);
    expect(json['description'], photoModel.description);
    expect(json['alt_description'], photoModel.altDescription);
  });
}
