import 'package:control_panel/controller/add_user_controller.dart';
import 'package:control_panel/controller/users_controller.dart';
import 'package:control_panel/model/depart_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';




class Add_user extends StatelessWidget{

  TextEditingController name = TextEditingController();
  TextEditingController user_name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  Add_user_controller add_controller = Get.put(Add_user_controller());

  @override
  Widget build(BuildContext context) {

    add_controller.get_departs();
    add_controller.set_defult();

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
              _Draw_input_field(pass, 'Password'),
              SizedBox(height: 20,),
              _Draw_departments_dropdown(add_controller),
              SizedBox(height: 20,),
              _Draw_radio_button_group(add_controller),

              SizedBox(height: 40,),
              _Draw_add_button(add_controller, name, user_name, email,pass)
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

class _Draw_radio_button_group extends StatefulWidget{

  Add_user_controller controller ;
  _Draw_radio_button_group(this.controller);

  @override
  State<StatefulWidget> createState() {
    return _radio_button(controller);
  }

}

class _radio_button extends State<_Draw_radio_button_group>{

  int val = 1;
  Add_user_controller controller ;
  _radio_button(this.controller);


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text("Employee"),
          leading: Radio(
            value: 1,
            groupValue: val,
            onChanged: (int ?value) {
              setState(() {
                val = value!;
                controller.rule.value=value;
              });
            },
            activeColor: Colors.blue[900],
          ),
        ),
        ListTile(
          title: Text("Leader"),
          leading: Radio(
            value: 2,
            groupValue: val,
            onChanged: (int ?value) {
              setState(() {
                val = value!;
                controller.rule.value=value;
              });
            },
            activeColor: Colors.blue[900],
          ),
        ),
        ListTile(
          title: Text("Manager"),
          leading: Radio(
            value: 3,
            groupValue: val,
            onChanged: (int ?value) {
              setState(() {
                val = value!;
                controller.rule.value=value;
              });
            },
            activeColor: Colors.blue[900],
          ),
        ),
      ],
    );
  }

}

class _Draw_departments_dropdown extends StatelessWidget{

  Add_user_controller ?add_controller;
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


class _Draw_add_button extends StatelessWidget{

  Add_user_controller add_controller;
  TextEditingController name;
  TextEditingController user_name;
  TextEditingController email;
  TextEditingController pass;

  _Draw_add_button(this.add_controller, this.name, this.user_name, this.email,this.pass);

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
            child: Text("Submit", style: TextStyle(
                color: Colors.white, fontSize: 24))),
      ),
      onTap: ()async{

        add_controller.name = name.text;
        add_controller.user_name = user_name.text;
        add_controller.email = email.text;
        add_controller.pass = pass.text;


        await add_controller.add_user();
        if(add_controller.msg.contains('successfulluy')) {
          Users_controller users_controller = Get.find();
          users_controller.get_data();
          Get.back();
          Get.snackbar('Message', add_controller.msg,
              snackPosition: SnackPosition.BOTTOM,backgroundColor: Colors.green);
        }else {
          Get.snackbar('Error', add_controller.msg,
              snackPosition: SnackPosition.BOTTOM,backgroundColor: Colors.redAccent);
        }

      },
    );
  }


}

