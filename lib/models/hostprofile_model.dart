class HostProfileModel {
  String name;
  String position;
  String city;
  String email;
  String mobile;
  String? club;
  String pincode;
  List<String>? eventLists;

  HostProfileModel({
    required this.name,
    required this.position,
    required this.city,
    required this.email,
    required this.mobile,
    required this.pincode,
    this.club,
    this.eventLists,
  });

  // Factory method to create an instance of HostProfileModel from a JSON map
  factory HostProfileModel.fromJson(Map<String, dynamic> json) {
    return HostProfileModel(
      name: json['fullname'] as String,
      position: json['position'] as String,
      city: json['city'] as String,
      email: json['email'] as String,
      mobile: json['mobile'] as String,
      club: json['club'] as String?,
      pincode: json['pincode'] as String,
      eventLists: (json['eventLists'] as List<dynamic>?)?.cast<String>(),
    );
  }

  // Method to convert HostProfileModel instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'position': position,
      'city': city,
      'email': email,
      'mobile': mobile,
      'club': club,
      'pincode': pincode,
      'eventLists': eventLists,
    };
  }
}
