import 'package:control_panel/controller/login_controller.dart';
import 'package:control_panel/controller/users_controller.dart';
import 'package:control_panel/repository/user_repo.dart';
import 'package:get/get.dart';



class Update_user_controller extends GetxController{

  RxBool leader=false.obs;

  String ?name;
  String ?user_name;
  String ?email;
  // String ?pass;
  String ?token;
  int ?id;
  String msg='';



  @override
  onInit()  {
    Login_controller login_controller = Get.find();
    token = login_controller.success.token!;
  }


  set_data(){
    Users_controller controller = Get.find();
    name = controller.user_model!.name;
    user_name=controller.user_model!.username;
    if(controller.user_model!.email !=null)
       email=controller.user_model!.email;
    leader.value=controller.user_model!.isLeader!;
    id = controller.user_model!.id;
  }

  update_user() async {
    msg = await User_repo().update_user(id!, name, user_name, email, leader.value, token);
  }

}