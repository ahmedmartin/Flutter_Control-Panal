import 'dart:math';

import 'package:control_panel/controller/login_controller.dart';
import 'package:control_panel/view/tasks.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class Login extends StatelessWidget {

  TextEditingController username_text = TextEditingController();
  TextEditingController pass_text = TextEditingController();
  Login_controller login_controller = Get.put(Login_controller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    // -----------logo photo-------------------
                    Image.asset('assets/logo.png', width: 200, height: 200,),
                    //------------- username input -------------------
                   // login_controller.obx((state) => Text( state!.token!)),

                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'username',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      controller: username_text,
                      //textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14),
                    ),
                    
                    //--------- password ---------------------
                    SizedBox(height: 20),
                    Obx(()=>TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      obscuringCharacter: '*',
                      obscureText: login_controller.show_pass.value,
                      // false if you need show text
                      decoration: InputDecoration(
                          hintText: 'password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          prefixIcon: GestureDetector(
                            child:  Icon(login_controller.show_pass.value ?
                               Icons.remove_red_eye_outlined
                                :Icons.visibility_off_outlined
                              , color: Colors.black38,
                              size: 20,
                            ),
                            onTap: () {
                              login_controller.show_pass.value = !login_controller.show_pass.value;
                              print(login_controller.show_pass.value);
                            },
                          )
                      ),
                      controller: pass_text,
                      //textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14),
                    )),

                    //------ login button ---------------
                    SizedBox(height: 30),
                    GestureDetector(
                        child: Container(
                          width: 100,
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(24),
                              color: Colors.indigo[900]
                          ),
                          child:const Center(
                              child: Text("LOGIN", style: TextStyle(
                                  color: Colors.white, fontSize: 24))),
                        ),
                        onTap: () async{
                          bool is_signed =  await login_controller.login(username_text.text,pass_text.text);
                           if(is_signed)
                             Get.off(tasks());
                        }
                    ),
                  ],
                ),
              )
      ),
    );
  }
}
