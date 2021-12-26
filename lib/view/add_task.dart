import 'package:control_panel/controller/add_task_controller.dart';
import 'package:control_panel/model/project_model.dart';
import 'package:control_panel/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



class Add_task extends StatelessWidget{

  TextEditingController task_name = TextEditingController();
  TextEditingController task_desc = TextEditingController();
  Add_task_controller add_controller = Get.put(Add_task_controller());

  @override
  Widget build(BuildContext context) {

    add_controller.get_users();
    add_controller.get_projects();

    return WillPopScope(onWillPop:()async{add_controller.set_defult(); return true;},child:Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 40,),
              //--------task name field ------------------------
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Task name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: Color(0xff005194))
                  ),
                  labelText: 'Task name'
                ),
                controller: task_name,
                //textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14),
              ),

              const SizedBox(height: 20,),
              //----------description field------------------
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Description',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: Color(0xff005194))
                  ),
                  labelText: 'Description',
                ),
                controller:task_desc,
                //textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14),
              ),

              const SizedBox(height: 20,),
              // -------------show projects spinner ----------------------
              _Draw_project_dropdwon(add_controller),


              const SizedBox(height: 20,),
              //----------start & end Date picker -------------------
              _Drow_date_selector(add_controller, true),
              SizedBox(height: 10,),
              _Drow_date_selector(add_controller, false),

              SizedBox(height: 20,),
              // -------------show users spinner ----------------------
              _Draw_users_dropdown(add_controller),

              SizedBox(height: 30,),
              _Draw_create_button(add_controller,task_name,task_desc)

            ],
          ),
        ),
      ),
    ));

  }


}

class _Draw_project_dropdwon extends StatelessWidget{
  Add_task_controller add_controller;
  _Draw_project_dropdwon(this.add_controller);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration:BoxDecoration(
          border: Border.all(color: Color(0xff005194),width:3 ),
          borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding:  const EdgeInsets.only(left: 30,right: 30),
        //--------show projects (spinner)--------------------------
        child: Obx(()=> DropdownButton(
          items: add_controller.all_projects.value.map((val)=>
              DropdownMenuItem(child:val.name==null?CircularProgressIndicator():Text(val.name!),value: val,)).toList(),
          hint: const Text('Select project',style: TextStyle(color:Color(0xff005194),fontSize: 20,
              fontWeight: FontWeight.bold),textAlign: TextAlign.center,) ,
          value: add_controller.proj.value.isEmpty? null:add_controller.selected_project_model ,
          icon: const Icon(Icons.arrow_drop_down_circle,color:Color(0xff005194),),
          style: const TextStyle(color:Color(0xff005194),fontSize: 20,
              fontWeight: FontWeight.bold),
          onChanged: (val){
            add_controller.selected_project_model = (val as Project_model);
            add_controller.proj.value = (val as Project_model).name!;
            //print(add_controller.proj.value);
            add_controller.proj_id = (val as Project_model).id!;
          },
        )),
      ),
    );
  }

}

class _Draw_users_dropdown extends StatelessWidget{

  Add_task_controller add_controller;
  _Draw_users_dropdown(this.add_controller);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration:BoxDecoration(
          border: Border.all(color: Color(0xff005194),width:3 ),
          borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding:  const EdgeInsets.only(left: 30,right: 30),
        //--------show users (spinner)--------------------------
        child: Obx(()=> DropdownButton(
          items: add_controller.all_users.value.map((val)=>
              DropdownMenuItem(child:val.name==null?CircularProgressIndicator():Text(val.name!),value: val,)).toList(),
          hint: const Text('Select user',style: TextStyle(color:Color(0xff005194),fontSize: 20,
              fontWeight: FontWeight.bold),textAlign: TextAlign.center,) ,
          value: add_controller.user.value.isEmpty? null:add_controller.selected_user_model ,
          icon: const Icon(Icons.arrow_drop_down_circle,color:Color(0xff005194),),
          style: const TextStyle(color:Color(0xff005194),fontSize: 20,
              fontWeight: FontWeight.bold),
          onChanged: (val){
            add_controller.selected_user_model = (val as User_model);
            add_controller.user.value = val.name!;
            // print(add_controller.proj.value);
            add_controller.user_id = (val as User_model).id!.toString();
          },
        )),
      ),
    );
  }

}

class _Drow_date_selector extends StatelessWidget{

  Add_task_controller add_controller;
  bool SorE;
  _Drow_date_selector(this.add_controller,this.SorE);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 40,
        width: 200,
        decoration:BoxDecoration(
            border: Border.all(color: Color(0xff005194),width:3 ),
            borderRadius: BorderRadius.circular(20)),
        child:Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Obx(()=>Text(SorE?add_controller.start_date.value:add_controller.end_date.value,style:const TextStyle(color:Color(0xff005194),fontSize: 20,
                fontWeight: FontWeight.bold)) ),
            const Icon(Icons.date_range,size: 30,color: Color(0xff005194),)
          ],
        ) ,
      ),
      onTap: (){
        _select_date();
      },
    );
  }

  _select_date() async {
    final DateTime? selected = await showDatePicker(
        context: Get.context!,
        initialDate:SorE? add_controller.S_date:add_controller.E_date,
        firstDate: DateTime(2010),
        lastDate: add_controller.S_date.add(const Duration(days: 165*10)),
        cancelText: 'Cancel',
        confirmText: 'OK',
        helpText: 'Select Task Day'
    );
    if (selected != null ) {
      if(SorE) {
        add_controller.S_date = selected;
        add_controller.start_date.value = selected.toString().substring(0, 10);
      }else{
        add_controller.E_date = selected;
        add_controller.end_date.value = selected.toString().substring(0, 10);
      }

    }
  }

}

class _Draw_create_button extends StatelessWidget{

  Add_task_controller add_controller;
  TextEditingController task_name;
  TextEditingController description;
  _Draw_create_button(this.add_controller,this.task_name,this.description);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: 100,
        height: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: Colors.blue[900]
        ),
        child:const Center(
            child: Text("Create", style: TextStyle(
                color: Colors.white, fontSize: 24))),
      ),
      onTap: ()async{

        add_controller.task_name = task_name.text;
        add_controller.description = description.text;
        await add_controller.create_task();
        if(add_controller.create_task_message.contains('Task successfully created')) {
          Get.back();
          Get.snackbar('Message', add_controller.create_task_message,
              snackPosition: SnackPosition.BOTTOM,backgroundColor: Colors.green);
          add_controller.set_defult();
        }else {
          Get.snackbar('Error', add_controller.create_task_message,
              snackPosition: SnackPosition.BOTTOM,backgroundColor: Colors.redAccent);
        }
      },
    );
  }


}