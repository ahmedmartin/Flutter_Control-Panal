import 'package:control_panel/controller/users_controller.dart';
import 'package:control_panel/model/user_model.dart';
import 'package:control_panel/view/add_user.dart';
import 'package:control_panel/view/update_user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';




class Users extends StatelessWidget{

  Users_controller users_controller = Get.put(Users_controller());

  @override
  Widget build(BuildContext context) {

    users_controller.get_data();

    return Scaffold(
       body: Padding(
         padding: const EdgeInsets.only(right: 10,left: 10),
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.end,
           children: [
             SizedBox(height: 40,),
             _Draw_new_employee_button(),
             Expanded(child: _Draw_list_view(users_controller))
           ],
         ),
       ),
    );
  }

}


class _Draw_list_view extends StatelessWidget{
  Users_controller ?controller;

  _Draw_list_view(this.controller);

  @override
  Widget build(BuildContext context) {
    return controller!.obx((value)=>ListView.builder(
        itemCount: value!.length,
        itemBuilder: (context,index){
          return _Draw_list_item(value[index],controller!);
        }));
  }

}

class _Draw_list_item extends StatelessWidget{

  Users_controller controller;
  User_model ?model;
  _Draw_list_item(this.model,this.controller);

  @override
  Widget build(BuildContext context) {

    String email=model!.email ??'N/A';

    return Container(
      width: Get.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),//110
        color: const Color(0xff005194),
      ),
      margin: EdgeInsets.only(top: 10,bottom: 10),
      padding: EdgeInsets.only(left: 20,bottom: 10,top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // show project name

          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                child:Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    boxShadow: [BoxShadow(color:Colors.black54,spreadRadius: 2,blurRadius: 20 )],
                    color: Colors.white
                ),
                child: Text(model!.status!.toUpperCase(), style: TextStyle(fontWeight: FontWeight.bold,
                  color:model!.status =='active' ?Color(0xff005194) :Colors.grey,),),
              ),
                onTap: (){
                  _change_activation(model!.status! =="active", model!.name!);
                },
              ),
              SizedBox(width: 25,),
              GestureDetector(
                child: Icon(Icons.admin_panel_settings,size: 40, color:model!.isLeader!?Colors.green :Colors.grey,),
                onTap: (){
                  _show_is_admin(model!.isLeader!, model!.name!);
                },
              ),
              SizedBox(width: 25,),
              GestureDetector(
                  child: Icon(Icons.edit,color:  Colors.white,size: 25,),
                  onTap: (){
                    controller.user_model = model;
                    Get.to(Update_user());
                  }),
              SizedBox(width: 30,)
            ],
          ),
          const SizedBox(height: 30,),
          Center(child: Text('Name : '+model!.name!,style: const TextStyle(fontSize: 25,color: Colors.white,fontWeight: FontWeight.bold),)),
          const SizedBox(height: 30,),
          Text('User Name : '+model!.username!,style: const TextStyle(fontSize: 20,color: Colors.white)),
          const SizedBox(height: 15,),
          Text('Email : '+email,style: const TextStyle(fontSize: 20,color: Colors.white)),
          const SizedBox(height: 15,),
          Text('Department : '+model!.department!.name!,style: const TextStyle(fontSize: 20,color: Colors.white),),
          const SizedBox(height: 20,)

        ],
      ),
    );
  }

  _change_activation(bool active,name){

    if(active){
      controller.msg.value='DeActivate Employee $name ?';
    }else{
      controller.msg.value='Activate Employee $name ?';
    }
    Get.defaultDialog(
      title: active?'Deactivate':'Activate',
      content: Obx(()=>Text(controller.msg.value)),
      onConfirm: () async {
        await controller.update_employee_activation(model!.id!);
        controller.get_data();
      },
      onCancel: (){}
    );
  }

  _show_is_admin(bool isleader,name){
    Get.defaultDialog(
        content: Text(isleader?'$name is a Leader':'$name is not a Leader')
    );
  }

}

class _Draw_new_employee_button extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        decoration:BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Color(0xff005194)
        ),
        padding: EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
        child:const Text('New Employee',style:TextStyle(color:Colors.white,fontSize: 15,
            fontWeight: FontWeight.bold),textAlign: TextAlign.center,) ,
      ),
      onTap: (){
        Get.to(Add_user());
      },
    );
  }

}

