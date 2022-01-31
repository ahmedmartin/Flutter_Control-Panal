import 'package:control_panel/controller/login_controller.dart';
import 'package:control_panel/model/tasks_project_model.dart';
import 'package:control_panel/repository/task_repo.dart';
import 'package:get/get.dart';




class Tasks_project_controller extends GetxController{

  RxBool have_tasks = false.obs;
  List <Tasks_project_model> tasks_list = [];
  Tasks_project_model ?model;
  String ?token;
  int ?id;
  RxString progress_message='Update Task Progress Bar'.obs;
  Login_controller login_controller = Get.find();



  @override
  void onInit() {
    token = login_controller.success.token!;
  }

  get_tasks()async{

    have_tasks.value = false;

    tasks_list= await Task_repo().fetch_tasks_project(token!,id!);

    if(tasks_list.isNotEmpty)
      have_tasks.value=true;
  }

  update_progress(int task_id,int progress) async {

    if(login_controller.success.isLeader!||login_controller.success.isManager!) {
      progress_message.value = (await Task_repo().leader_progress_bar(task_id, progress, token))!;
    }else{
      progress_message.value = (await Task_repo().employee_progress_bar(task_id, progress, token))!;
      if(progress_message.contains('You are not authorized')) {
        progress_message.value = "you don't have a permision";
      }
    }
  }

}