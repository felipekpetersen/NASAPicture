class PictureRequestModel {
  String? startDate;
  String? endDate;

  PictureRequestModel({this.startDate, this.endDate});

  PictureRequestModel.fromJson(Map<String, dynamic> json) {
    startDate = json['start_date'];
    endDate = json['end_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['start_date'] = startDate;
    data['end_date'] = endDate;

    return data;
  }
}
