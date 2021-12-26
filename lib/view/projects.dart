import 'package:control_panel/controller/project_controller.dart';
import 'package:control_panel/model/depart_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';



class Projects extends StatelessWidget{

  Project_controller project_controller = Get.put(Project_controller());

  @override
  Widget build(BuildContext context) {
   return Scaffold(
     body: Column(
       mainAxisAlignment: MainAxisAlignment.center,
       children: [
           SizedBox(height: 40,),
           _Draw_departments_dropdown(project_controller),
           SizedBox(height: 20,),
           Expanded(child: _Draw_list_view(project_controller))
       ],
     ),
   );
  }

}

class _Draw_departments_dropdown extends StatelessWidget{

  Project_controller ?project_controller;
  _Draw_departments_dropdown(this.project_controller);


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
          items: project_controller!.dapar_list.value.map((val)=>
              DropdownMenuItem(child:val.name==null?CircularProgressIndicator():Text(val.name!),value: val,)).toList(),
          hint: const Text('Select department',style: TextStyle(color:Color(0xff005194),fontSize: 20,
              fontWeight: FontWeight.bold),textAlign: TextAlign.center,) ,
          value: project_controller!.department.value.isEmpty? null: project_controller!.selected_depart_model ,
          icon: const Icon(Icons.arrow_drop_down_circle,color:Color(0xff005194),),
          style: const TextStyle(color:Color(0xff005194),fontSize: 20,
              fontWeight: FontWeight.bold),
          onChanged: (val){
            project_controller!.selected_depart_model = (val as Depart_model);
            project_controller!.department.value = (val as Depart_model).name!;
            project_controller!.department_id = (val as Depart_model).id!.toString();
            project_controller!.get_projects();
          },
        )),
      ),
    );
  }


}

class _Draw_list_view extends StatelessWidget{
  Project_controller ?project_controller;

  _Draw_list_view(this.project_controller);

  @override
  Widget build(BuildContext context) {
    return Obx(()=>project_controller!.have_projects.value? ListView.builder(
        itemCount: project_controller!.proj_list.length,
        itemBuilder: (context,index){
          return _Draw_project_of_list(index, project_controller);
        }):Container());
  }

}

class _Draw_project_of_list extends StatelessWidget{
  int ?index;
  Project_controller ?project_controller;
  _Draw_project_of_list(this.index,this.project_controller);

  @override
  Widget build(BuildContext context) {
    return Container(
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
          Text(project_controller!.proj_list[index!].name!,style: const TextStyle(fontSize: 25,color: Colors.white,fontWeight: FontWeight.bold),),
          const SizedBox(height: 30,),

          //---------show task progress percentage and status and user name ---------------
          CircularPercentIndicator(
            radius: 150,
            lineWidth: 15,
            progressColor:Colors.green,
            backgroundColor: Colors.white70,
            //fillColor: Colors.blue,
            animationDuration: 1200,
            animation: true,
            percent: double.parse(project_controller!.proj_list[index!].progress!)/100 ,
            center: _Draw_center(),

          ),

          const SizedBox(height: 20,),

          //---------show description -----------------------
          Text(project_controller!.proj_list[index!].description!,style: const TextStyle(fontSize: 18,color: Colors.white),textAlign: TextAlign.center,),

          // -----------show start & end date -----------------------
          const SizedBox(height: 20,),
          Text('S_D :'+project_controller!.proj_list[index!].startDate!,style: const TextStyle(fontSize: 20,color: Colors.greenAccent),),
          Text('E_D : '+project_controller!.proj_list[index!].endDate!,style: const TextStyle(fontSize: 20,color: Colors.redAccent),),
          const SizedBox(height: 15,)

        ],
      ),
    );
  }

 Widget _Draw_center(){
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Text(project_controller!.proj_list[index!].progress!+' %',style: const TextStyle(fontSize: 22,color: Colors.white)),
          SizedBox(width: 5,),
          GestureDetector(
            child: Icon(Icons.edit,color:  Colors.white,size: 25,),
            onTap: (){
              double val =double.parse(project_controller!.proj_list[index!].progress!);

              Get.defaultDialog(
                  contentPadding: EdgeInsets.all(10),
                  title: 'Update Progress',
                  barrierDismissible: false,
                  content:  Column(
                    children: [
                      // Obx(()=>task_controller.progress_message.value.isEmpty?CircularProgressIndicator():
                      // Text(task_controller.progress_message.value, style: TextStyle(
                      //     color: task_controller.progress_message.contains('successfully')?Colors.black:Colors.red),)),
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

                    // await task_controller.update_progress(task_id,t);
                    // if(task_controller.progress_message.contains('successfully')) {
                    //   task_controller.have_tasks.value = false;
                    //   task_controller.department.value = '';
                    // }
                  },
                  //onCancel: (){task_controller.progress_message.value='Update Task Progress Bar';}
              );
            },
          ),
        ],
      ),
    );
 }

}