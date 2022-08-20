import 'package:flutter/material.dart';
import 'package:handymanbusiness/Onboarding/final.dart';
import 'package:handymanbusiness/Onboarding/login.dart';
import 'package:handymanbusiness/Onboarding/signup.dart';
import 'package:handymanbusiness/Onboarding/verification.dart';
import 'package:handymanbusiness/Onboarding/goodjob.dart';
import 'package:handymanbusiness/WorkerScreens/home.dart';
import 'package:handymanbusiness/WorkerScreens/joblist.dart';
import 'package:handymanbusiness/WorkerScreens/navigations.dart';
import 'package:handymanbusiness/WorkerScreens/notifications.dart';
import 'package:handymanbusiness/WorkerScreens/post.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Handyman',
      theme: ThemeData(
          primaryColor: Color.fromRGBO(44, 18, 75, 1),
          backgroundColor: Color.fromRGBO(30, 30, 30, 1),
          buttonColor: Color.fromRGBO(156, 107, 255, 1),
          shadowColor: Color.fromRGBO(217, 217, 217, 1)),
      routes: {
        '/': (ctx) => LoginScreen(),
        LoginScreen.routeName: (ctx) => LoginScreen(),
        SignupScreen.routeName: (ctx) => SignupScreen(),
        Verifyscreen.routeName: (ctx) => Verifyscreen(),
        Goodjobscreen.routeName: (ctx) => Goodjobscreen(),
        FinalSignupscreen.routeName: (ctx) => FinalSignupscreen(),
        NavigationScreen.routeName: (ctx) => NavigationScreen(),
        HomeScreen.routeName: (ctx) => HomeScreen(),
        JoblistScreen.routeName: (ctx) => JoblistScreen(),
        PostScreen.routeName: (ctx) => PostScreen(),
        NotificationScreen.routeName: (ctx) => NotificationScreen(),
      },
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key key, this.title}) : super(key: key);

//   final String title;

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
  
// }
