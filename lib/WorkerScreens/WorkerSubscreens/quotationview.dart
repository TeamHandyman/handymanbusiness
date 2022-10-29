import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class quotationviewScreen extends StatefulWidget {
  static const routeName = '/quotationviewscreen';
  @override
  State<quotationviewScreen> createState() => _quotationviewScreenState();
}

class _quotationviewScreenState extends State<quotationviewScreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    //List data = ModalRoute.of(context).settings.arguments as List;
    // final DateFormat formatter = DateFormat('yyyy-MM-dd');
    // DateTime estDate = DateTime.parse(data[2]);

    // Widget requestPop(BuildContext context) {
    //   return Dialog(
    //     shape: RoundedRectangleBorder(
    //         borderRadius: BorderRadius.all(Radius.circular(15))),
    //     child: Container(
    //       margin: EdgeInsets.all(7),
    //       padding: EdgeInsets.all(7),
    //       width: width,
    //       height: height * 0.8,
    //       decoration: BoxDecoration(
    //           borderRadius: BorderRadius.all(Radius.circular(20)),
    //           image: DecorationImage(
    //               image: NetworkImage(data[5]), fit: BoxFit.contain)),
    //     ),
    //   );
    // }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: SingleChildScrollView(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Text(
                'Quotation',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Text(
              'Job title',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            Text(
              'Mechanic | Nuwan | Matara',
              style:
                  TextStyle(color: Theme.of(context).buttonColor, fontSize: 15),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              'Date',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            Text(
              '27, June 2022',
              style:
                  TextStyle(color: Theme.of(context).buttonColor, fontSize: 15),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              'Description',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            Text(
              'Sample description',
              style:
                  TextStyle(color: Theme.of(context).buttonColor, fontSize: 15),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              'Revenue method',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            Text(
              'Hourly method',
              style:
                  TextStyle(color: Theme.of(context).buttonColor, fontSize: 15),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              'Estimated Total',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            Text(
              'LKR 10 000',
              style:
                  TextStyle(color: Theme.of(context).buttonColor, fontSize: 15),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.keyboard_return_sharp,
                  color: Theme.of(context).buttonColor,
                ),
                SizedBox(
                  width: 5,
                ),
                GestureDetector(
                  onTap: () {
                    // showDialog(
                    //     context: context,
                    //     builder: (context) => requestPop(context));
                  },
                  child: Text(
                    'View image',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ),
              ],
            ),
          ],
        ),
      )),
    );
  }
}
