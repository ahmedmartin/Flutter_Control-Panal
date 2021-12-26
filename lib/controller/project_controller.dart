import 'package:control_panel/controller/login_controller.dart';
import 'package:control_panel/model/depart_model.dart';
import 'package:control_panel/model/project_details_model.dart';
import 'package:control_panel/repository/depart_repo.dart';
import 'package:control_panel/repository/project_repo.dart';
import 'package:get/get.dart';

class Project_controller extends GetxController{

  RxString department =''.obs;
  RxList <Depart_model> dapar_list = [Depart_model()].obs;
  RxList <Project_details_model> proj_list = [Project_details_model()].obs;
  RxBool have_projects = false.obs;

  String ?token;
  String ?department_id;
  Depart_model? selected_depart_model;
  Login_controller login_controller = Get.find();

  @override
  void onInit() async{
    super.onInit();


    token = login_controller.success.token!;


    dapar_list.value = await Depart_repo().fetch_departments_all_details(token!);

    print(dapar_list.value);

    if(login_controller.success.isManager!) {
      Depart_model temp = Depart_model();
      temp.name = 'All departments';
      temp.id = 0;
      dapar_list.insert(0,temp );
    }

  }


  get_projects()async{

    have_projects.value = false;


    if(department_id=='0') {
      department_id = 'All departments';
    }

    proj_list.value = await Project_repo().fetch_projects_all_details(token!,department_id);

    if(proj_list.isNotEmpty)
      have_projects.value=true;
  }


}