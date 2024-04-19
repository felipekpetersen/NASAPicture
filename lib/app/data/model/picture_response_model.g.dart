// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'picture_response_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PictureResponseModelAdapter extends TypeAdapter<PictureResponseModel> {
  @override
  final int typeId = 0;

  @override
  PictureResponseModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PictureResponseModel(
      copyright: fields[0] as String?,
      date: fields[1] as String?,
      explanation: fields[2] as String?,
      hdurl: fields[3] as String?,
      mediaType: fields[4] as String?,
      serviceVersion: fields[5] as String?,
      title: fields[6] as String?,
      url: fields[7] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, PictureResponseModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.copyright)
      ..writeByte(1)
      ..write(obj.date)
      ..writeByte(2)
      ..write(obj.explanation)
      ..writeByte(3)
      ..write(obj.hdurl)
      ..writeByte(4)
      ..write(obj.mediaType)
      ..writeByte(5)
      ..write(obj.serviceVersion)
      ..writeByte(6)
      ..write(obj.title)
      ..writeByte(7)
      ..write(obj.url);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PictureResponseModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
