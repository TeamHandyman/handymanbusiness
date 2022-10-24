import 'package:flutter/material.dart';
import 'package:handyman/WorkerScreens/WorkerSubscreens/viewjob.dart';
import 'package:handyman/services/authservice.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/homescreen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String title, desc, workerType;
  List<dynamic> ads = [];
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  @override
  void getCustomerAds() async {
    await AuthService().getCustomerAds("Landscaping").then((val) {
      ads = val.data["job"];
    });
    setState(() {});
  }

  void initState() {
    super.initState();
    getCustomerAds();
  }

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
                  color: Theme.of(context).backgroundColor,
                  fontSize: 12,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      );
    }

    Widget jobRequestTile(
        BuildContext context,
        String id,
        String fname,
        String lname,
        String proPic,
        String city,
        String job,
        DateTime date,
        String title,
        String desc,
        String mainImgUrl,
        String oneSignalID,
        String jobStatus) {
      List ad_data = [
        title,
        desc,
        city,
        job,
        date,
        mainImgUrl,
        oneSignalID,
        fname,
        lname
      ];
      return Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 15, right: 15, top: 10),
            child: Container(
              width: width,
              height: 30,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.grey,
                    radius: 20,
                    backgroundImage: proPic != "" ? NetworkImage(proPic) : null,
                    child: Center(
                      child: proPic == ""
                          ? Icon(
                              Icons.person,
                              color: Colors.white,
                              size: 15,
                            )
                          : null,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 5.0,
                      right: 15,
                    ),
                    child: Text(
                      fname + ' ' + lname,
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 15.0, right: 15, top: 5, bottom: 5),
            child: Card(
              color: Theme.of(context).shadowColor,
              child: Container(
                height: 230,
                width: width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 15.0, top: 15, right: 15),
                      child: Text(title,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16)),
                    ),
                    Divider(
                      height: 15,
                      thickness: 2,
                      indent: 15,
                      endIndent: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        detailsRow(context, city, Icons.location_on),
                        detailsRow(context, job, Icons.man),
                        detailsRow(context, formatter.format(date),
                            Icons.calendar_month),
                      ],
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 15.0, top: 10, right: 15),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.network(
                              mainImgUrl,
                              height: 80.0,
                              width: 80.0,
                              fit: BoxFit.fill,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15, right: 5),
                            child: Container(
                              width: 180,
                              child: Text(
                                desc,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 20.0,
                        bottom: 10,
                        left: 15,
                        right: 15,
                      ),
                      child: GestureDetector(
                        onTap: () {
                          ad_data.add(id);
                          ad_data.add(jobStatus);
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ViewJobScreen(),
                              settings: RouteSettings(arguments: ad_data)));
                        },
                        child: Container(
                          height: 40,
                          width: width,
                          decoration: BoxDecoration(
                            color: Theme.of(context).buttonColor,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Center(
                            child: Text('View Job',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).backgroundColor,
                                  fontSize: 14,
                                )),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
        ],
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
          IconButton(icon: Icon(Icons.more_vert), onPressed: () {}),
        ],
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 3.0, bottom: 0, left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Hello there',
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        fontSize: 40),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 3.0, bottom: 0, left: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Flexible(
                    child: Text(
                      'Welcome to Handyman now you can search for workers, jobs and more',
                      style: TextStyle(
                          fontWeight: FontWeight.w300,
                          color: Colors.white,
                          fontSize: 15),
                      textAlign: TextAlign.start,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15, top: 15, bottom: 15),
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).shadowColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                height: 50,
                width: width,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 25, right: 25),
                        child: Text(
                          'Search',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 25, right: 25),
                        child: Icon(
                          Icons.search,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'Filter',
                    style: TextStyle(
                        color: Theme.of(context).shadowColor, fontSize: 15),
                  ),
                ),
                Icon(
                  Icons.account_tree_outlined,
                  color: Theme.of(context).shadowColor,
                  size: 15,
                )
              ],
            ),
            for (var i in ads)
              jobRequestTile(
                  context,
                  i['_id'],
                  i['fName'],
                  i['lName'],
                  i['proPic'] != "" ? i['proPic'] : "",
                  'Kaduwela',
                  i['workerType'],
                  DateTime.parse(i['date']),
                  i['title'],
                  i['description'],
                  i['urls'][0],
                  i['oneSignalID'],
                  i['jobStatus']),
          ],
        ),
      ),
    );
  }
}
