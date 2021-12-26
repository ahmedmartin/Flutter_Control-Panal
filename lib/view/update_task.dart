import 'package:control_panel/controller/task_controller.dart';
import 'package:control_panel/controller/update_task_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



class Update_task extends StatelessWidget{

  Update_task_controller update_controller = Get.put(Update_task_controller());

  @override
  Widget build(BuildContext context) {

    update_controller.set_date();
    TextEditingController task_name = TextEditingController(text: update_controller.task_name);
    TextEditingController task_desc = TextEditingController(text: update_controller.description);


    return Scaffold(
         body: SingleChildScrollView(
             child: Column(
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
                 //----------start & end Date picker -------------------
                 _Drow_date_selector(update_controller, true),
                 SizedBox(height: 10,),
                 _Drow_date_selector(update_controller, false),

                 SizedBox(height: 30,),
                 _Draw_update_button(update_controller,task_name,task_desc)
               ],
             ),
         ),
    );
  }

}

class _Drow_date_selector extends StatelessWidget{

  Update_task_controller update_controller;
  bool SorE;
  _Drow_date_selector(this.update_controller,this.SorE);

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
            Obx(()=>Text(SorE?update_controller.start_date.value:update_controller.end_date.value,style:const TextStyle(color:Color(0xff005194),fontSize: 20,
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
        initialDate:SorE? update_controller.S_date:update_controller.E_date,
        firstDate: DateTime(2010),
        lastDate: update_controller.S_date.add(const Duration(days: 165*10)),
        cancelText: 'Cancel',
        confirmText: 'OK',
        helpText: 'Select Task Day'
    );
    if (selected != null ) {
      if(SorE) {
        update_controller.S_date = selected;
        update_controller.start_date.value = selected.toString().substring(0, 10);
      }else{
        update_controller.E_date = selected;
        update_controller.end_date.value = selected.toString().substring(0, 10);
      }

    }
  }

}

class _Draw_update_button extends StatelessWidget{

  Update_task_controller update_controller;
  TextEditingController task_name;
  TextEditingController description;
  _Draw_update_button(this.update_controller,this.task_name,this.description);

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
            child: Text("Update", style: TextStyle(
                color: Colors.white, fontSize: 24))),
      ),
      onTap: ()async{

        update_controller.task_name = task_name.text;
        update_controller.description = description.text;
        await update_controller.update_task();
        if(update_controller.update_task_message.contains('successfully')) {
          Task_controller task_controller = Get.find();
          task_controller.department.value='';
          task_controller.have_tasks.value=false;
          Get.back();
          Get.snackbar('Message', update_controller.update_task_message,
              snackPosition: SnackPosition.BOTTOM,backgroundColor: Colors.green);
        }else {
          Get.snackbar('Error', update_controller.update_task_message,
              snackPosition: SnackPosition.BOTTOM,backgroundColor: Colors.redAccent);
        }

      },
    );
  }


}