import 'package:control_panel/model/login_model.dart';
import 'package:control_panel/repository/login_repo.dart';
import 'package:get/get.dart';

class Login_controller extends GetxController with StateMixin<Success>{

  Success success = Success();
  RxBool show_pass = true.obs;


   login (String username, String pass) async{
        bool b = false ;
    await Login_repo().get_user( username,  pass).then((value) {
      success = value;
      change(value, status: RxStatus.success());
      b = true;
     // print(value.token);
    },onError: (error){
      change(success,status: RxStatus.error(error.toString()));
      b = false;
    });
    return await b;
  }

}

