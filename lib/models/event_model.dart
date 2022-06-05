import 'package:cloud_firestore/cloud_firestore.dart';

class EventModel {
  final String eventId;
  final String eventName;
  final String location;
  final String host;
  final String description;
  final String startTime;
  final String endTime;
  final DateTime date;

  EventModel({
    required this.eventId,
    required this.eventName,
    required this.location,
    required this.host,
    required this.description,
    required this.startTime,
    required this.endTime,
    required this.date,
  });

  factory EventModel.fromMap(Map data, String documentId) {
    return EventModel(
      eventId: documentId,
      eventName: data["eventName"],
      location: data["location"],
      host: data["host"],
      description: data["description"],
      startTime: data["startTime"],
      endTime: data["endTime"],
      date: data["date"].toDate(),
    );
  }

  Map<String, dynamic> toJson() => {
        "eventName": eventName,
        "location": location,
        "host": host,
        "description": description,
        "startTime": startTime,
        "endTime": endTime,
        "date": date
      };
}
