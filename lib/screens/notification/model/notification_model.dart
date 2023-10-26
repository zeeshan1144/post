class NotificationModel {
  String? name;
  String? date;
  String? title;
  String? message;

  NotificationModel(
      {required this.name,
      required this.date,
      required this.title,
      required this.message});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    this.name = json['name'];
    this.date = json['date'];
    this.title = json['title'];
    this.message = json['message'];
  }
}
