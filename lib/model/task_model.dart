class task_model {
  int ?id;
  String ?name;
  String? startDate;
  String ?endDate;
  String ?completionDate;
  String ?status;
  int ?progress;
  String ?description;
 // Null deletedAt;
 //  int ?projectId;
 //  int ?departmentId;
 //  int ?userId;
 //  int ?assigneeId;
  User ?user;
  User ?project;
  User ?department;

  task_model(
      {this.id,
        this.name,
        this.startDate,
        this.endDate,
        this.completionDate,
        this.status,
        this.progress,
        this.description,
        // this.projectId,
        // this.departmentId,
        // this.userId,
        // this.assigneeId,
        this.user,
        this.project,
        this.department});

  task_model.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    completionDate = json['completionDate'];
    status = json['status'];
    progress = json['progress'];
    description = json['description'];
    // departmentId = json['DepartmentId'];
    // userId = json['UserId'];
    // assigneeId = json['AssigneeId'];
    user = json['User'] != null ? new User.fromJson(json['User']) : null;
    project =
    json['Project'] != null ? new User.fromJson(json['Project']) : null;
    department = json['Department'] != null
        ? new User.fromJson(json['Department'])
        : null;
  }



  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    data['completionDate'] = this.completionDate;
    data['status'] = this.status;
    data['progress'] = this.progress;
    data['description'] = this.description;
    // data['ProjectId'] = this.projectId;
    // data['DepartmentId'] = this.departmentId;
    // data['UserId'] = this.userId;
    // data['AssigneeId'] = this.assigneeId;
    if (this.user != null) {
      data['User'] = this.user!.toJson();
    }
    if (this.project != null) {
      data['Project'] = this.project!.toJson();
    }
    if (this.department != null) {
      data['Department'] = this.department!.toJson();
    }
    return data;
  }
}



class User {
  String? name;

  User({this.name});

  User.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}
