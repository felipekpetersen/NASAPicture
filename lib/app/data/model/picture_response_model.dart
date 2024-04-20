
import 'package:hive/hive.dart';
part 'picture_response_model.g.dart';

@HiveType(typeId: 0)
class PictureResponseModel {

  @HiveField(0)
  String? copyright;
  @HiveField(1)
  String? date;
  @HiveField(2)
  String? explanation;
  @HiveField(3)
  String? hdurl;
  @HiveField(4)
  String? mediaType;
  @HiveField(5)
  String? serviceVersion;
  @HiveField(6)
  String? title;
  @HiveField(7)
  String? url;

  PictureResponseModel(
      {this.copyright,
        this.date,
        this.explanation,
        this.hdurl,
        this.mediaType,
        this.serviceVersion,
        this.title,
        this.url});

  PictureResponseModel.fromJson(Map<String, dynamic> json) {
    copyright = json['copyright'];
    date = json['date'];
    explanation = json['explanation'];
    hdurl = json['hdurl'];
    mediaType = json['media_type'];
    serviceVersion = json['service_version'];
    title = json['title'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['copyright'] = copyright;
    data['date'] = date;
    data['explanation'] = explanation;
    data['hdurl'] = hdurl;
    data['media_type'] = mediaType;
    data['service_version'] = serviceVersion;
    data['title'] = title;
    data['url'] = url;
    return data;
  }
}
