import 'package:flutter/material.dart';
import 'package:handymanbusiness/WorkerScreens/navigations.dart';
// import 'package:handyman/CustomerScreens/home.dart';
// import 'package:handyman/CustomerScreens/navigation.dart';

class FinalSignupscreen extends StatefulWidget {
  static const routeName = '/finalstep';
  @override
  State<FinalSignupscreen> createState() => _FinalSignupscreenState();
}

class _FinalSignupscreenState extends State<FinalSignupscreen> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30.0, left: 15, bottom: 30),
              child: GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 25,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 0, left: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Final Step',
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context).buttonColor,
                        fontSize: 40),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 5),
              child: Text(
                'You are almost there',
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 15, color: Colors.white),
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Stack(
                    children: [
                      const Center(
                        child: CircleAvatar(
                          backgroundColor: Colors.grey,
                          radius: 50,
                          child: Center(
                            child: Icon(
                              Icons.person,
                              color: Colors.white,
                              size: 40,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 5,
                        right: 110,
                        child: CircleAvatar(
                          radius: 20,
                          backgroundColor: Theme.of(context).buttonColor,
                          child: Center(
                            child: Icon(
                              Icons.camera_alt_rounded,
                              color: Theme.of(context).backgroundColor,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                        child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15.0, right: 15, top: 5, bottom: 5),
                          child: TextField(
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.person,
                                color: Theme.of(context).buttonColor,
                              ),
                              labelText: 'Select job type',
                              labelStyle: const TextStyle(color: Colors.white),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).shadowColor),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            keyboardType: TextInputType.emailAddress,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: Container(
                            height: 100,
                            width: width,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Icon(
                                      Icons.image,
                                      color: Theme.of(context).buttonColor,
                                    ),
                                  ),
                                  const Text(
                                    'Upload NIC front image',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15, right: 15, top: 5),
                          child: Container(
                            height: 100,
                            width: width,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Icon(
                                      Icons.image,
                                      color: Theme.of(context).buttonColor,
                                    ),
                                  ),
                                  const Text(
                                    'Upload NIC back image',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ))),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 20.0,
                    bottom: 10,
                    left: 15,
                    right: 15,
                  ),
                  child: GestureDetector(
                    onTap: () => Navigator.of(context)
                        .pushNamed(NavigationScreen.routeName),
                    child: Container(
                      height: 46,
                      width: width,
                      decoration: BoxDecoration(
                        color: Theme.of(context).buttonColor,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(
                        child: Text('Next',
                            style: TextStyle(
                                color: Theme.of(context).backgroundColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w500)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
