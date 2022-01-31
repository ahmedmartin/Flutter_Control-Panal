import 'package:control_panel/controller/project_controller.dart';
import 'package:control_panel/controller/task_controller.dart';
import 'package:control_panel/controller/task_project_controller.dart';
import 'package:control_panel/view/update_project.dart';
import 'package:control_panel/view/update_task.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';



class Tasks_project extends StatelessWidget{

  Tasks_project_controller tasks_project = Get.put(Tasks_project_controller());
  Project_controller project_controller = Get.find();
  int index;

  Tasks_project(this.index);

  @override
  Widget build(BuildContext context) {

   tasks_project.id = project_controller.proj_list[index].id!;
   tasks_project.get_tasks();

    return Scaffold(
       body: Column(
         children: [
           _Draw_project(index, project_controller),
           __Draw_tasks_list(tasks_project)
         ],
       ),
    );
  }

}



class _Draw_project extends StatelessWidget{
  int ?index;
  Project_controller ?project_controller;
  _Draw_project(this.index,this.project_controller);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),//110
        color: const Color(0xff005194),
      ),
      margin: EdgeInsets.only(top: 35,right: 10,left: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // show project name

          SizedBox(height: 10,),
          Row(
            children: [
              SizedBox(width: 30,),
              GestureDetector(
                  child: Icon(Icons.edit,color:  Colors.white,size: 30,),
                  onTap: (){
                    project_controller!.model= project_controller!.proj_list[index!];
                    Get.off(Update_project());
                  }),
            ],
          ),

          Text(project_controller!.proj_list[index!].name!,style: const TextStyle(
              fontSize: 25,color: Colors.white,fontWeight: FontWeight.bold),),

          const SizedBox(height: 30,),

          //---------show task progress percentage and status and user name ---------------
          CircularPercentIndicator(
            radius: 150,
            lineWidth: 15,
            progressColor:Colors.green,
            backgroundColor: Colors.white70,
            //fillColor: Colors.blue,
            animationDuration: 2000,
            animation: true,
            percent: double.parse(project_controller!.proj_list[index!].progress!)/100 ,
            center: Text(project_controller!.proj_list[index!].progress!+' %',style: const TextStyle(fontSize: 22,color: Colors.white)),

          ),

          const SizedBox(height: 20,),

          //---------show description -----------------------
          Text(project_controller!.proj_list[index!].description!,style: const TextStyle(fontSize: 18,color: Colors.white),textAlign: TextAlign.center,),

          // -----------show start & end date -----------------------
          const SizedBox(height: 20,),
          Text('SD :'+project_controller!.proj_list[index!].startDate!,style: const TextStyle(fontSize: 20,color: Colors.greenAccent),),
          Text('DD : '+project_controller!.proj_list[index!].endDate!,style: const TextStyle(fontSize: 20,color: Colors.redAccent),),
          const SizedBox(height: 15,)

        ],
      ),
    );
  }

}

class __Draw_tasks_list extends StatefulWidget{

  Tasks_project_controller tasks_project_controller ;

  __Draw_tasks_list(this.tasks_project_controller);

  @override
  State<StatefulWidget> createState() {
    return _Draw_tasks_list(tasks_project_controller);
  }

}
class _Draw_tasks_list extends State<__Draw_tasks_list>{


  Tasks_project_controller tasks_project_controller ;

  _Draw_tasks_list(this.tasks_project_controller);

  @override
  Widget build(BuildContext context) {
    return Obx(() =>
    // check if fetch tasks
    tasks_project_controller.have_tasks.value?
    // ----------show in expandable list view----------------
    Expanded(
      child: ListView(
          children: [ExpansionPanelList(
            expansionCallback: (index,isExpanded){
              // -------------add if item expanded or not-----------------
              tasks_project_controller.tasks_list[index].expanded = !isExpanded;
              setState(() { });
            },
            //----------list of ExpansionPanel from tasks_list<task_model>-----------------
            children: tasks_project_controller.tasks_list.map<ExpansionPanel>((e) =>
                ExpansionPanel(
                  headerBuilder:(context,expand)=> Row(
                    children:  [
                      //---------- update task info -------------------
                      // const SizedBox(width: 10,),
                      // GestureDetector(
                      //   child:const Icon(Icons.edit,color: Color(0xff005194),size: 25,),
                      //   onTap: (){
                      //     tasks_project_controller.model = e;
                      //     Get.to(Update_task());
                      //   },
                      // ),

                      Expanded(
                        child: Text(e.name!,style: const TextStyle(fontSize: 25,
                            fontWeight: FontWeight.bold, color: Color(0xff005194)),textAlign: TextAlign.center,),
                      ),
                    ],
                  ),
                  body:draw_task(e.name,e.department!.name,e.user!.name, e.status,
                      e.startDate, e.endDate, e.progress!,e.id!) ,
                  isExpanded: e.expanded,
                  canTapOnHeader: true,
                )).toList(),

            animationDuration: const Duration(seconds: 1),
          ),]
      ),
    ):Container()
    );
  }

  Widget draw_task(taskName, projName, userName, status ,sDate,eDate,int progress,int task_id){
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
                              Obx(()=>tasks_project_controller.progress_message.value.isEmpty?CircularProgressIndicator():
                              Text(tasks_project_controller.progress_message.value, style: TextStyle(
                                  color: tasks_project_controller.progress_message.contains('successfully')?Colors.black:Colors.red),)),
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

                            await tasks_project_controller.update_progress(task_id,t);
                            if(tasks_project_controller.progress_message.contains('successfully')) {
                              tasks_project_controller.get_tasks();
                            }
                          },
                          onCancel: (){tasks_project_controller.progress_message.value='Update Task Progress Bar';}
                      );
                    },
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20,),

          // -----------show start & end date -----------------------
          const SizedBox(height: 20,),
          Text('SD :'+sDate,style: const TextStyle(fontSize: 20,color: Colors.greenAccent),),
          Text('DD : '+eDate,style: const TextStyle(fontSize: 20,color: Colors.redAccent),),
          const SizedBox(height: 15,)

        ],
      ),
    );
  }

}