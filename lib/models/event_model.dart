class EventModel {
   String eventname;
   String eventDate;
   String? club;
   String? prizes;
   String description;
   String posterUrl;
   String uid;
   String location;
   String? eventMode;
   List<String?>? participants;

  EventModel({
    required this.eventname,
    required this.eventDate,
    required this.posterUrl,
    required this.description,
    required this.uid,
    required this.location,
    this.eventMode,
     this.club,
     this.prizes,
     this.participants,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      eventname: json['eventname'],
      eventDate: json['eventDate'],
      club: json['club'],
      prizes: json['prizes'],
      description: json['description'],
      posterUrl: json['posterUrl'],
      uid: json['eventId'],
      location: json['location'],
      eventMode: json['eventMode'] ?? "null",
      participants: (json['participants'] as List<dynamic>?)?.cast<String?>(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'eventname': eventname,
      'eventDate': eventDate,
      'club': club,
      'prizes': prizes,
      'description': description,
      'posterUrl': posterUrl,
      'uid': uid,
      'location': location,
      'participants' : participants
    };

  }
}