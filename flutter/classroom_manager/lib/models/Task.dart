import 'package:classroom_manager/models/Student.dart';

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
        finished!.add(new Student.fromJson(v));
      });
    }
    if (json['unfinished'] != null) {
      unfinished = <Student>[];
      json['unfinished'].forEach((v) {
        unfinished!.add(new Student.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['content'] = this.content;
    data['created_date'] = this.createdDate;
    if (this.finished != null) {
      data['finished'] = this.finished!.map((v) => v.toJson()).toList();
    }
    if (this.unfinished != null) {
      data['unfinished'] = this.unfinished!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
