import 'dart:convert';

import 'package:lettutor/api/base.api.dart';
import 'package:lettutor/model/schedule_model.dart';

class ScheduleResponse {
  String? message;
  List<ScheduleOfTutor>? scheduleOfTutor;

  ScheduleResponse({this.message, this.scheduleOfTutor});

  ScheduleResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['scheduleOfTutor'] != null) {
      scheduleOfTutor = <ScheduleOfTutor>[];
      json['scheduleOfTutor'].forEach((v) {
        scheduleOfTutor!.add(new ScheduleOfTutor.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.scheduleOfTutor != null) {
      data['scheduleOfTutor'] =
          this.scheduleOfTutor!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ScheduleOfTutor {
  String? id;
  String? tutorId;
  String? startTime;
  String? endTime;
  int? startTimestamp;
  int? endTimestamp;
  String? createdAt;
  bool? isBooked;
  List<ScheduleDetails>? scheduleDetails;

  ScheduleOfTutor(
      {this.id,
      this.tutorId,
      this.startTime,
      this.endTime,
      this.startTimestamp,
      this.endTimestamp,
      this.createdAt,
      this.isBooked,
      this.scheduleDetails});

  ScheduleOfTutor.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tutorId = json['tutorId'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    startTimestamp = json['startTimestamp'];
    endTimestamp = json['endTimestamp'];
    createdAt = json['createdAt'];
    isBooked = json['isBooked'];
    if (json['scheduleDetails'] != null) {
      scheduleDetails = <ScheduleDetails>[];
      json['scheduleDetails'].forEach((v) {
        scheduleDetails!.add(new ScheduleDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['tutorId'] = this.tutorId;
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    data['startTimestamp'] = this.startTimestamp;
    data['endTimestamp'] = this.endTimestamp;
    data['createdAt'] = this.createdAt;
    data['isBooked'] = this.isBooked;
    if (this.scheduleDetails != null) {
      data['scheduleDetails'] =
          this.scheduleDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ScheduleDetails {
  int? startPeriodTimestamp;
  int? endPeriodTimestamp;
  String? id;
  String? scheduleId;
  String? startPeriod;
  String? endPeriod;
  String? createdAt;
  String? updatedAt;
  List<BookingInfo>? bookingInfo;
  bool? isBooked;

  ScheduleDetails(
      {this.startPeriodTimestamp,
      this.endPeriodTimestamp,
      this.id,
      this.scheduleId,
      this.startPeriod,
      this.endPeriod,
      this.createdAt,
      this.updatedAt,
      this.bookingInfo,
      this.isBooked});

  ScheduleDetails.fromJson(Map<String, dynamic> json) {
    startPeriodTimestamp = json['startPeriodTimestamp'];
    endPeriodTimestamp = json['endPeriodTimestamp'];
    id = json['id'];
    scheduleId = json['scheduleId'];
    startPeriod = json['startPeriod'];
    endPeriod = json['endPeriod'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    if (json['bookingInfo'] != null) {
      bookingInfo = <BookingInfo>[];
      json['bookingInfo'].forEach((v) {
        bookingInfo!.add(new BookingInfo.fromJson(v));
      });
    }
    isBooked = json['isBooked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['startPeriodTimestamp'] = this.startPeriodTimestamp;
    data['endPeriodTimestamp'] = this.endPeriodTimestamp;
    data['id'] = this.id;
    data['scheduleId'] = this.scheduleId;
    data['startPeriod'] = this.startPeriod;
    data['endPeriod'] = this.endPeriod;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.bookingInfo != null) {
      data['bookingInfo'] = this.bookingInfo!.map((v) => v.toJson()).toList();
    }
    data['isBooked'] = this.isBooked;
    return data;
  }
}

class BookingInfo {
  int? createdAtTimeStamp;
  int? updatedAtTimeStamp;
  String? id;
  bool? isDeleted;
  String? createdAt;
  String? scheduleDetailId;
  String? updatedAt;
  int? cancelReasonId;
  String? userId;

  BookingInfo(
      {this.createdAtTimeStamp,
      this.updatedAtTimeStamp,
      this.id,
      this.isDeleted,
      this.createdAt,
      this.scheduleDetailId,
      this.updatedAt,
      this.cancelReasonId,
      this.userId});

  BookingInfo.fromJson(Map<String, dynamic> json) {
    createdAtTimeStamp = json['createdAtTimeStamp'];
    updatedAtTimeStamp = json['updatedAtTimeStamp'];
    id = json['id'];
    isDeleted = json['isDeleted'];
    createdAt = json['createdAt'];
    scheduleDetailId = json['scheduleDetailId'];
    updatedAt = json['updatedAt'];
    cancelReasonId = json['cancelReasonId'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createdAtTimeStamp'] = this.createdAtTimeStamp;
    data['updatedAtTimeStamp'] = this.updatedAtTimeStamp;
    data['id'] = this.id;
    data['isDeleted'] = this.isDeleted;
    data['createdAt'] = this.createdAt;
    data['scheduleDetailId'] = this.scheduleDetailId;
    data['updatedAt'] = this.updatedAt;
    data['cancelReasonId'] = this.cancelReasonId;
    data['userId'] = this.userId;
    return data;
  }
}

class StudentScheduleResponse {
  String? message;
  Data? data;

  StudentScheduleResponse({this.message, this.data});

  StudentScheduleResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? count;
  List<Schedule>? rows;

  Data({this.count, this.rows});

  Data.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['rows'] != null) {
      rows = <Schedule>[];
      json['rows'].forEach((v) {
        rows!.add(new Schedule.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    if (this.rows != null) {
      data['rows'] = this.rows!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NextScheduleResponse {
  String? message;
  List<Schedule>? data;

  NextScheduleResponse({this.message, this.data});

  NextScheduleResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <Schedule>[];
      json['data'].forEach((v) {
        data!.add(new Schedule.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> dataa = new Map<String, dynamic>();
    dataa['message'] = this.message;
    if (this.data != null) {
      dataa['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return dataa;
  }
}

class ScheduleApi {
  static String URL = 'schedule/';

  static Future<ScheduleResponse> getTutorSchedule(
      {required String tutorId,
      required BigInt startTimestamp,
      required BigInt endTimestamp}) async {
    String url =
        '$URL?tutorId=$tutorId&startTimestamp=$startTimestamp&endTimestamp=$endTimestamp';
    try {
      var res = await BaseApi.get(url);
      if (res.statusCode == 200) {
        return ScheduleResponse.fromJson(json.decode(res.body));
      } else {
        return throw Exception('Failed to load Schedule');
      }
    } catch (e) {
      return throw Exception('Failed to load Schedule');
    }
  }

  static Future<StudentScheduleResponse> getStudentSchedule(
      {page, timestamp, isHistory}) async {
    String url =
        'booking/list/student?page=$page&perPage=10&${isHistory ? 'dateTimeLte=$timestamp' : 'dateTimeGte=$timestamp'}&orderBy=meeting&sortBy=desc';
    try {
      var res = await BaseApi.get(url);
      if (res.statusCode == 200) {
        try {
          StudentScheduleResponse response =
              StudentScheduleResponse.fromJson(json.decode(res.body));
          return response;
        } catch (err) {
          return throw Exception('Failed to load Schedule');
        }
      } else {
        return throw Exception('Failed to load Schedule');
      }
    } catch (err) {
      return throw Exception('Failed to load Schedule');
    }
  }

  static Future<NextScheduleResponse> getNextSchedule() async {
    DateTime now = DateTime.now();
    String url = 'booking/next?dateTime=${now.millisecondsSinceEpoch}';
    try {
      var res = await BaseApi.get(url);
      if (res.statusCode == 200) {
        try {
          NextScheduleResponse response =
              NextScheduleResponse.fromJson(json.decode(res.body));
          return response;
        } catch (err) {
          print(err);
          return throw Exception('Failed to load Schedule');
        }
      } else {
        return throw Exception('Failed to load Schedule');
      }
    } catch (err) {
      print(err);
      return throw Exception('Failed to load Schedule');
    }
  }

  static Future<int> getTotalHours() async {
    String url = 'call/total';
    try {
      var res = await BaseApi.get(url);
      if (res.statusCode == 200) {
        try {
          return json.decode(res.body)['total'];
        } catch (err) {
          print(err);
          return throw Exception('Failed to load Schedule');
        }
      } else {
        return throw Exception('Failed to load Schedule');
      }
    } catch (err) {
      print(err);
      return throw Exception('Failed to load Schedule');
    }
  }

  static Future<dynamic> bookingSchedule(
      String scheduleDetailId, String note) async {
    String url = 'booking';
    try {
      var res = await BaseApi.post(url, {
        'scheduleDetailIds': [scheduleDetailId],
        'note': note
      });
      if (res.statusCode == 200) {
        return json.decode(res.body);
      } else {
        return throw json.decode(res.body)['message'];
      }
    } catch (err) {
      print(err);
      return throw Exception(err);
    }
  }

  static Future<dynamic> cancelSchedule(
      int cancelReasonId, String note, String scheduleDetailId) async {
    try {
      var res = await BaseApi.delete('booking/schedule-detail', {
        'cancelInfo': {'cancelReasonId': cancelReasonId, 'note': note},
        'scheduleDetailId': scheduleDetailId
      });
      if (res.statusCode == 200) {
        return json.decode(res.body);
      } else {
        return throw Exception('Failed to cancel Schedule');
      }
    } catch (err) {
      print(err);
      return throw Exception('Failed to cancel Schedule');
    }
  }
}
