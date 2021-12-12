import 'package:control_panel/model/login_model.dart';
import 'package:get/get.dart';



class Login_repo extends GetConnect{

  Future <Success> get_user(String username, String pass)async{
    final response = await post('https://cp.translationhubs.com/test/auth/signin',{
      "username":username,
      "password":pass
    });
    if(response.status.hasError){
      return Future.error(response.statusText!);
    }
    return Success.fromJson(response.body['Success']);
  }

}