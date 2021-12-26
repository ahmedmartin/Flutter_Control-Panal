class Login_model {
  Success ?success;

  Login_model({this.success});

  Login_model.fromJson(Map<String, dynamic> json) {
    success =
    json['Success'] != null ? new Success.fromJson(json['Success']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.success != null) {
      data['Success'] = this.success!.toJson();
    }
    return data;
  }


}

class Success {
  String ?message;
  String ?token;
  int ?userId;
  bool ?isManager;
  bool ?isLeader;
  int ?expiresIn;
  String ?userName;
  int ?userDepartment;

  Success(
      {this.message,
        this.token,
        this.userId,
        this.isManager,
        this.isLeader,
        this.expiresIn,
        this.userName,
        this.userDepartment});

  Success.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    token = json['token'];
    userId = json['userId'];
    isManager = json['isManager'];
    isLeader = json['isLeader'];
    expiresIn = json['expiresIn'];
    userName = json['userName'];
    userDepartment = json['userDepartment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['token'] = this.token;
    data['userId'] = this.userId;
    data['isManager'] = this.isManager;
    data['isLeader'] = this.isLeader;
    data['expiresIn'] = this.expiresIn;
    data['userName'] = this.userName;
    data['userDepartment'] = this.userDepartment;
    return data;
  }
}
