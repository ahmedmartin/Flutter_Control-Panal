class Department_allDetails_model {
  int? id;
  String? name;
  String? createdAt;
  List<Users>? users;
  int? userCount;

  Department_allDetails_model(
      {this.id, this.name, this.createdAt, this.users, this.userCount});

  Department_allDetails_model.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdAt = json['createdAt'];
    if (json['Users'] != null) {
      users = <Users>[];
      json['Users'].forEach((v) {
        users!.add(new Users.fromJson(v));
      });
    }
    userCount = json['UserCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['createdAt'] = this.createdAt;
    if (this.users != null) {
      data['Users'] = this.users!.map((v) => v.toJson()).toList();
    }
    data['UserCount'] = this.userCount;
    return data;
  }
}

class Users {
  String? name;
  bool? isLeader;

  Users({this.name, this.isLeader});

  Users.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    isLeader = json['isLeader'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['isLeader'] = this.isLeader;
    return data;
  }
}
