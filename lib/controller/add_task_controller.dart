import 'package:control_panel/controller/login_controller.dart';
import 'package:control_panel/controller/task_controller.dart';
import 'package:control_panel/model/project_model.dart';
import 'package:control_panel/model/user_model.dart';
import 'package:control_panel/repository/project_repo.dart';
import 'package:control_panel/repository/task_repo.dart';
import 'package:control_panel/repository/user_repo.dart';
import 'package:flutter/gestures.dart';
import 'package:get/get.dart';


class Add_task_controller extends GetxController {

  RxList<Project_model> all_projects = [Project_model()].obs;
  RxList<User_model> all_users = [User_model()].obs;

  RxString start_date = ''.obs;
  RxString end_date = ''.obs;
  RxString proj = ''.obs;
  RxString user = ''.obs;
  //RxObjectMixin model = Project_model().obs;


  String ?token;
  int proj_id=0;
  String ?user_id;
  String task_name='';
  String description = '';
  String create_task_message='';
  Project_model ?selected_project_model ;
  User_model ?selected_user_model;
  DateTime S_date = DateTime.now();
  DateTime E_date = DateTime.now();

  @override
  Future<void> onInit() async {

    Login_controller login_controller = Get.find();
    token = login_controller.success.token!;
    user_id = login_controller.success.userId.toString();

    start_date.value = S_date.toString().substring(0, 10);
    end_date.value = E_date.toString().substring(0, 10);

  }



  get_projects()async{
    all_projects.value = await Project_repo().fetch_projects(token);
  }

  get_users()async{
    all_users.value = await User_repo().fetch_users('', token!);
  }

  create_task()async{
   create_task_message= await Task_repo().post_task(task_name, description, proj_id,
       start_date.value, end_date.value, user_id!, token!);
  }

  set_defult(){
    S_date = DateTime.now();
    E_date = DateTime.now();
    start_date.value = S_date.toString().substring(0, 10);
    end_date.value = E_date.toString().substring(0, 10);
    task_name = '';
    description='';
    proj_id = 0;
    user_id = '';
    proj.value='';
    user.value='';
    create_task_message='';
    selected_project_model = null;
    selected_user_model = null;
    all_projects.value = [Project_model()];
    all_users.value = [User_model()];
    Task_controller task_controller = Get.find();
    task_controller.department.value='';
    task_controller.have_tasks.value=false;
  }



}