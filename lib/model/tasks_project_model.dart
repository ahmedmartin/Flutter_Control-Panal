class Tasks_project_model {
  int? _id;
  String? _name;
  String? _startDate;
  String? _endDate;
  String? _status;
  int? _progress;
  Department? _department;
  Department? _user;
  bool expanded= false;

  Tasks_project_model(
      {int? id,
        String? name,
        String? startDate,
        String? endDate,
        String? status,
        int? progress,
        Department? department,
        Department? user}) {
    if (id != null) {
      this._id = id;
    }
    if (name != null) {
      this._name = name;
    }
    if (startDate != null) {
      this._startDate = startDate;
    }
    if (endDate != null) {
      this._endDate = endDate;
    }
    if (status != null) {
      this._status = status;
    }
    if (progress != null) {
      this._progress = progress;
    }
    if (department != null) {
      this._department = department;
    }
    if (user != null) {
      this._user = user;
    }
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  String? get name => _name;
  set name(String? name) => _name = name;
  String? get startDate => _startDate;
  set startDate(String? startDate) => _startDate = startDate;
  String? get endDate => _endDate;
  set endDate(String? endDate) => _endDate = endDate;
  String? get status => _status;
  set status(String? status) => _status = status;
  int? get progress => _progress;
  set progress(int? progress) => _progress = progress;
  Department? get department => _department;
  set department(Department? department) => _department = department;
  Department? get user => _user;
  set user(Department? user) => _user = user;

  Tasks_project_model.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _startDate = json['startDate'];
    _endDate = json['endDate'];
    _status = json['status'];
    _progress = json['progress'];
    _department = json['Department'] != null
        ? new Department.fromJson(json['Department'])
        : null;
    _user = json['User'] != null ? new Department.fromJson(json['User']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['name'] = this._name;
    data['startDate'] = this._startDate;
    data['endDate'] = this._endDate;
    data['status'] = this._status;
    data['progress'] = this._progress;
    if (this._department != null) {
      data['Department'] = this._department!.toJson();
    }
    if (this._user != null) {
      data['User'] = this._user!.toJson();
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
