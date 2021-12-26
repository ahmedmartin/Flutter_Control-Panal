import 'package:control_panel/controller/login_controller.dart';
import 'package:control_panel/controller/task_controller.dart';
import 'package:control_panel/controller/update_task_controller.dart';
import 'package:control_panel/view/add_task.dart';
import 'package:control_panel/view/update_task.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class Tasks extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
     return _tasks();
  }

}

class _tasks extends State<Tasks>{

  Task_controller task_controller =Get.put(Task_controller());
  DateTime ?selectedDate;


  @override
  void initState() {
    super.initState();

    selectedDate = DateTime.now();
    task_controller.date.value = selectedDate.toString().substring(0,10);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

         const SizedBox(height: 35,),
          //------- draw select department spinner --------------------------
          Container(
            height: 50,
            decoration:BoxDecoration(
                border: Border.all(color: Color(0xff005194),width:3 ),
                borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding:  const EdgeInsets.only(left: 30,right: 30),
              //--------show departments (spinner)--------------------------
              child: Obx(()=> DropdownButton(
                items: task_controller.dapar_list.value.map(
                        (val)=> DropdownMenuItem(child: Text(val),value: val,)).toList(),
                hint: const Text('Select department',style: TextStyle(color:Color(0xff005194),fontSize: 20,
                    fontWeight: FontWeight.bold),textAlign: TextAlign.center,) ,
                value: task_controller.department.value.isEmpty? null: task_controller.department.value,
                icon: const Icon(Icons.arrow_drop_down_circle,color:Color(0xff005194),),
                style: const TextStyle(color:Color(0xff005194),fontSize: 20,
                    fontWeight: FontWeight.bold),
                onChanged: (val){
                  task_controller.department.value = val.toString();
                  task_controller.get_tasks();
                },
              ),)
            ),
          ),

         const SizedBox(height: 40,),
         //---------------date picker & new task button ------------------------
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //---------------date picker ----------------------------
              GestureDetector(
                child: Container(
                  height: 40,
                  width: 200,
                  decoration:BoxDecoration(
                      border: Border.all(color: Color(0xff005194),width:3 ),
                      borderRadius: BorderRadius.circular(20)),
                  child:Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Obx(()=>Text(task_controller.date.value,style:const TextStyle(color:Color(0xff005194),fontSize: 20,
                                   fontWeight: FontWeight.bold)) ),
                      const Icon(Icons.date_range,size: 30,color: Color(0xff005194),)
                    ],
                  ) ,
                ),
                onTap: (){
                 _select_date();
                },
              ),

              // -------=new task button ------------------
              GestureDetector(
                child: Container(
                  decoration:BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color(0xff005194)
                  ),
                  padding: EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
                  child:const Text('New Task',style:TextStyle(color:Colors.white,fontSize: 15,
                      fontWeight: FontWeight.bold),textAlign: TextAlign.center,) ,
                ),
                onTap: (){
                     Get.to(Add_task());
                },
              ),
            ],
          ) ,

          //--------------------show tasks list view -------------------------
          Obx(() =>
          // check if fetch tasks
            task_controller.have_tasks.value?
                // ----------show in expandable list view----------------
            Expanded(
              child: ListView(
                children: [ExpansionPanelList(
                  expansionCallback: (index,isExpanded){
                    // -------------add if item expanded or not-----------------
                    task_controller.tasks_list[index].expanded = !isExpanded;
                    setState(() { });
                  },
                //----------list of ExpansionPanel from tasks_list<task_model>-----------------
                  children: task_controller.tasks_list.map<ExpansionPanel>((e) =>
                      ExpansionPanel(
                          headerBuilder:(context,expand)=> Row(
                            children:  [
                              const SizedBox(width: 10,),
                              GestureDetector(
                                child:const Icon(Icons.edit,color: Color(0xff005194),size: 25,),
                                onTap: (){
                                  task_controller.model = e;
                                  Get.to(Update_task());
                                },
                              ),

                              Expanded(
                                child: Text(e.name!,style: const TextStyle(fontSize: 25,
                                    fontWeight: FontWeight.bold, color: Color(0xff005194)),textAlign: TextAlign.center,),
                              ),
                            ],
                          ),
                          body:draw_task(e.name,e.project ==null?'N/A':e.project!.name!,e.user!.name!, e.status, e.description,
                                         e.startDate, e.endDate, e.progress!,e.id!) ,
                          isExpanded: e.expanded,
                          canTapOnHeader: true,
                      )).toList(),

                 animationDuration: const Duration(seconds: 1),
                ),]
              ),
            ):Container()
          ),
        ],
      ),
    );
  }

  Widget draw_task(taskName, projName, userName, status,description ,sDate,eDate,int progress,int task_id){
    return  Container(
      width: Get.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(70),//110
        color: const Color(0xff005194),
      ),
      margin: EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // show project name
          Text(projName,style: const TextStyle(fontSize: 25,color: Colors.white,fontWeight: FontWeight.bold),),
          const SizedBox(height: 30,),

          //---------show task progress percentage and status and user name ---------------
          CircularPercentIndicator(
            radius: 150,
            lineWidth: 15,
            progressColor:status == 'pending'?Colors.grey:
            status == 'pending review'?Colors.yellow:
            status=='inprogress'?Colors.orangeAccent :Colors.greenAccent,
            //fillColor: Colors.blue,
            animationDuration: 1200,
            animation: true,
            percent:progress/100 ,
            center:Text(status,style:  TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: status == 'pending'?Colors.grey:
            status == 'pending review'?Colors.yellow:
            status=='inprogress'?Colors.orangeAccent :Colors.greenAccent,),) ,
            header:Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text(userName,style: const TextStyle(fontSize: 22,color: Colors.white),textAlign: TextAlign.center,),
            ),
            footer: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: 30,),
                  Text(progress.toString()+' %',style: const TextStyle(fontSize: 22,color: Colors.white)),
                  SizedBox(width: 30,),
                  GestureDetector(
                      child: Icon(Icons.edit,color:  Colors.white,size: 25,),
                    onTap: (){
                        double val =progress.toDouble();

                        Get.defaultDialog(
                          contentPadding: EdgeInsets.all(10),
                          title: 'Update Progress',
                          barrierDismissible: false,
                          content:  Column(
                            children: [
                              Obx(()=>task_controller.progress_message.value.isEmpty?CircularProgressIndicator():
                              Text(task_controller.progress_message.value, style: TextStyle(
                                  color: task_controller.progress_message.contains('successfully')?Colors.black:Colors.red),)),
                              SizedBox(height: 20,),
                              SleekCircularSlider(
                                appearance: CircularSliderAppearance(customColors: CustomSliderColors()),
                                initialValue: val,
                                onChange: (double value) {
                                  val = value ;
                                }),
                            ],
                          ),
                           onConfirm: ()async{
                             int t = val.toInt();
                             if(t != val)
                               t+=1;

                              await task_controller.update_progress(task_id,t);
                              if(task_controller.progress_message.contains('successfully')) {
                                task_controller.have_tasks.value = false;
                                task_controller.department.value = '';
                              }
                            },
                           onCancel: (){task_controller.progress_message.value='Update Task Progress Bar';}
                        );
                    },
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20,),

          //---------show description -----------------------
          Text(description,style: const TextStyle(fontSize: 18,color: Colors.white),textAlign: TextAlign.center,),

          // -----------show start & end date -----------------------
          const SizedBox(height: 20,),
          Text('SD :'+sDate,style: const TextStyle(fontSize: 20,color: Colors.greenAccent),),
          Text('DD : '+eDate,style: const TextStyle(fontSize: 20,color: Colors.redAccent),),
          const SizedBox(height: 15,)

        ],
      ),
    );
  }


  _select_date() async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: selectedDate!,
      firstDate: DateTime(2010),
      lastDate: selectedDate!.add(const Duration(days: 165*10)),
      cancelText: 'Cancel',
      confirmText: 'OK',
      helpText: 'Select Task Day'
    );
    if (selected != null && selected != selectedDate) {
      setState(() {
        selectedDate = selected;
        task_controller.date.value = selectedDate.toString().substring(0,10);
      });
      if(task_controller.department.isNotEmpty) {
        task_controller.get_tasks();
      }
    }
  }

}



