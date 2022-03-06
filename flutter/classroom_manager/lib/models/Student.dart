class Student {
  int? id;
  String? username;
  String? firstName;
  String? lastName;

  Student({this.id, this.username, this.firstName, this.lastName});

  Student.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    firstName = json['first_name'];
    lastName = json['last_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['username'] = username;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    return data;
  }
}
