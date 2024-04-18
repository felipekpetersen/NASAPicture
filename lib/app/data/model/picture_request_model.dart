class PictureRequestModel {
  String? startDate;

  PictureRequestModel({this.startDate});

  PictureRequestModel.fromJson(Map<String, dynamic> json) {
    startDate = json['start_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['start_date'] = startDate;
    return data;
  }
}
