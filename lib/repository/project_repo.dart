import 'package:control_panel/model/project_details_model.dart';
import 'package:control_panel/model/project_model.dart';
import 'package:get/get.dart';

class Project_repo extends GetConnect{

//---------get all project details (dep,name,s_date,E_date,........)------------------------
  Future<List<Project_details_model>> fetch_projects_all_details(token,department_id) async {
    final response = await get('https://cp.translationhubs.com/test/project/byDepartment/$department_id',
        headers:{'Authorization':token} );
    if(response.status.hasError){
      return Future.error(response.statusText!);
    }

    List<dynamic> list = response.body;
    List<Project_details_model> projects = [];
    list.forEach((element) => projects.add(Project_details_model.fromJson(element)));
    return projects;
  }

//----------- get only project id & name -----------------------
  Future<List<Project_model>> fetch_projects(token) async {
    final response = await get('https://cp.translationhubs.com/test/project/allNames',
        headers:{'Authorization':token} );
    if(response.status.hasError){
      return Future.error(response.statusText!);
    }

    List<dynamic> list = response.body;
    List<Project_model> projects = [];
    list.forEach((element) => projects.add(Project_model.fromJson(element)));
    return projects;
  }


  Future <dynamic>post_project(proj_name,description,start_date,end_date,String depart_id,token) async {

    if(depart_id.isEmpty){
      return 'Should Choose Department';
    }
    final response = await post('https://cp.translationhubs.com/test/project',{
      "name": proj_name,
      "startDate": start_date,
      "endDate": end_date,
      "description": description,
      "DepartmentId": depart_id
    },headers:{'Authorization':token} );


    return response.body;
  }

  Future<String?> update_project(int proj_id,proj_name,description,start_date,end_date,token) async {
    final response = await patch('https://cp.translationhubs.com/test/project',{
        "projectId": proj_id,
        "name": proj_name,
        "description": description,
        "startDate":start_date,
        "endDate":end_date
    },headers:{'Authorization':token} );

    return response.bodyString;
  }

}