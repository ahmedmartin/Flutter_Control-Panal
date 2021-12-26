class User_model {
  String ?name;
  int ?id;
  String ?username;
  String ?status;
  bool ?isLeader;
  String ?email;
  Department ?department;

  User_model(
      {this.name,
        this.id,
        this.username,
        this.status,
        this.isLeader,
        this.email,
        this.department});

  User_model.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    username = json['username'];
    status = json['status'];
    isLeader = json['isLeader'];
    email = json['email'];
    department = json['Department'] != null
        ? new Department.fromJson(json['Department'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;
    data['username'] = this.username;
    data['status'] = this.status;
    data['isLeader'] = this.isLeader;
    data['email'] = this.email;
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
