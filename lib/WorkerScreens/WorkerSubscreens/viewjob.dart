import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:handyman/services/authservice.dart';
import 'package:intl/intl.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:progress_indicator_button/progress_button.dart';

import '../../Onboarding/login.dart';

class ViewJobScreen extends StatefulWidget {
  static const routeName = '/viewjobscreen';

  @override
  State<ViewJobScreen> createState() => _ViewJobScreenState();
}

class _ViewJobScreenState extends State<ViewJobScreen> {
  final DateFormat formatter = DateFormat('yyyy-MM-dd');

  @override
  Widget build(BuildContext context) {
    List ad_data = ModalRoute.of(context).settings.arguments as List;
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    void httpJob(AnimationController controller) async {
      controller.forward();
      var msg = "You have recieved a job request from " +
          ad_data[7] +
          " " +
          ad_data[8] +
          ".";

      await AuthService().sendPushNotification(ad_data[6], msg);
      controller.reset();
    }

    Widget detailsRow(BuildContext context, String text, IconData icon) {
      return Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: Theme.of(context).buttonColor,
              size: 16,
            ),
            Text(
              text,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15, bottom: 5),
              child: Text(
                ad_data[0],
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 50.0, right: 50, top: 5, bottom: 5),
              child: Container(
                height: height * 0.4,
                width: width,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    ad_data[5],
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                detailsRow(context, ad_data[2], Icons.location_on),
                detailsRow(context, ad_data[3], Icons.man),
                detailsRow(context, formatter.format(ad_data[4]),
                    Icons.calendar_month),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15, top: 15, bottom: 10),
              child: Column(
                children: [
                  Text(
                    'Job Description',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 40, right: 40, top: 5),
                    child: Text(
                      ad_data[1],
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
            // Spacer(),
            Padding(
              padding: const EdgeInsets.only(left: 40.0, right: 40, top: 10),
              child: GestureDetector(
                child: Container(
                  height: 40,
                  width: width,
                  decoration: BoxDecoration(
                    // color: Theme.of(context).buttonColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: ProgressButton(
                      color: Theme.of(context).buttonColor,
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      child: Text('Accept Job',
                          style: TextStyle(
                              color: Theme.of(context).backgroundColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w500)),
                      onPressed: (AnimationController controller) async {
                        await httpJob(controller);
                      }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
