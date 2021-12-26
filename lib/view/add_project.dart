import 'package:control_panel/controller/add_project_controller.dart';
import 'package:control_panel/model/depart_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';





class Add_project extends StatelessWidget{

  TextEditingController proj_name = TextEditingController();
  TextEditingController proj_desc = TextEditingController();
  Add_project_controller add_controller = Get.put(Add_project_controller());

  @override
  Widget build(BuildContext context) {

    add_controller.get_departs();

    return WillPopScope(onWillPop:()async{add_controller.set_defult(); return true;},child:Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 40,),
              //--------project name field ------------------------
              TextFormField(
                decoration: InputDecoration(
                    hintText: 'project name',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: Color(0xff005194))
                    ),
                    labelText: 'project name'
                ),
                controller: proj_name,
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
                controller:proj_desc,
                //textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14),
              ),

              const SizedBox(height: 20,),
              // -------------show departments spinner ----------------------
              _Draw_departments_dropdown(add_controller),


              const SizedBox(height: 20,),
              //----------start & end Date picker -------------------
              _Drow_date_selector(add_controller, true),
              SizedBox(height: 10,),
              _Drow_date_selector(add_controller, false),

              SizedBox(height: 20,),


              SizedBox(height: 30,),
              // -----------show create project button-------------
              _Draw_create_button(add_controller,proj_name,proj_desc)

            ],
          ),
        ),
      ),
    ));

  }


}

class _Draw_departments_dropdown extends StatelessWidget{

  Add_project_controller ?add_controller;
  _Draw_departments_dropdown(this.add_controller);


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
          items: add_controller!.dapar_list.value.map((val)=>
              DropdownMenuItem(child:val.name==null?CircularProgressIndicator():Text(val.name!),value: val,)).toList(),
          hint: const Text('Select department',style: TextStyle(color:Color(0xff005194),fontSize: 20,
              fontWeight: FontWeight.bold),textAlign: TextAlign.center,) ,
          value: add_controller!.department.value.isEmpty? null: add_controller!.selected_depart_model ,
          icon: const Icon(Icons.arrow_drop_down_circle,color:Color(0xff005194),),
          style: const TextStyle(color:Color(0xff005194),fontSize: 20,
              fontWeight: FontWeight.bold),
          onChanged: (val){
            add_controller!.selected_depart_model = (val as Depart_model);
            add_controller!.department.value = (val as Depart_model).name!;
            add_controller!.department_id = (val as Depart_model).id!.toString();
          },
        )),
      ),
    );
  }


}

class _Drow_date_selector extends StatelessWidget{

  Add_project_controller add_controller;
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

  Add_project_controller add_controller;
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

        add_controller.proj_name = task_name.text;
        add_controller.description = description.text;
        await add_controller.create_project();
        if(add_controller.create_project_message.contains('successfully')) {
          Get.back();
          Get.snackbar('Message', add_controller.create_project_message,
              snackPosition: SnackPosition.BOTTOM,backgroundColor: Colors.green);
          add_controller.set_defult();
        }else {
          Get.snackbar('Error', add_controller.create_project_message,
              snackPosition: SnackPosition.BOTTOM,backgroundColor: Colors.redAccent);
        }
      },
    );
  }


}