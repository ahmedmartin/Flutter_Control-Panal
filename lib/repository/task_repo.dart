import 'package:control_panel/model/task_model.dart';
import 'package:get/get.dart';




class Task_repo extends GetConnect {

  Future<List<task_model>> fetch_tasks(String date,  String department, String token) async {
    final response = await post('https://cp.translationhubs.com/test/task/byDepartmentAndDate',{
      "departmentName": "All departments",
      "date": "2021-12-08"
    },headers:{'Authorization':token} );
    if(response.status.hasError){
      print('error');
      return Future.error(response.statusText!);
    }

    List<dynamic> list = response.body;
    List<task_model> tasks = [];
    list.forEach((element) => tasks.add(task_model.fromJson(element)));
    return tasks;
  }

}