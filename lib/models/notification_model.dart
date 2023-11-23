class NotificationModel {
  String uid;
  String title;
  String description;
  String? tag;

  NotificationModel({
    required this.uid,
    required this.title,
    required this.description,
    this.tag,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      uid: json['uid'],
      title: json['title'],
      description: json['description'],
      tag: json['tag'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'title': title,
      'description': description,
      'tag': tag,
    };
  }
}
