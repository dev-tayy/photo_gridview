// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'photo.model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PhotoModelAdapter extends TypeAdapter<PhotoModel> {
  @override
  final int typeId = 0;

  @override
  PhotoModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PhotoModel(
      id: fields[0] as String?,
      slug: fields[1] as String?,
      createdAt: fields[2] as String?,
      width: fields[3] as int?,
      height: fields[4] as int?,
      color: fields[5] as String?,
      blurHash: fields[6] as String?,
      description: fields[7] as String?,
      altDescription: fields[8] as String?,
      urls: fields[9] as Urls?,
      user: fields[10] as User?,
    );
  }

  @override
  void write(BinaryWriter writer, PhotoModel obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.slug)
      ..writeByte(2)
      ..write(obj.createdAt)
      ..writeByte(3)
      ..write(obj.width)
      ..writeByte(4)
      ..write(obj.height)
      ..writeByte(5)
      ..write(obj.color)
      ..writeByte(6)
      ..write(obj.blurHash)
      ..writeByte(7)
      ..write(obj.description)
      ..writeByte(8)
      ..write(obj.altDescription)
      ..writeByte(9)
      ..write(obj.urls)
      ..writeByte(10)
      ..write(obj.user);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PhotoModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class UrlsAdapter extends TypeAdapter<Urls> {
  @override
  final int typeId = 1;

  @override
  Urls read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Urls(
      raw: fields[0] as String?,
      full: fields[1] as String?,
      regular: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Urls obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.raw)
      ..writeByte(1)
      ..write(obj.full)
      ..writeByte(2)
      ..write(obj.regular);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UrlsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class UserAdapter extends TypeAdapter<User> {
  @override
  final int typeId = 2;

  @override
  User read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return User(
      id: fields[0] as String?,
      username: fields[1] as String?,
      name: fields[2] as String?,
      firstName: fields[3] as String?,
      lastName: fields[4] as String?,
      bio: fields[5] as String?,
      location: fields[6] as String?,
      profileImage: fields[7] as ProfileImage?,
      instagramUsername: fields[8] as String?,
      social: fields[9] as Social?,
    );
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.username)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.firstName)
      ..writeByte(4)
      ..write(obj.lastName)
      ..writeByte(5)
      ..write(obj.bio)
      ..writeByte(6)
      ..write(obj.location)
      ..writeByte(7)
      ..write(obj.profileImage)
      ..writeByte(8)
      ..write(obj.instagramUsername)
      ..writeByte(9)
      ..write(obj.social);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ProfileImageAdapter extends TypeAdapter<ProfileImage> {
  @override
  final int typeId = 3;

  @override
  ProfileImage read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProfileImage(
      small: fields[0] as String?,
      medium: fields[1] as String?,
      large: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ProfileImage obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.small)
      ..writeByte(1)
      ..write(obj.medium)
      ..writeByte(2)
      ..write(obj.large);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProfileImageAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class SocialAdapter extends TypeAdapter<Social> {
  @override
  final int typeId = 4;

  @override
  Social read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Social(
      instagramUsername: fields[0] as String?,
      portfolioUrl: fields[1] as String?,
      twitterUsername: fields[2] as String?,
      paypalEmail: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Social obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.instagramUsername)
      ..writeByte(1)
      ..write(obj.portfolioUrl)
      ..writeByte(2)
      ..write(obj.twitterUsername)
      ..writeByte(3)
      ..write(obj.paypalEmail);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SocialAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
