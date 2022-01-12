import 'package:control_panel/model/depart_allDetails_model.dart';
import 'package:control_panel/model/depart_model.dart';
import 'package:get/get.dart';

class Depart_repo extends GetConnect {

  Future<List<String>> fetch_departments_name(String token) async {
    final response = await get('https://cp.translationhubs.com/test/department/all',
        headers:{'Authorization':token} );
    if(response.status.hasError){
      return Future.error(response.statusText!);
    }

    List<dynamic> list = response.body;
    List<String> departs = [];
    list.forEach((element) => departs.add(Depart_model.fromJson(element).name!));
    return departs;
  }


  Future<List<Depart_model>> fetch_departments_all_details(String token) async {
    final response = await get('https://cp.translationhubs.com/test/department/all',
        headers:{'Authorization':token} );
    if(response.status.hasError){
      return Future.error(response.statusText!);
    }

    List<dynamic> list = response.body;
    List<Depart_model> departments = [];
    list.forEach((element) => departments.add(Depart_model.fromJson(element)));
    return departments;
  }

  Future<List<Department_allDetails_model>> fetch_departments_statistics(String token) async {
    final response = await get('https://cp.translationhubs.com/test/department/allWithStats',
        headers:{'Authorization':token} );
    if(response.status.hasError){
      return Future.error(response.statusText!);
    }

    List<dynamic> list = response.body;
    List<Department_allDetails_model> departments = [];
    list.forEach((element) => departments.add(Department_allDetails_model.fromJson(element)));
    return departments;
  }

  Future <dynamic> post_department(proj_name,token) async {

    final response = await post('https://cp.translationhubs.com/test/department',{
      "name": proj_name
    },headers:{'Authorization':token} );

    return response.body;
  }

  Future <dynamic> delete_department(int id,token) async {

    final response = await delete('https://cp.translationhubs.com/test/department/${id}'
        ,headers:{'Authorization':token} );

    return response.body;
  }

}