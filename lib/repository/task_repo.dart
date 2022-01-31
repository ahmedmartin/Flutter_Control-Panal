import 'package:control_panel/model/dashbord_model.dart';
import 'package:control_panel/model/task_model.dart';
import 'package:control_panel/model/tasks_project_model.dart';
import 'package:get/get.dart';




class Task_repo extends GetConnect {

  Future<List<task_model>> fetch_tasks(String date,  String department, String token) async {
    final response = await post('https://cp.translationhubs.com/test/task/byDepartmentAndDate',{
      "departmentName": department,
      "date": date
    },headers:{'Authorization':token} );
    if(response.status.hasError){
      return Future.error(response.statusText!);
    }

    List<dynamic> list = response.body;
    List<task_model> tasks = [];
    list.forEach((element) => tasks.add(task_model.fromJson(element)));
    return tasks;
  }

  Future<List<Tasks_project_model>> fetch_tasks_project(String token,int id) async {
    final response = await get('https://cp.translationhubs.com/test/task/byProject/$id',
        headers:{'Authorization':token} );
    if(response.status.hasError){
      return Future.error(response.statusText!);
    }

    List<dynamic> list = response.body;
    List<Tasks_project_model> tasks = [];
    list.forEach((element) => tasks.add(Tasks_project_model.fromJson(element)));
    return tasks;
  }

  Future <dynamic>post_task(task_name,description,int proj_id,start_date,end_date,String user_id,token) async {
    final response = await post('https://cp.translationhubs.com/test/task',{
      "name": task_name,
      "startDate": start_date,
      "endDate": end_date,
      "description": description,
      "UserId":user_id,
      "ProjectId":proj_id
    },headers:{'Authorization':token} );


    return response.body;
  }

  Future<String?> employee_progress_bar(int task_id,int progress,token) async {
    final response = await patch('https://cp.translationhubs.com/test/task/progress',{
      "taskId":task_id,
      "progress": progress
    },headers:{'Authorization':token} );
    print(response.statusCode.toString());
    print(response.bodyString);
    return response.bodyString;
  }

  Future<String?> leader_progress_bar(int task_id,int progress,token) async {
    final response = await patch('https://cp.translationhubs.com/test/task/reviewProgress',{
      "taskId":task_id,
      "progress": progress
    },headers:{'Authorization':token} );

    return response.bodyString;
  }

  Future<String?> update_task(int task_id,task_name,description,start_date,end_date,token) async {
    final response = await patch('https://cp.translationhubs.com/test/task',{
      "taskId": task_id,
      "name": task_name,
      "description": description,
      "startDate":start_date ,
      "endDate": end_date
    },headers:{'Authorization':token} );

    return response.bodyString;
  }

  Future <Map<String, dynamic>> dashboard (start_date,end_date,period,token) async {
    if(period=='monthly') {
      period = 'weekly';
    }

    final response = await post('https://cp.translationhubs.com/api/task/dashboardStats',{
      "startDate": start_date,
      "endDate": end_date,
      "period":  period
    },headers:{'Authorization':token} );

    print(response.body);
    return response.body;
  }

}