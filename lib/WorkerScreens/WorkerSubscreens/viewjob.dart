import 'package:flutter/material.dart';

class ViewJobScreen extends StatefulWidget {
  static const routeName = '/viewjobscreen';

  @override
  State<ViewJobScreen> createState() => _ViewJobScreenState();
}

class _ViewJobScreenState extends State<ViewJobScreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

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
                'Mechanic Required',
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
                  child: Image.asset(
                    'assets/images/portfolio1.jpeg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                detailsRow(context, 'Kaduwela', Icons.location_on),
                detailsRow(context, 'Mechanic', Icons.man),
                detailsRow(context, 'Jun 15', Icons.calendar_month),
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
                      'Looking for a mechanic to fix several electric items. Refrigerator, television etc. Someone near Kaduwela',
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
            // Spacer(),
            Padding(
              padding: const EdgeInsets.only(left: 40.0, right: 40, top: 10),
              child: Container(
                height: 40,
                width: width,
                decoration: BoxDecoration(
                  color: Theme.of(context).buttonColor,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Center(
                  child: Text('Accept Job',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).backgroundColor,
                        fontSize: 14,
                      )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
