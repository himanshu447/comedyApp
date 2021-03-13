class AllEventsData {
  bool status;
  String message;
  List<Data> data;

  AllEventsData({this.status, this.message, this.data});

  AllEventsData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int id;
  String image;
  String name;
  String about;
  String startDate;
  String startTime;
  String endDate;
  String endTime;
  String timezone;
  String eventlink;
  int cost;
  String status;
  String createdAt;
  String updatedAt;

  Data(
      {this.id,
        this.image,
        this.name,
        this.about,
        this.startDate,
        this.startTime,
        this.endDate,
        this.endTime,
        this.timezone,
        this.eventlink,
        this.cost,
        this.status,
        this.createdAt,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    name = json['name'];
    about = json['about'];
    startDate = json['start_date'];
    startTime = json['start_time'];
    endDate = json['end_date'];
    endTime = json['end_time'];
    timezone = json['timezone'];
    eventlink = json['eventlink'];
    cost = json['cost'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['name'] = this.name;
    data['about'] = this.about;
    data['start_date'] = this.startDate;
    data['start_time'] = this.startTime;
    data['end_date'] = this.endDate;
    data['end_time'] = this.endTime;
    data['timezone'] = this.timezone;
    data['eventlink'] = this.eventlink;
    data['cost'] = this.cost;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}