import 'package:control_panel/model/depart_model.dart';
import 'package:control_panel/repository/depart_repo.dart';
import 'package:control_panel/repository/user_repo.dart';
import 'package:get/get.dart';

import 'login_controller.dart';




class Add_user_controller extends GetxController{

  RxInt rule=1.obs;
  RxString department =''.obs;
  RxList <Depart_model> dapar_list = [Depart_model()].obs;

  String ?name;
  String ?user_name;
  String email='';
  String ?pass;
  String ?token;
  String department_id='';
  Depart_model? selected_depart_model;
  String msg='';

  @override
  onInit()  {
    Login_controller login_controller = Get.find();
    token = login_controller.success.token!;
  }

  get_departs() async {
    dapar_list.value = await Depart_repo().fetch_departments_all_details(token!);
  }

  add_user() async {
    msg = await User_repo().add_user(rule.value, name, user_name, email, pass, department_id, token);
  }

  set_defult(){
    rule.value=1;
    department.value ='';
    dapar_list.value = [Depart_model()];
    name='';
    user_name='';
    email='';
    pass='';
    department_id='';
    selected_depart_model=null;
    msg='';
  }

}