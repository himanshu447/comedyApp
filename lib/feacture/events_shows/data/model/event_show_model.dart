import 'package:comedy/utils/helper/timer_helper.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

class EventShowModel extends Equatable {
  final String name;
  final String about;
  final DateTime startDate;
  final DateTime endDate;
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
    this.endDate,
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

  factory EventShowModel.fromMap(Map<String, dynamic> json){

    DateTime startLocalDate;
    DateTime endLocalDate;

    var dateFormat = DateFormat("dd-MM-yyyy hh:mm aa");

    if(json['start_date'] != null){
      var utcDate = dateFormat.format(DateTime.parse(json["start_date"]));
       startLocalDate = dateFormat.parse(utcDate, true).toLocal();
    }

    if(json['end_date'] != null){
      var utcDate = dateFormat.format(DateTime.parse(json["end_date"]));
       endLocalDate = dateFormat.parse(utcDate, true).toLocal();
    }


    print('DATA================================>${startLocalDate}');
    print('DATA================================>${endLocalDate}');


    return EventShowModel(
      name: json['name'] == null ? null : json["name"],
      about: json['about'] == null ? null : json["about"],
      startDate: startLocalDate,
      endDate: endLocalDate,
      timezone: json['timezone'] == null ? null : json["timezone"],
      eventLink: json['eventlink'] == null ? null : json["eventlink"],
      cost: json['cost'] == null ? null : json["cost"],
      image: json['image'] == null ? null : json["image"],
      updatedAt: json['updatedAt'] == null ? null : DateTime.parse(json["updatedAt"]),
      createdAt: json['created_at'] == null ? null : DateTime.parse(json["created_at"]),
      id: json['id'] == null ? null : json["id"],
    );
  }

  Map<String, dynamic> toMap({bool strict = false,}) {

    Map<String, dynamic> map = {
      'name': name != null ? name : null,
      'about': about != null ? about : null,
      'start_date': startDate != null ? startDate.toString() : null,
      'end_date': endDate!= null ? endDate.toString() : null,
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
      eventLink: eventLink ?? this.eventLink,
      id: id ?? this.id,
      image: image ?? this.image,
      startDate: startDate ?? this.startDate,
      timezone: timezone ?? this.timezone,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
