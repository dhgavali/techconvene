import 'package:cloud_firestore/cloud_firestore.dart';

class EventModel {
   String eventname;
   String? club;
   String? prizes;
   String description;
   String posterUrl;
   String? uid;
   String location;
   String? eventMode;
   DateTime? startDate;
   DateTime? endDate;
   List<String?>? participants;

  EventModel({
    required this.eventname,
    required this.posterUrl,
    required this.description,
    required this.location,
     this.uid,
    this.eventMode,
     this.club,
     this.prizes,
     this.participants,
     this.startDate,
     this.endDate
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      eventname: json['eventname'],
      club: json['club'],
      prizes: json['prizes'],
      description: json['description'],
      posterUrl: json['posterUrl'],
      uid: json['eventId'],
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
      'club': club,
      'prizes': prizes,
      'description': description,
      'posterUrl': posterUrl,
      'uid': uid,
      'location': location,
      'participants' : participants,
      'startDate': startDate,
      'endDate': endDate,
    };

  }
}