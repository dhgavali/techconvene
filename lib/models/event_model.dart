import 'package:cloud_firestore/cloud_firestore.dart';

class EventModel {
   String eventname;
   String? prizes;
   String description;
   String posterUrl;
   bool isClosed;
   String? uid;
   String location;
   String? eventMode;
   DateTime? startDate;
   DateTime? endDate;
   List<String?>? participants;
   String? hostid;
   

  EventModel({
    required this.eventname,
    required this.posterUrl,
    required this.description,
    required this.location,
    required this.isClosed,
     this.uid,
     this.hostid,
    this.eventMode,
     this.prizes,
     this.participants,
     this.startDate,
     this.endDate
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      eventname: json['eventname'],
      prizes: json['prizes'],
      description: json['description'],
      posterUrl: json['posterUrl'],
      uid: json['uid'],
      hostid: json['hostId'],
      isClosed: json['isClosed'] ?? false,
      location: json['location'],
      eventMode: json['eventMode'] ?? "null",
     startDate: (json['startDate'] as Timestamp).toDate(),
    endDate: (json['endDate'] as Timestamp).toDate(),
      participants: (json['participants'] as List<dynamic>?)?.cast<String?>(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'eventname': eventname,
      'prizes': prizes,
      'description': description,
      'posterUrl': posterUrl,
      'uid': uid,
      'hostId' : hostid,
      'isClosed' : isClosed,
      'location': location ?? "Online",
      'participants' : participants ?? [],
      'startDate': startDate,
      'endDate': endDate,
    };

  }
}