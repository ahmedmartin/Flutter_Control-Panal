import 'package:control_panel/controller/login_controller.dart';
import 'package:control_panel/controller/project_controller.dart';
import 'package:control_panel/model/project_details_model.dart';
import 'package:control_panel/repository/project_repo.dart';
import 'package:get/get.dart';




class Update_project_controller extends GetxController{

  RxString start_date = ''.obs;
  RxString end_date = ''.obs;

  Project_details_model ?model;
  String ?token;
  String project_name='';
  String description = '';
  String update_task_message='';
  DateTime S_date = DateTime.now();
  DateTime E_date = DateTime.now();


  @override
  onInit()  {

    Login_controller login_controller = Get.find();
    token = login_controller.success.token!;




  }

  set_date(){
    Project_controller project_controller = Get.find();
    model = project_controller.model;
    project_name=model!.name!;
    description=model!.description!;
    start_date.value=model!.startDate!;
    end_date.value=model!.endDate!;
    S_date = DateTime.parse(start_date.value);
    E_date = DateTime.parse(end_date.value);
  }


  update_task() async {
    update_task_message = (await Project_repo().update_project(model!.id!, project_name, description,
        start_date.value, end_date.value, token))!;
    if(update_task_message.contains('You are not authorized')) {
      update_task_message = "you don't have a permision";
    }
  }


}