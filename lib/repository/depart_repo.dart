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

}