import 'package:flutter/material.dart';
import 'package:restofood_api/ui/screens/dashboard_screen.dart';
import 'package:restofood_api/ui/screens/home_screen.dart';
import 'package:restofood_api/ui/screens/login_screen.dart';
import 'package:restofood_api/ui/screens/register_screen.dart';
import 'package:restofood_api/ui/screens/profile_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Restofood",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.orange,
        accentColor: Colors.orange
      ),
      home: cekLogin(),
      routes: {
        "/dashboard": (context) => DashboardScreen(),
        "/profile": (context) => ProfileScreen(),
        "/login": (context) => LoginScreen(),
        "/register": (context) => RegisterScreen()
      },
    );
  }
}

class cekLogin extends StatefulWidget {
  cekLogin({Key key}) : super(key: key);

  @override
  _cekLoginState createState() => _cekLoginState();
}

class _cekLoginState extends State<cekLogin> {

  @override
  void initState() { 
    super.initState();
    getPref();
  }

  getPref() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final username = pref.getString('username');

    if (username != null) {
      Future.delayed(const Duration(milliseconds: 2000), () {
          Navigator.pushNamedAndRemoveUntil(context, "/profile", (Route<dynamic> routes) => false);
      });
    }else{
      Future.delayed(const Duration(milliseconds: 2000), () {
          Navigator.pushNamedAndRemoveUntil(context, "/login", (Route<dynamic> routes) => false);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: spashscreen(),
    );
  }

  Widget spashscreen(){
        return Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
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
        );
  }
}