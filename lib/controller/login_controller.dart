import 'package:control_panel/model/login_model.dart';
import 'package:control_panel/repository/login_repo.dart';
import 'package:get/get.dart';

class Login_controller extends GetxController {

  Success success = Success();
  RxBool wait = false.obs;
  RxBool show_pass = true.obs;


   login (String username, String pass) async{

     wait.value= true;
     success = await Login_repo().get_user( username,  pass);
     wait.value=false;
     if(success.message!.contains('successfully'))
        return true;
     else
      return false;
  }

}

