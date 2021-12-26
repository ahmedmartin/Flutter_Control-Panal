class Project_details_model {
  int ?id;
  String ?name;
  String ?description;
  String ?startDate;
  String ?endDate;
  String ?completionDate;
  String ?progress;
  // Null initiation;
  // Null plan;
  // Null execution;
  // Null closure;
  // String ?createdAt;
  // Null deletedAt;
  int ?departmentId;
  int ?userId;
  Department ?department;

  Project_details_model(
      {this.id,
        this.name,
        this.description,
        this.startDate,
        this.endDate,
        this.completionDate,
        this.progress,
        // this.initiation,
        // this.plan,
        // this.execution,
        // this.closure,
        // this.createdAt,
        // this.deletedAt,
        this.departmentId,
        this.userId,
        this.department});

  Project_details_model.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    completionDate = json['completionDate'];
    progress = json['progress'];
    // initiation = json['initiation'];
    // plan = json['plan'];
    // execution = json['execution'];
    // closure = json['closure'];
    // createdAt = json['createdAt'];
    // deletedAt = json['deletedAt'];
    departmentId = json['DepartmentId'];
    userId = json['UserId'];
    department = json['Department'] != null
        ? new Department.fromJson(json['Department'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    data['completionDate'] = this.completionDate;
    data['progress'] = this.progress;
    // data['initiation'] = this.initiation;
    // data['plan'] = this.plan;
    // data['execution'] = this.execution;
    // data['closure'] = this.closure;
    // data['createdAt'] = this.createdAt;
    // data['deletedAt'] = this.deletedAt;
    data['DepartmentId'] = this.departmentId;
    data['UserId'] = this.userId;
    if (this.department != null) {
      data['Department'] = this.department!.toJson();
    }
    return data;
  }
}

class Department {
  String ?name;

  Department({this.name});

  Department.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}
