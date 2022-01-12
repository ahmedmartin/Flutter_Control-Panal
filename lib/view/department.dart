import 'package:control_panel/controller/department_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class Departments extends StatelessWidget{

  Department_controller depart_controller = Get.put(Department_controller());

  @override
  Widget build(BuildContext context) {

    depart_controller.get_data();

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(10),
        child: depart_controller.obx((value)=>ListView.builder(
            itemCount:value!.length ,
            itemBuilder: (context,index){
              return ListTile(
                contentPadding: EdgeInsets.all(10),
                title: Text(value[index].name!,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                subtitle: Text('Employee count  '+value[index].userCount.toString(),style: TextStyle(fontSize: 15),),
                trailing: GestureDetector(
                  child:Icon(Icons.delete,size: 20,),
                  onTap: (){ show_delete_department(value[index].id,value[index].name);  },
                ),
                leading: Icon(Icons.supervisor_account,size: 30,color: Color(0xff005194),),
                style: ListTileStyle.list,onTap: (){ _show_emolyees(value[index].users!);  },
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
              );
            })),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add,color:Colors.white,size: 30,),
        backgroundColor: Color(0xff005194),
        onPressed: (){
          _new_department();
        },
      ),
    );
  }

  _show_emolyees(List users){
    Get.defaultDialog(
      title: 'Employees',
      content: Container(
        width: Get.width-10,
        height: 250,
        child: ListView.builder(
            itemCount: users.length,
            itemBuilder:(context,index){
              return ListTile(
                title:  Text(users[index].name,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                leading: Icon(Icons.person,size: 30,),
                subtitle: Text(users[index].isLeader?'is leader':'',style: TextStyle(fontSize: 15)),
                trailing: Icon(Icons.admin_panel_settings,size: 30,
                  color: users[index].isLeader?Color(0xff005194):Colors.black38,),
              );
            }),
      )
    );
  }

  _new_department(){
    TextEditingController depart =TextEditingController();
    depart_controller.msg.value='';

    Get.defaultDialog(
      title: 'Add New Department',
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Obx(()=>Text(depart_controller.msg.value)),
          SizedBox(height: 20,),
          TextFormField(
            decoration: InputDecoration(
              hintText: 'Department',
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: Color(0xff005194))
              ),
              labelText: 'Department',
            ),
            controller:depart,
            //textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14),
          ),
          SizedBox(height: 20,),
        ],
      ),
      onConfirm: () async {
        await depart_controller.add_department(depart.text);
        if(depart_controller.msg.value.contains('successfully')){
          depart_controller.get_data();
        }
      },
      onCancel: (){}
    );
  }

  show_delete_department(id,name){

    depart_controller.msg.value='';

    Get.defaultDialog(
        title: 'delete ${name} ?',
        content: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(()=>Text(depart_controller.msg.value)),
            SizedBox(height: 20,),
          ],
        ),
        onConfirm: () async {
          depart_controller.msg.value='';
          await depart_controller.delete_department(id);
          if(depart_controller.msg.value.contains('deleted'))
            depart_controller.get_data();
        },
        onCancel: (){}
    );
  }

  // _delete_department(id)async{
  //   depart_controller.msg.value='';
  //   await depart_controller.delete_department(id);
  //   if(depart_controller.msg.value.contains('deleted')) {
  //     depart_controller.get_data();
  //     Get.snackbar('Deleted', 'Department Deleted Successfully',backgroundColor: Colors.green,
  //         snackPosition: SnackPosition.BOTTOM);
  //   }else{
  //     Get.snackbar('error',depart_controller.msg.value ,backgroundColor: Colors.red,
  //         snackPosition: SnackPosition.BOTTOM);
  //   }
  // }

}