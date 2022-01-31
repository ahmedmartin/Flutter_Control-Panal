import 'package:control_panel/controller/login_controller.dart';
import 'package:control_panel/model/profile_info_model.dart';
import 'package:control_panel/repository/user_repo.dart';
import 'package:get/get.dart';




class Profile_info_controller extends GetxController with StateMixin<User_profile_model>{


  String ?token;
  int ?id;

  @override
  void onInit() {
    Login_controller login_controller = Get.find();
    token = login_controller.success.token!;
    id = login_controller.success.userId;

    get_data();

    super.onInit();
  }


  get_data(){
    User_repo().get_user_info(token, id!).
    then((value) => change(value, status: RxStatus.success()));
  }

}