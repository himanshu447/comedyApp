import 'package:equatable/equatable.dart';

class EventShowModel extends Equatable {
  final String name;
  final String about;
  final DateTime startDate;
  final String startTime;
  final DateTime endDate;
  final String endTime;
  final String timezone;
  final String eventLink;
  final dynamic cost;
  final String image;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int id;

  EventShowModel({
    this.name,
    this.about,
    this.startDate,
    this.startTime,
    this.endDate,
    this.endTime,
    this.timezone,
    this.eventLink,
    this.cost,
    this.image,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  @override
  List<Object> get props => [name, about, startDate];

  factory EventShowModel.fromMap(Map<String, dynamic> json) => EventShowModel(
    name: json['name'] == null ? null : json["name"],
    about: json['about'] == null ? null : json["about"],
    startDate: json['start_date'] == null ? null : DateTime.parse(json["start_date"]).toLocal(),
    startTime: json['start_time'] == null ? null : json["start_time"],
    endDate: json['end_date'] == null ? null : DateTime.parse(json["end_date"]).toLocal(),
    endTime: json['end_time'] == null ? null : json["end_time"],
    timezone: json['timezone'] == null ? null : json["timezone"],
    eventLink: json['eventlink'] == null ? null : json["eventlink"],
    cost: json['cost'] == null ? null : json["cost"],
    image: json['image'] == null ? null : json["image"],
    updatedAt: json['updatedAt'] == null ? null : DateTime.parse(json["updatedAt"]),
    createdAt: json['created_at'] == null ? null : DateTime.parse(json["created_at"]),
    id: json['id'] == null ? null : json["id"],
  );

  Map<String, dynamic> toMap({bool strict = false,}) {

    Map<String, dynamic> map = {
      'name': name != null ? name : null,
      'about': about != null ? about : null,
      'start_date': startDate != null ? startDate.toString() : null,
      'start_time': startTime != null ? startTime : null,
      'end_date': endDate!= null ? endDate.toString() : null,
      'end_time': endTime != null ? endTime : null,
      'timezone': timezone != null ? timezone : null,
      'eventlink': eventLink != null ? eventLink : null,
      'cost':  cost != null ? cost : null,
      'timezone' : 'GTM +3',
    };

    if (strict) {
      Map<String, dynamic> newMap = {};

      for (String el in map.keys) {
        if (map[el] != null) {
          newMap[el] = map[el];
        }
      }
      map = newMap;
    }
    return map;
  }

  EventShowModel copyWith({
    String name,
    String about,
    DateTime startDate,
    String startTime,
    DateTime endDate,
    String endTime,
    String timezone,
    String eventLink,
    int cost,
    String image,
    DateTime createdAt,
    DateTime updatedAt,
    int id,
  }) {
    return EventShowModel(
      name: name ?? this.name,
      about: about ?? this.about,
      cost: cost ?? this.cost,
      createdAt: createdAt ?? this.createdAt,
      endDate: endDate ?? this.endDate,
      endTime: endTime ?? this.endTime,
      eventLink: eventLink ?? this.eventLink,
      id: id ?? this.id,
      image: image ?? this.image,
      startDate: startDate ?? this.startDate,
      startTime: startTime ?? this.startTime,
      timezone: timezone ?? this.timezone,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
