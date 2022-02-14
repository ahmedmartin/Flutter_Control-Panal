import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';



class Main_controller extends GetxController{


  @override
  Future<void> onInit() async {
    FirebaseMessaging.instance.requestPermission(sound: true,alert: true);



    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      print("onMessageOpenedApp: $message");
      // data = message.data;
      //Get.to(notification_info());
    });



    // initializition_local_notification();

    super.onInit();
  }


  supscription_topic(String department){

     if(department != '-1'){
       FirebaseMessaging.instance.subscribeToTopic(department);
     }else{
       FirebaseMessaging.instance.subscribeToTopic('all_topics');
     }
  }


  push_notification_topic(data_body,data_title,topic) async {
    String header = 'key=AAAAOlegTmw:APA91bGGRHPiGft_V-q5v_X8qwPb1QgUU6km4YM6hp9RSUJwoZTaaiV8bpf2OjQ2SXoO3xbFufAIglvDy6TRRv_YpSBwUbavtNQq2NRrSYFGxSaalcVazwK4p8MVac5InZvsF0_BrQS2';
    Map<String,dynamic> body = {
      "condition" : "'$topic' in topics",
      "notification" : {
        "body" : data_body,
        "title": data_title,
        // "image":selected_imge.value,
        "sound":"default"
      }
      // ,
      // "data" : {
      //   "body" : data_body,
      //   "title": data_title,
      //   "image":selected_imge.value
      //
      // }
    };
    final response = await Dio().post('https://fcm.googleapis.com/fcm/send',data: body
        ,options: Options(headers:{'Authorization':header} ));

    //print('response_data ${response.data}');
  }


  // initializition_local_notification() async {
  //   var initializationSettingsAndroid =
  //   AndroidInitializationSettings('@mipmap/ic_launcher');
  //   var initializationSettingsIOS = IOSInitializationSettings(
  //       requestAlertPermission: true,
  //       requestBadgePermission: true,
  //       requestSoundPermission: true,
  //       onDidReceiveLocalNotification: (int id, String ?title, String ?body, String ?payload) async {});
  //   var initializationSettings = InitializationSettings(android: initializationSettingsAndroid,iOS: initializationSettingsIOS);
  //   await flutterLocalNotificationsPlugin.initialize(initializationSettings,
  //      onSelectNotification: (String ?payload) async {
  //       if (payload != null) {
  //         Map<String,dynamic> mapData = jsonDecode(payload);
  //         data = mapData;
  //         Get.to(notification_info());
  //       }
  //     });
  // }

}