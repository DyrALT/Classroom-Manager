class Task {
  int? id;
  String? title;
  String? content;
  String? createdDate;
  int? teacher;
  List<int>? finished;
  List<int>? unfinished;

  Task(
      {this.id,
      this.title,
      this.content,
      this.createdDate,
      this.teacher,
      this.finished,
      this.unfinished});

  Task.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    content = json['content'];
    createdDate = json['created_date'];
    teacher = json['teacher'];
    finished = json['finished'].cast<int>();
    unfinished = json['unfinished'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['content'] = this.content;
    data['created_date'] = this.createdDate;
    data['teacher'] = this.teacher;
    data['finished'] = this.finished;
    data['unfinished'] = this.unfinished;
    return data;
  }
}
