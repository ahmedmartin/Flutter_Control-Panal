import 'dart:math';

import 'package:control_panel/controller/home_controller.dart';
import 'package:control_panel/model/project_details_model.dart';
import 'package:control_panel/view/department.dart';
import 'package:control_panel/view/projects.dart';
import 'package:control_panel/view/tasks.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';



class Home extends StatelessWidget{

Home_controller home_controller = Get.put(Home_controller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [

          SizedBox(height: 40,),
          _Draw_period_dropdown(home_controller),
          SizedBox(height: 10,),
          Obx(()=>home_controller.have_graph.value?_Draw_department_dropdown(home_controller):Container()),
          SizedBox(height: 10,),
          Obx(()=>home_controller.have_graph.value?_Draw_date_selector(home_controller):Container()),
          SizedBox(height: 20,),
          Expanded(child: Padding(
            padding: const EdgeInsets.only(left: 10,right: 20),
            child: _Draw_chart(home_controller),
          )),

          _Draw_bottom_tap(home_controller),
        ],
      ),
    );
  }

}

class _Draw_chart extends StatelessWidget{
  Home_controller controller;
  _Draw_chart(this.controller);
  @override
  Widget build(BuildContext context) {
    return Obx(()=>LineChart(
      LineChartData(
        // ---------------put data and draw lines------------------
        lineBarsData:controller.have_graph.value?controller.graph_list: [
          // _get_graph([FlSpot(10.5, 1.5), FlSpot(1, 1), FlSpot(2, 3), FlSpot(3, 4), FlSpot(3, 5), FlSpot(4, 4)]),
          //-----------------------------------------------------
          // _get_graph([FlSpot(1, 2), FlSpot(2, 2), FlSpot(3, 4), FlSpot(4, 5), FlSpot(4, 6), FlSpot(5, 5)]),
          //controller.have_graph.value?_get_graph(controller.graph['Project Management ']!):_get_graph([]),
        ],
        //maxX:controller.period.value=='yearly'?12:,
         minX: 1,
         maxY: controller.max_y,
        // minY: 0,

        //-------show text title in axis----------------------
        // axisTitleData: FlAxisTitleData(
        //     leftTitle: AxisTitle(showTitle: true, titleText: 'Value'),
        //     bottomTitle: AxisTitle(showTitle: true, titleText: controller.period.value)
        // ),

        //----------show data appear on axis------------------
        titlesData: axic_title(controller.period.value),

        // ----------show pont axis inside char --------------
        gridData: FlGridData(
          show: false,
        ),
        backgroundColor: Colors.white,
        borderData: FlBorderData(show: true,border: Border(left: BorderSide(width:10),bottom:BorderSide(width:10) )),
      ),
      swapAnimationDuration: Duration(milliseconds: 300), // Optional
      swapAnimationCurve: Curves.easeInOutQuad, // Optional
    ));
  }


  FlTitlesData axic_title(String period)=> FlTitlesData(
  bottomTitles: SideTitles(
  showTitles: true,
  interval: period =='monthly'?4:1,
  getTitles: (value) {
    if(period =='yearly') {
      switch (value.toInt()) {
        case 1:
          return 'Jan';
        case 2:
          return 'Feb';
        case 3:
          return 'Mar';
        case 4:
          return 'Apr';
        case 5:
          return 'May';
        case 6:
          return 'Jun';
        case 7:
          return 'Jul';
        case 8:
          return 'Aug';
        case 9:
          return 'Sep';
        case 10:
          return 'Oct';
        case 11:
          return 'Nov';
        case 12:
          return 'Dec';
        default:
          return '';
      }

    }

    return value.toString();

  }
  ),
  leftTitles: SideTitles(
  showTitles: true,
  interval: 1
  ),
  rightTitles: SideTitles(
  showTitles: false,),
  topTitles: SideTitles(
  showTitles: false,),
  );

}

class _Draw_period_dropdown extends StatelessWidget{

  Home_controller controller;
  _Draw_period_dropdown(this.controller);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration:BoxDecoration(
          border: Border.all(color: Color(0xff005194),width:3 ),
          borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding:  const EdgeInsets.only(left: 30,right: 30),
        //--------show users (spinner)--------------------------
        child:Obx(()=>DropdownButton(
          items: controller.period_list.map((val)=>
              DropdownMenuItem(child:Text(val),value: val,)).toList(),
          hint: const Text('Select Period',style: TextStyle(color:Color(0xff005194),fontSize: 20,
              fontWeight: FontWeight.bold),textAlign: TextAlign.center,) ,
          value: controller.period.value.isEmpty?null:controller.period.value ,
          icon: const Icon(Icons.arrow_drop_down_circle,color:Color(0xff005194),),
          style: const TextStyle(color:Color(0xff005194),fontSize: 20,
              fontWeight: FontWeight.bold),
          onChanged: (val){
             controller.period.value = val.toString();
             controller.date.value='';
             controller.start_date='';
             controller.end_date='';
             controller.show_dashpord();
          },
        )),
      ),
    );
  }

}

class _Draw_department_dropdown extends StatelessWidget{

  Home_controller controller;
  _Draw_department_dropdown(this.controller);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration:BoxDecoration(
          border: Border.all(color: Color(0xff005194),width:3 ),
          borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding:  const EdgeInsets.only(left: 30,right: 30),
        //--------show users (spinner)--------------------------
        child:Obx(()=>DropdownButton(
          items: controller.departments.value.map((val)=>
              DropdownMenuItem(child:Text(val,style: TextStyle(color:controller.color_map[val],fontSize: 20,
             fontWeight: FontWeight.bold),),value: val,)).toList(),
          hint: const Text('Select department',style: TextStyle(color:Color(0xff005194),fontSize: 20,
              fontWeight: FontWeight.bold),textAlign: TextAlign.center,) ,
          value: controller.department.value.isEmpty?null:controller.department.value ,
          icon: const Icon(Icons.arrow_drop_down_circle,color:Color(0xff005194),),
          // style: const TextStyle(color:Color(0xff005194),fontSize: 20,
          //     fontWeight: FontWeight.bold),
          onChanged: (val){
            controller.department.value = val.toString();
            controller.show_dashpord_for_specific_department();
          },
        )),
      ),
    );
  }

}


class CustomMonthPicker extends DatePickerModel {
  CustomMonthPicker({DateTime ?currentTime, DateTime ?minTime, DateTime ?maxTime,
    LocaleType ?locale}) : super(locale: locale, minTime: minTime, maxTime:
  maxTime, currentTime: currentTime);

  @override
  List<int> layoutProportions() {
    return [1, 1, 0];
  }
}

class CustomyearPicker extends DatePickerModel {
  CustomyearPicker({DateTime ?currentTime, DateTime ?minTime, DateTime ?maxTime,
    LocaleType ?locale}) : super(locale: locale, minTime: minTime, maxTime:
  maxTime, currentTime: currentTime);

  @override
  List<int> layoutProportions() {
    return [1, 0, 0];
  }
}

class _Draw_date_selector extends StatelessWidget{

  Home_controller controller;
  _Draw_date_selector(this.controller);

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
            Obx(()=>Text(controller.date.value,style:const TextStyle(color:Color(0xff005194),fontSize: 20,
                fontWeight: FontWeight.bold)) ),
            const Icon(Icons.date_range,size: 30,color: Color(0xff005194),)
          ],
        ) ,
      ),
      onTap: (){
        _select_date(controller.period.value, context);
      },
    );
  }

  _select_date(String period,context){
    if(period=='yearly'){
      DatePicker.showPicker(context,
          showTitleActions: true,
          pickerModel: CustomyearPicker(
              minTime: DateTime(2010),
              maxTime: DateTime.now(),
              currentTime: DateTime.now()
          ),
          onConfirm: (date) {
            controller.date.value = date.year.toString();
            controller.start_date = date.year.toString()+'-01-01';
            controller.end_date = date.year.toString()+'-12-30';

            controller.show_dashpord();
          });
    }else if(period=='monthly'){
      DatePicker.showPicker(context,
          showTitleActions: true,
          pickerModel: CustomMonthPicker(
              minTime: DateTime(2010),
              maxTime: DateTime.now(),
              currentTime: DateTime.now()
          ),
          onConfirm: (date) {
            controller.date.value = date.toString().substring(0,7);

            var last_month_Day = (date.month < 12) ? new DateTime(date.year, date.month + 1, 0) : new DateTime(date.year + 1, 1, 0);

            controller.start_date = date.year.toString()+'-'+date.month.toString()+'-01';
            controller.end_date = last_month_Day.toString().substring(0,10);

            controller.show_dashpord();

          });
    }else{
      DatePicker.showDatePicker(context,
          currentTime:DateTime.now() ,
          onConfirm: (date){
            controller.date.value = date.toString().substring(0,10);

            DateTime getDate(DateTime d) => DateTime(d.year, d.month, d.day);
            var first_week_day = getDate(date.subtract(Duration(days: date.weekday)));
            var last_week_day = date.add(Duration(days: DateTime.daysPerWeek - date.weekday - 3));

            controller.start_date = first_week_day.toString().substring(0,10);
            controller.end_date = last_week_day.toString().substring(0,10);

            controller.show_dashpord();
      });
    }

  }

}


class _Draw_bottom_tap extends StatelessWidget{

  Home_controller ?controller ;
  _Draw_bottom_tap(this.controller);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: FractionalOffset.bottomCenter,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50),
            topRight: Radius.circular(50),
          ),
          color: Color(0xff005194),
        ),

        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // projects
            GestureDetector(
              child:  CircleAvatar(
                backgroundColor: Colors.white,
                radius: 20,
                child: Icon(Icons.dashboard,size:25,color: Color(0xff005194),),
              ),
              onTap: (){
                  Get.to(Projects());
              },
            ),

            // projects
            GestureDetector(
              child:  CircleAvatar(
                backgroundColor: Colors.white,
                radius: 20,
                child: Icon(Icons.account_tree_rounded,size:25,color: Color(0xff005194),),
              ),
              onTap: (){
                Get.to(Tasks());
              },
            ),

            //department
           if(controller!.manger!)GestureDetector(
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 20,
                child: Icon(Icons.all_inbox_rounded,size: 25,color:Color(0xff005194),),
              ),
              onTap: (){
                 Get.to(Departments());
              },
            ),

            //employees
            GestureDetector (
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 20,
                child: Icon(Icons.supervisor_account,size: 25,color: Color(0xff005194),),
              ),
              // onTap: ()=> Get.to(Dictionary()),
            ),

            //logout
            // GestureDetector(
            //   child: CircleAvatar(
            //     backgroundColor: Colors.white,
            //     radius: 20,
            //     child: Icon(Icons.login,size: 25,color: Color(0xff005194),),
            //   ),
            //   // onTap: (){Get.to(Game_road_map());},
            // ),

          ],
        ),
      ),
    );
  }

}


