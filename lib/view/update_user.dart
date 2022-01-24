import 'package:control_panel/controller/update_user_controller.dart';
import 'package:control_panel/controller/users_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';




class Update_user extends StatelessWidget{

  Update_user_controller update_user_controller = Get.put(Update_user_controller());

  @override
  Widget build(BuildContext context) {

    update_user_controller.set_data();
    TextEditingController name = TextEditingController(text: update_user_controller.name);
    TextEditingController user_name = TextEditingController(text: update_user_controller.user_name);
    TextEditingController email = TextEditingController(text: update_user_controller.email);
    // TextEditingController pass = TextEditingController();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 20,right: 20,top: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [

              SizedBox(height: 40,),
              _Draw_input_field(name, 'Employee Name'),
              SizedBox(height: 20,),
              _Draw_input_field(user_name, 'User Name'),
              SizedBox(height: 20,),
              _Draw_input_field(email, 'Email'),
              SizedBox(height: 20,),
              // _Draw_input_field(pass, 'Password'),
              // SizedBox(height: 20,),
              Row(
                children: [
                  Text('Leader',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.blue[900]),),
                  Obx(()=>Switch(value: update_user_controller.leader.value, activeColor: Colors.blue,
                      onChanged: (val){
                      update_user_controller.leader.value = val;
                  })),
                ],
              ),
              SizedBox(height: 40,),
              _Draw_update_button(update_user_controller, name, user_name, email)
            ],
          ),
        ),
      ),
    );
  }
}

class _Draw_input_field extends StatelessWidget{

  TextEditingController text_controller;
  String label;
  _Draw_input_field(this.text_controller,this.label);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
          hintText: label,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: Color(0xff005194))
          ),
          labelText: label
      ),
      controller: text_controller,
      //textAlign: TextAlign.center,
      style: TextStyle(fontSize: 14),
    );
  }

}

class _Draw_update_button extends StatelessWidget{

  Update_user_controller update_controller;
  TextEditingController name;
  TextEditingController user_name;
  TextEditingController email;

  _Draw_update_button(
      this.update_controller, this.name, this.user_name, this.email);

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

        update_controller.name = name.text;
        update_controller.user_name = user_name.text;
        update_controller.email = email.text;

        await update_controller.update_user();
        if(update_controller.msg.contains('successfully')) {
          Users_controller users_controller = Get.find();
          users_controller.get_data();
          Get.back();
          Get.snackbar('Message', update_controller.msg,
              snackPosition: SnackPosition.BOTTOM,backgroundColor: Colors.green);
        }else {
          Get.snackbar('Error', update_controller.msg,
              snackPosition: SnackPosition.BOTTOM,backgroundColor: Colors.redAccent);
        }

      },
    );
  }


}