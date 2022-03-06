import 'Student.dart';

class Task {
  int? id;
  String? title;
  String? content;
  String? createdDate;
  List<Student>? finished;
  List<Student>? unfinished;

  Task(
      {this.id,
      this.title,
      this.content,
      this.createdDate,
      this.finished,
      this.unfinished});

  Task.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    content = json['content'];
    createdDate = json['created_date'];
    if (json['finished'] != null) {
      finished = <Student>[];
      json['finished'].forEach((v) {
        finished!.add(Student.fromJson(v));
      });
    }
    if (json['unfinished'] != null) {
      unfinished = <Student>[];
      json['unfinished'].forEach((v) {
        unfinished!.add(Student.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['content'] = content;
    data['created_date'] = createdDate;
    if (finished != null) {
      data['finished'] = finished!.map((v) => v.toJson()).toList();
    }
    if (unfinished != null) {
      data['unfinished'] = unfinished!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
