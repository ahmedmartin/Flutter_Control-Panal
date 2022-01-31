class User_profile_model {
  String? _name;
  int? _id;
  String? _username;
  String _email ='N/A';
  bool? _isManager;
  bool? _isLeader;
  Department? _department;

  User_profile_model(
      {String? name,
        int? id,
        String? username,
        // String? email,
        bool? isManager,
        bool? isLeader,
        Department? department}) {
    if (name != null) {
      this._name = name;
    }
    if (id != null) {
      this._id = id;
    }
    if (username != null) {
      this._username = username;
    }
    // if (email != null) {
    //   this._email = email;
    // }
    if (isManager != null) {
      this._isManager = isManager;
    }
    if (isLeader != null) {
      this._isLeader = isLeader;
    }
    if (department != null) {
      this._department = department;
    }
  }

  String? get name => _name;
  set name(String? name) => _name = name;
  int? get id => _id;
  set id(int? id) => _id = id;
  String? get username => _username;
  set username(String? username) => _username = username;
  String get email => _email;
  set email(String email) => _email = email;
  bool? get isManager => _isManager;
  set isManager(bool? isManager) => _isManager = isManager;
  bool? get isLeader => _isLeader;
  set isLeader(bool? isLeader) => _isLeader = isLeader;
  Department? get department => _department;
  set department(Department? department) => _department = department;

  User_profile_model.fromJson(Map<String, dynamic> json) {
    _name = json['name'];
    _id = json['id'];
    _username = json['username'];
    _email = json['email']??'N/A';
    _isManager = json['isManager'];
    _isLeader = json['isLeader'];
    _department = json['Department'] != null
        ? new Department.fromJson(json['Department'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this._name;
    data['id'] = this._id;
    data['username'] = this._username;
    data['email'] = this._email;
    data['isManager'] = this._isManager;
    data['isLeader'] = this._isLeader;
    if (this._department != null) {
      data['Department'] = this._department!.toJson();
    }
    return data;
  }
}

class Department {
  String? _name;

  Department({String? name}) {
    if (name != null) {
      this._name = name;
    }
  }

  String? get name => _name;
  set name(String? name) => _name = name;

  Department.fromJson(Map<String, dynamic> json) {
    _name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this._name;
    return data;
  }
}
