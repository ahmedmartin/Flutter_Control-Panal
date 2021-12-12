import 'package:control_panel/controller/login_controller.dart';
import 'package:control_panel/controller/task_controller.dart';
import 'package:control_panel/model/task_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class tasks extends StatelessWidget{

  Login_controller login_controller = Get.find();
  //List<String> dep_list = ['dep_1','dep_2','dep_3'];

  @override
  Widget build(BuildContext context) {

    Task_controller task_controller = Get.put(
        Task_controller(login_controller.success.token!,'date'));

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

         const SizedBox(height: 30,),
          Container(
            height: 50,
            decoration:BoxDecoration(
                border: Border.all(color: Color(0xff005194),width:3 ),
                //color:Color(0xff005194) ,
                borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding:  const EdgeInsets.only(left: 40,right: 40),
              child: Obx(()=> DropdownButton(
                items: task_controller.dapar_list.value.map((val){return DropdownMenuItem(
                child: Text(val),value: val,);}).toList(),
                hint: Text('Select department',style: TextStyle(color:Color(0xff005194),fontSize: 20,
                    fontWeight: FontWeight.bold),textAlign: TextAlign.center,) ,
                value: task_controller.department.value.isEmpty? null: task_controller.department.value,
                icon: Icon(Icons.arrow_drop_down_circle,color:Color(0xff005194),),
                style: TextStyle(color:Color(0xff005194),fontSize: 20,
                    fontWeight: FontWeight.bold),
                onChanged: (val){
                  task_controller.department.value = val.toString();
                  task_controller.get_tasks();
                },
              ),)
            ),
          ),

          task_controller.obx((state) => Container(
            height: Get.height-80,
            width: Get.width-20,
            margin: EdgeInsets.only(right: 10,left: 10),
            child: ListView.builder(
                itemCount: state!.length,
                itemBuilder: (context,index){
                  return draw_task(state[index].name, state[index].project!.name,
                      state[index].user!.name, state[index].status, state[index].description,
                      state[index].startDate, state[index].endDate, state[index].progress);
                }),
          )
          ),
        ],
      ),
    );
  }

  Widget draw_task(task_name, proj_name, user_name, status,description ,s_date,e_date,progress){
    return  Card(
      elevation: 20,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(80),
      ),
      shadowColor: Colors.lightBlueAccent,
      margin: const EdgeInsets.only(top: 15,bottom: 15),
      color: Colors.indigo[900],
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(proj_name,style: const TextStyle(fontSize: 30,color: Colors.white,fontWeight: FontWeight.bold),),
            const SizedBox(height: 30,),
            CircularPercentIndicator(
              radius: 140,
              lineWidth: 15,
              progressColor:status == 'pending'?Colors.grey:
              status == 'pending review'?Colors.yellow:
              status=='inprogress'?Colors.orangeAccent :Colors.greenAccent,
              //fillColor: Colors.blue,
              animationDuration: 1200,
              animation: true,
              percent:progress/100 ,
              center:Text(status,style:  TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: status == 'pending'?Colors.grey:
              status == 'pending review'?Colors.yellow:
              status=='inprogress'?Colors.orangeAccent :Colors.greenAccent,),) ,
              header:Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text(task_name,style: const TextStyle(fontSize: 20,color: Colors.white),textAlign: TextAlign.center,),
              ),
              footer:Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(user_name,style: const TextStyle(fontSize: 20,color: Colors.white),),
              ),
            ),
            const SizedBox(height: 20,),

            Text(description,style: const TextStyle(fontSize: 18,color: Colors.white),textAlign: TextAlign.center,),

            const SizedBox(height: 20,),
            Text('S_D :'+s_date,style: const TextStyle(fontSize: 20,color: Colors.greenAccent),),
            Text('E_D : '+e_date,style: const TextStyle(fontSize: 20,color: Colors.redAccent),),
            const SizedBox(height: 15,)

          ],
        ),
      ),
    );
  }

}


// Container(
//     decoration: BoxDecoration(
//       borderRadius: BorderRadius.circular(20),
//       color: status == 'pending'?Colors.grey:
//              status == 'in progress'?Colors.orangeAccent:Colors.greenAccent,
//     ),
//     padding: EdgeInsets.only(left: 30,right: 30,top: 10,bottom: 10),
//     child: Text(status,style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),))