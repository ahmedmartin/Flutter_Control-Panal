import 'dart:math';

import 'package:control_panel/model/dashbord_model.dart';
import 'package:control_panel/repository/task_repo.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'login_controller.dart';



class Home_controller extends GetxController{

  RxString period=''.obs ;
  RxString department=''.obs;
  RxList<String> departments=[''].obs;
  RxString date =''.obs;
  RxBool have_graph = false.obs;


  String ?token;//='eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwibmFtZSI6IlNvYmhpIiwiZW1haWwiOm51bGwsImlzTWFuYWdlciI6dHJ1ZSwiaXNMZWFkZXIiOmZhbHNlLCJpYXQiOjE2NDE3NDYyMDMsImV4cCI6MTY0MTc2NzgwM30.GUU0V2CwlTZJTXajigzTqLVjR3QdjoieKkVkz20MehI';
  List<String> period_list=['yearly','monthly','weekly'];
  List<LineChartBarData> graph_list=[];
  Map<String,List<FlSpot>> graph ={};
  Map<String,Color> color_map = {};
  double max_y = 0;
  String start_date='';
  String end_date='';
  bool ?manger;


  @override
  void onInit() {
    super.onInit();

     Login_controller login_controller = Get.find();
    token = login_controller.success.token!;
    manger = login_controller.success.isManager;

  }

  show_dashpord_for_specific_department(){
    have_graph.value=false;
    graph_list.clear();
    graph_list.add(_get_graph(graph[department.value]!, color_map[department.value]!));
    have_graph.value=true;
  }

  set_defult_data(){
    have_graph.value=false;
    graph_list.clear();
    index=0;
    departments.clear();
    department.value='';
    max_y=0;

    var now = new DateTime.now();

    if(date.value.isEmpty) {
      if (period.value == 'yearly') {
        date.value = now.year.toString();
      } else if (period.value == 'monthly') {
        date.value = now.toString().substring(0, 7);
      } else {
        date.value = now.toString().substring(0, 10);
      }
    }

    if(start_date.isEmpty && end_date.isEmpty){
      if (period.value == 'yearly') {
        start_date = now.year.toString()+'-01-01';
        end_date = now.year.toString()+'-12-30';
      } else if (period.value == 'monthly') {

        var lastDayDateTime = (now.month < 12) ? new DateTime(now.year, now.month + 1, 0) : new DateTime(now.year + 1, 1, 0);

        start_date = now.year.toString()+'-'+now.month.toString()+'-01';
        end_date = lastDayDateTime.toString().substring(0,10);
      } else {

        DateTime getDate(DateTime d) => DateTime(d.year, d.month, d.day);
        var first_week_day = getDate(now.subtract(Duration(days: now.weekday)));
        var last_week_day = now.add(Duration(days: DateTime.daysPerWeek - now.weekday - 3));

        start_date = first_week_day.toString().substring(0,10);
        end_date =last_week_day.toString().substring(0,10);
      }
    }

  }


  show_dashpord() async {

    set_defult_data();
    int lenth_temp=7;
    
    if(period.value=='yearly') {
      lenth_temp=12;

    } else if(period.value=='monthly') {
      lenth_temp=31;
    }

    Map<String,dynamic> map = await Task_repo().dashboard(start_date, end_date, period.value, token!);

    map.forEach((key, value) {
      List<FlSpot> temp =[];//List.filled(13,FlSpot(1, 1));

      for(int i=1;i<=lenth_temp;i++){
        temp.add(FlSpot(i.toDouble(), 0));
      }

        value.forEach((element) {

          // get returned date day,month, year
          double day = double.parse(element['date_trunc'].toString().substring(8,10));
          double month = double.parse(element['date_trunc'].toString().substring(5,7));
          int year = int.parse(element['date_trunc'].toString().substring(0,4));

          double x = 0;
          if(period.value=='yearly'){
            x = month;
          }else if(period.value=='weekly'){

            // get start date day,month,year
            int temp_day = int.parse(start_date.substring(8,10));
            int temp_month = int.parse(start_date.substring(5,7));
            int temp_year = int.parse(start_date.substring(0,4));

              // gewt difference betwen stArt date & returned date to know which week day [1....7]
            x = (DateTime(year,month.toInt(),day.toInt()).difference(DateTime(temp_year,temp_month,temp_day)).inDays)+1;
          }else{
            x=day;
          }
          double y = double.parse(element['count'].toString());
          print(x.toInt()-1);
          temp[x.toInt()-1]=FlSpot(x, y);
        });
        temp.forEach((element) {element.y>max_y?max_y=element.y+2:max_y; });
        departments.add(key);
        graph_list.add(_get_graph_color(temp,key));
        graph[key]= temp;
    });

    //print(graph);
    if(graph_list.isNotEmpty)
      have_graph.value=true;

  }

  int index =0;
  bool use_main_colors=true;
  List<Color> colors = [Color(0xff006BE6),Color(0xff223E8A),Color(0xff0B966F),Color(0xffAED192),Color(0xffE9D8A6)
    ,Color(0xffEE9B00),Color(0xffCA6702),Color(0xffE0CE04),Color(0xffAE2012),Color(0xff9B2226)];
  //[Colors.blueAccent,Colors.deepPurple,Colors.green.shade900,Colors.redAccent,Colors.black,Colors.purpleAccent.shade700];

  LineChartBarData _get_graph_color(List<FlSpot> spot,String depart){

    // use first system colors *(Colors.accents)* if we need more use random colors
    Color color = use_main_colors? colors[index].withOpacity(.6):Color((Random().nextDouble() * colors[index].value).toInt()).withOpacity(.5);//Colors.primaries[Random().nextInt(Colors.primaries.length)].withOpacity(.5); //Color(Random().nextInt(0xffffffff)).withOpacity(0.5);

    color_map[depart]=color;

    index++;
    if(index>=colors.length) {
      index = 0;
      use_main_colors = false;
    }

    if(!use_main_colors)
      colors.add(color);

    return LineChartBarData(show: true,colors: [color],isCurved: false
      ,spots: spot,barWidth: 10,
      belowBarData: BarAreaData(
        show: true,
        colors: [color],
        //cutOffY: 1,
        //applyCutOffY: true,
      ),
    );
  }

  LineChartBarData _get_graph(List<FlSpot> spot,Color color){


    return LineChartBarData(show: true,colors: [color],isCurved: false
      ,spots: spot,barWidth: 10,
      belowBarData: BarAreaData(
        show: true,
        colors: [color],
        //cutOffY: 1,
        //applyCutOffY: true,
      ),
    );
  }
}