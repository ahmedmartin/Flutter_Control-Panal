import 'package:control_panel/controller/login_controller.dart';
import 'package:control_panel/model/task_model.dart';
import 'package:control_panel/repository/depart_repo.dart';
import 'package:control_panel/repository/task_repo.dart';
import 'package:get/get.dart';




class Task_controller extends GetxController {

  String ?token;
  RxString date=''.obs;
  RxString department =''.obs;
  RxList <String> dapar_list = [''].obs;
  //RxList <task_model> tasks_list = [task_model()].obs;
  List <task_model> tasks_list = [];
  RxBool have_tasks = false.obs;
  RxString progress_message='Update Task Progress Bar'.obs;
  task_model ?model;

  Login_controller login_controller = Get.find();

  @override
  void onInit() async{
    super.onInit();


    token = login_controller.success.token!;


    dapar_list.value = await Depart_repo().fetch_departments_name(token!);

    if(login_controller.success.isManager!) {
      dapar_list.insert(0, 'All departments');
    }


  }



  get_tasks()async{

    have_tasks.value = false;

    tasks_list= await Task_repo().fetch_tasks(date.value,department.value,token!);

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