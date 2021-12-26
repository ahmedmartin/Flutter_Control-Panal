import 'package:control_panel/controller/login_controller.dart';
import 'package:control_panel/controller/project_controller.dart';
import 'package:control_panel/model/depart_model.dart';
import 'package:control_panel/repository/depart_repo.dart';
import 'package:control_panel/repository/project_repo.dart';
import 'package:get/get.dart';




class Add_project_controller extends GetxController{

  RxString department =''.obs;
  RxList <Depart_model> dapar_list = [Depart_model()].obs;
  RxString start_date = ''.obs;
  RxString end_date = ''.obs;


  String ?token;
  String department_id='';
  String proj_name='';
  String description = '';
  String create_project_message='';
  Depart_model? selected_depart_model;
  Login_controller login_controller = Get.find();
  DateTime S_date = DateTime.now();
  DateTime E_date = DateTime.now();


  @override
  void onInit() async{
    super.onInit();

    token = login_controller.success.token!;

    start_date.value = S_date.toString().substring(0, 10);
    end_date.value = E_date.toString().substring(0, 10);

  }

  get_departs() async {
    dapar_list.value = await Depart_repo().fetch_departments_all_details(token!);
  }


  set_defult(){
    S_date = DateTime.now();
    E_date = DateTime.now();
    start_date.value = S_date.toString().substring(0, 10);
    end_date.value = E_date.toString().substring(0, 10);
    proj_name = '';
    description='';
    create_project_message='';
    selected_depart_model = null;
    department_id='';
    dapar_list.value = [Depart_model()];
    Project_controller project_controller = Get.find();
    project_controller.department.value='';
    project_controller.have_projects.value=false;
  }

  create_project() async {
     create_project_message = await Project_repo().post_project(proj_name,
         description, start_date.value, end_date.value, department_id, token);
  }

}