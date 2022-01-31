import 'package:control_panel/controller/login_controller.dart';
import 'package:control_panel/model/depart_allDetails_model.dart';
import 'package:control_panel/repository/depart_repo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



class Department_controller extends GetxController with StateMixin<List<Department_allDetails_model>>{

  RxString msg=''.obs;

  String ?token;

  
@override
  void onInit() {
  Login_controller login_controller = Get.find();
  token = login_controller.success.token!;
  
  
    super.onInit();
  }

  get_data(){
    Depart_repo().fetch_departments_statistics(token!).
    then((value) => change(value, status: RxStatus.success()));
  }

  add_department(String name) async {
    msg.value = await Depart_repo().post_department(name, token!);
  }

  delete_department(int id)async{
    msg.value = await Depart_repo().delete_department(id, token!);
  }

}