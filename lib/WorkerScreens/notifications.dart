import 'package:flutter/material.dart';
import 'package:handyman/WorkerScreens/WorkerSubscreens/quotation.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/authservice.dart';

class NotificationScreen extends StatefulWidget {
  static const routeName = '/notificationscreen';

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  var quotationNotifications = [];
  bool isLoading = true;
  @override
  void getWorkerNotificationsForQuotationRequests() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    Map<String, dynamic> payload = Jwt.parseJwt(token);
    var email = payload['email'];
    await AuthService()
        .getWorkerNotificationsForQuotationRequests(email)
        .then((val) {
      if (val.data["quotations"].isEmpty) {
        isLoading = false;
      } else {
        isLoading = false;
        quotationNotifications = val.data["quotations"];
      }
    });
    // for (var i in jobAcceptNotificationData) {
    //   if (!i['responses'].isEmpty) {
    //     emailList += i['responses'];
    //   }
    // }
    // for (var i in emailList) {
    //   await AuthService().getInfo(i).then((val) {
    //     if (val.data['success']) {
    //       workerDetails.add(val.data["user"]);
    //     }
    //   });
    // }

    setState(() {});
  }

  void initState() {
    super.initState();
    getWorkerNotificationsForQuotationRequests();
  }

  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    Widget notificationCard(BuildContext context, String text, Color color,
        String desc, String jobTitle, String quotationId, String oneSignalId) {
      List data = [jobTitle, quotationId];
      return GestureDetector(
        onTap: () {
          Navigator.of(context)
              .push(MaterialPageRoute(
                  builder: (context) => QuotationScreen(),
                  settings: RouteSettings(arguments: data)))
              .then((_) => setState(() {}));
          ;
        },
        child: Container(
          height: 70,
          width: width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.black38,
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 60,
                  width: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: color,
                  ),
                  child: Center(
                    child: Icon(Icons.notifications),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 5, top: 10),
                    child: Text(
                      text,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5, top: 5),
                    child: Text(
                      desc,
                      style: TextStyle(color: Colors.white54),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).backgroundColor,
        title: Text(
          'Handyman',
          style: TextStyle(
              fontSize: 25,
              fontFamily: 'AlfaSlabOne',
              color: Theme.of(context).buttonColor),
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.chat_bubble), onPressed: () {}),
        ],
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  child: Text(
                    'Notification',
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        fontSize: 40),
                    textAlign: TextAlign.start,
                  ),
                ),
              ],
            ),
            isLoading
                ? Center(
                    child: CircularProgressIndicator(
                      color: Theme.of(context).buttonColor,
                    ),
                  )
                : Center(),
            for (var i in quotationNotifications)
              notificationCard(
                  context,
                  'Quotation Request',
                  Colors.amber,
                  i['customerName'] + ' requested for a quotation',
                  i['jobTitle'],
                  i['_id'],
                  i['oneSignalId']),
          ],
        ),
      ),
    );
  }
}
