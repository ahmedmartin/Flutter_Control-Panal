class Dashboard_model {
  List<Project> ?project;
  List<String> ?departs;


  Dashboard_model({this.project,this.departs});

  Dashboard_model.fromJson(Map<String, dynamic> json) {
    json.forEach((key, value) {
      departs!.add(key);
      if (json[key] != null) {
        project = [];
        json[key].forEach((v) {
          project!.add(new Project.fromJson(v));
        });
      }
    });
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //
  //   if (this.project != null) {
  //     data['Project Management '] =
  //         this.project!.map((v) => v.toJson()).toList();
  //   }
  //   return data;
  // }
}

class Project {
  String ?dateTrunc;
  int ?count;

  Project({this.dateTrunc, this.count});

  Project.fromJson(Map<String, dynamic> json) {
    dateTrunc = json['date_trunc'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date_trunc'] = this.dateTrunc;
    data['count'] = this.count;
    return data;
  }
}
