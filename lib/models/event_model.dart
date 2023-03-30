class EventModel {
  final String eventname;
  final String eventDate;
  final String club;
  final String prizes;
  final String description;
  final String posterUrl;
  final String uid;
  final String location;
  final String eventMode;

  EventModel({
    required this.eventname,
    required this.eventDate,
    required this.club,
    required this.prizes,
    required this.description,
    required this.posterUrl,
    required this.uid,
    required this.location,
    required this.eventMode,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      eventname: json['eventname'],
      eventDate: json['eventDate'],
      club: json['club'],
      prizes: json['prizes'],
      description: json['description'],
      posterUrl: json['posterUrl'],
      uid: json['uid'],
      location: json['location'],
      eventMode: json['eventMode'] ?? "null",
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
    };
  }
  // factory EventModel.fromJson(Map<String, dynamic> data) {
  //   eventname = data['eventname'];
  // }
  // Map<String, dynamic> toMap() {
  //   return {
  //     'eventname': eventname,
  //     'eventdate': eventDate,
  //     'club': club,
  //     'prizes': prizes,
  //     'location': location,
  //     'posterUrl': posterUrl,
  //     'description': description,
  //     'uid': uid,
  //   };
  // }
}



// class Address {
//   final String streetName;
//   final String buildingName;
//   final String cityName;

//   Address(
//       {required this.streetName,
//       required this.buildingName,
//       required this.cityName});

//   Map<String, dynamic> toMap() {
//     return {
//       'streetName': streetName,
//       'buildingName': buildingName,
//       'cityName': cityName,
//     };
//   }

//   Address.fromMap(Map<String, dynamic> addressMap)
//       : streetName = addressMap["streetName"],
//         buildingName = addressMap["buildingName"],
//         cityName = addressMap["cityName"];
// }