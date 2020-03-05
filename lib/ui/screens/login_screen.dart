import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:restofood_api/core/models/action_model.dart';
import 'package:restofood_api/core/services/auth_services.dart';
import 'package:restofood_api/core/utils/toast_utils.dart';
import 'package:restofood_api/ui/screens/home_screen.dart';
import 'package:restofood_api/ui/widgets/input_field.dart';
import 'package:restofood_api/ui/widgets/primary_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
      child: Scaffold(
        body: SingleChildScrollView(
          child: LoginBody()
        ),
      ),
    );
  }
}

class LoginBody extends StatefulWidget {
  LoginBody({Key key}) : super(key: key);

  @override
  _LoginBodyState createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  
  var usernameController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  void initState() { 
    super.initState();
    getPref();
  }

  Future<void> login(BuildContext context) async {
    if (usernameController.text.isNotEmpty && passwordController.text.isNotEmpty) {

        Map<String, dynamic> data = {
          "username": usernameController.text,
          "password": passwordController.text
        };

        ToastUtils.show("Mencoba Login");
        var response = await AuthServices.login2(data);

        print("Status:"+ response.status.toString());
        print("message:"+ response.message.toString());

        if(response.status==200){
          ToastUtils.show(response.message);
          ToastUtils.show("Welcome : " + response.data.email.toString());

          savePref(
            usernameController.text, 
            response.data.email.toString(),
            response.data.pathPhoto.toString()
          );

          Navigator.pushNamedAndRemoveUntil(context, "/profile", (Route<dynamic> routes) => false);

        }else{
          ToastUtils.show(response.message);
        }


    } else {
      ToastUtils.show("Silahkan isi semua field");
    }
  }


  void register(BuildContext context) {
      Navigator.pushNamed(context, "/register");
  }

  savePref(String username, String email, String foto) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      pref.setString('username', username);
      pref.setString('email', email);
      pref.setString('foto', foto);
    });
  }

  getPref() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final username = pref.getString('username');

    if (username != null) {
        Navigator.pushNamedAndRemoveUntil(context, "/profile", (Route<dynamic> routes) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[

        //Bagian headers
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 2.5,
          color: Colors.orange,
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.fastfood, size: 40, color: Colors.white),
                SizedBox(height: 10),
                Text(
                  "Restofood",
                  style: TextStyle(
                    fontSize: 35, 
                    color: Colors.white, 
                    fontWeight: FontWeight.bold
                  ),
                )
              ],
            ),
          )
        ),

        //Bagian field login
        Padding(
          padding: EdgeInsets.only(left: 20, right: 20, top: 30),
          child: Column(
            children: <Widget>[
              InputField(
                action: TextInputAction.done,
                type: TextInputType.text,
                controller: usernameController,
                hintText: "Username",
              ),
              SizedBox(height: 10),
              InputField(
                action: TextInputAction.done,
                type: TextInputType.text,
                controller: passwordController,
                hintText: "Password",
                secureText: true,
              ),
              SizedBox(height: 15),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 45,
                child: PrimaryButton(
                  color: Colors.orange,
                  text: "LOGIN",
                  onClick: () => login(context),
                ),
              ),

              SizedBox(height: 15),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 45,
                child: PrimaryButton(
                  color: Colors.grey,
                  text: "REGISTER",
                  onClick: () => register(context),
                ),
              )


            ],
          ),
        )


      ],
    );
  }
}

