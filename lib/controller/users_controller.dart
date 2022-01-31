import 'package:control_panel/model/user_model.dart';
import 'package:control_panel/repository/user_repo.dart';
import 'package:get/get.dart';
import 'login_controller.dart';



class Users_controller extends GetxController with StateMixin<List<User_model>>{
  RxString msg=''.obs;

  String name='';
  String ?token;
  User_model ?user_model;


  @override
  void onInit() {
    Login_controller login_controller = Get.find();
    token = login_controller.success.token!;

    super.onInit();
  }

  get_data(){
    User_repo().fetch_users(name, token!).
    then((value) => change(value, status: RxStatus.success()));
  }


  update_employee_activation(int id) async {
    msg.value = await User_repo().edit_employee_activation(token!, id);
  }


}