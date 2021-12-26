import 'package:control_panel/model/user_model.dart';
import 'package:get/get.dart';




class User_repo extends GetConnect{

  Future<List<User_model>> fetch_users(String name, String token) async {
    final response = await post('https://cp.translationhubs.com/test/user/allDetails',{
      "searchParam": name
    },headers:{'Authorization':token} );
    if(response.status.hasError){
      return Future.error(response.statusText!);
    }

    List<dynamic> list = response.body;
    List<User_model> users = [];
    list.forEach((element) => users.add(User_model.fromJson(element)));
    return users;
  }

}