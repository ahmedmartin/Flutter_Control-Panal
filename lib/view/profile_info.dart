import 'package:control_panel/controller/profile_info_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



class Profile_info extends StatelessWidget{

 Profile_info_controller info_controller = Get.put(Profile_info_controller());

 @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: info_controller.obx((value){
         return Column(
           crossAxisAlignment: CrossAxisAlignment.center,
           children: [

             _Draw_page_header(value),
             SizedBox(height: 30,),
             Text('user_name : '+value!.username!,style: TextStyle(fontSize: 20,color: Color(0xff005194)),),
             SizedBox(height: 20,),
             Text('email : '+value.email,style: TextStyle(fontSize: 20,color: Color(0xff005194)),),
             SizedBox(height: 20,),
             Text('department : '+value.department!.name!,style: TextStyle(fontSize: 20,color: Color(0xff005194)),),
           ],
         );
       }),
    );
  }

  Widget _Draw_page_header(var value){
    return Container(
      height: 280,
      width: Get.width,
      decoration: BoxDecoration(
          color: Color(0xff005194),
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(70),
              bottomRight: Radius.circular(70)
          )
      ),
      child: Column(
        children: [
          SizedBox(height: 35,),
          CircleAvatar(backgroundImage: AssetImage('assets/logo.png'),
            radius: 75 ,backgroundColor: Colors.white,),

          Icon(Icons.admin_panel_settings,size: 40,color:value!.isLeader!?Colors.green:Colors.grey ,),
          Text(value.name!,style: TextStyle(fontSize: 25,
              color: Colors.white,fontWeight: FontWeight.bold),),
        ],
      ),
    );
  }

}