import 'package:control_panel/model/user_model.dart';
import 'package:control_panel/model/profile_info_model.dart';
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

  Future<dynamic> edit_employee_activation(token,int id) async {
    final response = await get('https://cp.translationhubs.com/test/user/toggleStatus/$id',
        headers:{'Authorization':token} );

    return response.body;
  }


  Future<dynamic> update_user(int id,name,user_name,email,bool leader,token) async {

    Map<String,dynamic> body = {
      "name": name,
      "username": user_name,
      "isLeader":leader
    };
    if(email.isNotEmpty)
      body['email'] = email;

    final response = await patch('https://cp.translationhubs.com/test/user/$id',
        body,
        headers:{'Authorization':token} );

    return response.bodyString;
  }

  Future <dynamic>add_user(int rule,name,user_name,email,password,department_id,token) async {

    Map<String,dynamic> body = {
      "username": user_name,
      "name": name,
      "password": password,
      "DepartmentId": department_id,
    };
    if(email.isNotEmpty)
      body['email'] = email;

    body["isManager"]= rule==3;
    body["isLeader"]= rule==2;

    final response = await post('https://cp.translationhubs.com/test/auth/add',
        body
        ,headers:{'Authorization':token} );


    return response.body;
  }

<<<<<<< HEAD

  Future<User_profile_model> get_user_info(token,int id) async {
    final response = await get('https://cp.translationhubs.com/test/user/$id',
        headers:{'Authorization':token} );

    return User_profile_model.fromJson(response.body);
  }

=======
>>>>>>> a7a27adcfb413dc930c835338e02c7bf93e34b23
}