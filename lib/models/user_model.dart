class UserModel {
  String uid;
  String name;
  String emailId;
  String mobileNo;
  String? bio;
  String? totalEventsParticipated;
  List<String?>? eventParticipated;

  UserModel({required this.uid, required this.name, required this.emailId, required this.mobileNo, this.bio, this.totalEventsParticipated, this.eventParticipated});


factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'], 
     name: json['name'],
     emailId: json['email'],
     mobileNo: json['mobile'],
     bio: json['bio'],
     totalEventsParticipated: json['totalEventsParticipated'],
    eventParticipated:(json['eventParticipated'] as List<dynamic>?)?.cast<String?>(),
     );
  }

  
  Map<String, dynamic> toJson() {
  return {
    'uid': uid,
    'name': name,
    'email': emailId,
    'mobile': mobileNo,
    'bio': bio,
    'totalEventsParticipated': totalEventsParticipated,
    'eventParticipated': eventParticipated,
  };
}
}
