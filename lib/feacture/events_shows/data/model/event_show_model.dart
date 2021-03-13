import 'package:equatable/equatable.dart';

class EventShowModel extends Equatable {
  String name;
  String about;
  String startDate;
  String startTime;
  String endDate;
  String endTime;
  String timezone;
  String eventlink;
  String cost;
  String image;
  String updatedAt;
  String createdAt;
  int id;

  EventShowModel({
    this.name,
    this.about,
    this.startDate,
    this.startTime,
    this.endDate,
    this.endTime,
    this.timezone,
    this.eventlink,
    this.cost,
    this.image,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  factory EventShowModel.fromJson(Map<String, dynamic> json) => EventShowModel(
        name: json['name'] == null ? null : json["name"],
        about: json['about'] == null ? null : json["about"],
        startDate: json['startDate'] == null ? null : json["startDate"],
        startTime: json['startTime'] == null ? null : json["startTime"],
        endDate: json['endDate'] == null ? null : json["endDate"],
        endTime: json['endTime'] == null ? null : json["endTime"],
        timezone: json['timezone'] == null ? null : json["timezone"],
        eventlink: json['eventlink'] == null ? null : json["eventlink"],
        cost: json['cost'] == null ? null : json["cost"],
        image: json['image'] == null ? null : json["image"],
        updatedAt: json['updatedAt'] == null ? null : json["updatedAt"],
        createdAt: json['createdAt'] == null ? null : json["createdAt"],
        id: json['id'] == null ? null : json["id"],
      );

  Map<String, dynamic> tojson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['about'] = this.about;
    data['start_date'] = this.startDate;
    data['start_time'] = this.startTime;
    data['end_date'] = this.endDate;
    data['end_time'] = this.endTime;
    data['timezone'] = this.timezone;
    data['eventlink'] = this.eventlink;
    data['cost'] = this.cost;
    data['image'] = this.image;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }

  // Map<String, dynamic> toMap() {
  //   return {};
  // }

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
