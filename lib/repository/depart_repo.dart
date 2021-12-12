import 'package:control_panel/model/depart_model.dart';
import 'package:get/get.dart';

class Depart_repo extends GetConnect {

  Future<List<String>> fetch_departments_name(String token) async {
    final response = await get('https://cp.translationhubs.com/test/department/all',
        headers:{'Authorization':token} );
    if(response.status.hasError){
      print('error');
      return Future.error(response.statusText!);
    }

    List<dynamic> list = response.body;
    List<String> departs = [];
    list.forEach((element) => departs.add(Depart_model.fromJson(element).name!));
    return departs;
  }

}