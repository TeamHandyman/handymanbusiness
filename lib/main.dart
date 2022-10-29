import 'package:flutter/material.dart';
import 'package:handyman/Onboarding/login.dart';
import 'package:handyman/WorkerScreens/WorkerSubscreens/confirmedjobsscreen.dart';
import 'package:handyman/WorkerScreens/WorkerSubscreens/quotation.dart';
import 'package:handyman/WorkerScreens/WorkerSubscreens/quotationview.dart';
import 'package:handyman/WorkerScreens/WorkerSubscreens/viewjob.dart';
import 'Onboarding/final.dart';
import 'Onboarding/goodjob.dart';
import 'Onboarding/signup.dart';
import 'Onboarding/verification.dart';
import 'WorkerScreens/home.dart';
import 'WorkerScreens/joblist.dart';
import 'WorkerScreens/navigations.dart';
import 'WorkerScreens/notifications.dart';
import 'WorkerScreens/post.dart';

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
          buttonColor: Color.fromRGBO(37, 150, 190, 1),
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
        ViewJobScreen.routeName: (ctx) => ViewJobScreen(),
        QuotationScreen.routeName: (ctx) => QuotationScreen(),
        ConfirmedJobsScreen.routeName: (ctx) => ConfirmedJobsScreen(),
        quotationviewScreen.routeName: (ctx) => quotationviewScreen(),
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
