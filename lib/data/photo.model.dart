import 'package:hive_flutter/hive_flutter.dart';
import 'package:photo_view/app.manager.dart';
import 'package:photo_view/utils/utils.dart';
part 'photo.model.g.dart';

@HiveType(typeId: 0)
class PhotoModel {
  @HiveField(0)
  String? id;
  @HiveField(1)
  String? slug;
  @HiveField(2)
  String? createdAt;
  @HiveField(3)
  int? width;
  @HiveField(4)
  int? height;
  @HiveField(5)
  String? color;
  @HiveField(6)
  String? blurHash;
  @HiveField(7)
  String? description;
  @HiveField(8)
  String? altDescription;
  @HiveField(9)
  Urls? urls;
  @HiveField(10)
  User? user;

  PhotoModel(
      {this.id,
      this.slug,
      this.createdAt,
      this.width,
      this.height,
      this.color,
      this.blurHash,
      this.description,
      this.altDescription,
      this.urls,
      this.user});

  PhotoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    slug = json['slug'];
    createdAt = json['created_at'];
    width = json['width'];
    height = json['height'];
    color = json['color'];
    blurHash = json['blur_hash'];
    description = json['description'];
    altDescription = json['alt_description'];
    urls = json['urls'] != null ? Urls.fromJson(json['urls']) : null;
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['slug'] = slug;
    data['created_at'] = createdAt;
    data['width'] = width;
    data['height'] = height;
    data['color'] = color;
    data['blur_hash'] = blurHash;
    data['description'] = description;
    data['alt_description'] = altDescription;
    if (urls != null) {
      data['urls'] = urls!.toJson();
    }
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

@HiveType(typeId: 1)
class Urls {
  @HiveField(0)
  String? raw;
  @HiveField(1)
  String? full;
  @HiveField(2)
  String? regular;

  Urls({
    this.raw,
    this.full,
    this.regular,
  });

  Urls.fromJson(Map<String, dynamic> json) {
    raw = json['raw'];
    full = json['full'];
    regular = json['regular'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['raw'] = raw;
    data['full'] = full;
    data['regular'] = regular;
    return data;
  }
}

@HiveType(typeId: 2)
class User {
  @HiveField(0)
  String? id;
  @HiveField(1)
  String? username;
  @HiveField(2)
  String? name;
  @HiveField(3)
  String? firstName;
  @HiveField(4)
  String? lastName;
  @HiveField(5)
  String? bio;
  @HiveField(6)
  String? location;
  @HiveField(7)
  ProfileImage? profileImage;
  @HiveField(8)
  String? instagramUsername;
  @HiveField(9)
  Social? social;

  User(
      {this.id,
      this.username,
      this.name,
      this.firstName,
      this.lastName,
      this.bio,
      this.location,
      this.profileImage,
      this.instagramUsername,
      this.social});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    name = json['name'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    bio = json['bio'];
    location = json['location'];
    profileImage = json['profile_image'] != null
        ? ProfileImage.fromJson(json['profile_image'])
        : null;
    instagramUsername = json['instagram_username'];

    social = json['social'] != null ? Social.fromJson(json['social']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['username'] = username;
    data['name'] = name;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['bio'] = bio;
    data['location'] = location;
    if (profileImage != null) {
      data['profile_image'] = profileImage!.toJson();
    }
    data['instagram_username'] = instagramUsername;
    if (social != null) {
      data['social'] = social!.toJson();
    }
    return data;
  }
}

@HiveType(typeId: 3)
class ProfileImage {
  @HiveField(0)
  String? small;
  @HiveField(1)
  String? medium;
  @HiveField(2)
  String? large;

  ProfileImage({this.small, this.medium, this.large});

  ProfileImage.fromJson(Map<String, dynamic> json) {
    small = json['small'];
    medium = json['medium'];
    large = json['large'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['small'] = small;
    data['medium'] = medium;
    data['large'] = large;
    return data;
  }
}

@HiveType(typeId: 4)
class Social {
  @HiveField(0)
  String? instagramUsername;
  @HiveField(1)
  String? portfolioUrl;
  @HiveField(2)
  String? twitterUsername;
  @HiveField(3)
  String? paypalEmail;

  Social(
      {this.instagramUsername,
      this.portfolioUrl,
      this.twitterUsername,
      this.paypalEmail});

  Social.fromJson(Map<String, dynamic> json) {
    instagramUsername = json['instagram_username'];
    portfolioUrl = json['portfolio_url'];
    twitterUsername = json['twitter_username'];
    paypalEmail = json['paypal_email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['instagram_username'] = instagramUsername;
    data['portfolio_url'] = portfolioUrl;
    data['twitter_username'] = twitterUsername;
    data['paypal_email'] = paypalEmail;
    return data;
  }
}

List<PhotoModel> get getPhotos {
  final storage = getIt.get<HiveService<List>>();
  final data = (storage.get(
            box: DbKeys.photodb.name,
            collection: DbKeys.photodb.collection,
            defaultValue: [],
          ) ??
          [])
      .cast<PhotoModel>();
  return data;
}
