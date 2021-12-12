


import 'package:control_panel/model/task_model.dart';
import 'package:control_panel/repository/depart_repo.dart';
import 'package:control_panel/repository/task_repo.dart';
import 'package:get/get.dart';

class Task_controller extends GetxController with StateMixin<List<task_model>>{

  String token;
  String date;
  RxString department =''.obs;
  RxList <String> dapar_list = [''].obs;
  Task_controller(this.token, this.date);//, this.department);

  @override
  void onInit() async{
    super.onInit();

   dapar_list.value = await Depart_repo().fetch_departments_name(token);

  }

  get_tasks(){

    Task_repo().fetch_tasks(date,department.value,token).then((value) {
      change(value, status: RxStatus.success());
    },onError: (error){
      change(error,status: RxStatus.error(error.toString()));
    });
  }

}