class DogUrl {
  String? message;
  String? status;

  DogUrl({this.message, this.status});

  factory DogUrl.fromJson(Map<String, dynamic> json) {
    return DogUrl(message: json['message'], status: json['status']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['message'] = message;
    data['status'] = status;
    return data;
  }
}
