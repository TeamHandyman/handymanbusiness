// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables, avoid_print, unused_catch_stack

import 'package:cloudinary/cloudinary.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:handyman/Onboarding/login.dart';
import 'package:handyman/WorkerScreens/navigations.dart';
// import 'package:handyman/services/authservice.dart';
import 'package:image_picker/image_picker.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:progress_indicator_button/progress_button.dart';
import 'dart:io';
import 'package:path/path.dart';
import '../services/authservice.dart';
// import 'package:handyman/CustomerScreens/home.dart';
// import 'package:handyman/CustomerScreens/navigation.dart';

class FinalSignupscreen extends StatefulWidget {
  static const routeName = '/finalstep';
  @override
  State<FinalSignupscreen> createState() => _FinalSignupscreenState();
}

class _FinalSignupscreenState extends State<FinalSignupscreen> {
  File _image;
  String nicFName, nicBName;
  var pickedImage, NicFront, NicBack;

  void selectFile() async {
    final picker = ImagePicker();
    try {
      pickedImage = await picker.getImage(source: ImageSource.gallery);
      setState(() {
        if (pickedImage != null) {
          _image = File(pickedImage.path);
        } else {
          print('No image selected.');
        }
      });
    } on PlatformException catch (e, s) {
    } on Exception catch (e, s) {}
  }

  void captureNicFront() async {
    final picker = ImagePicker();
    try {
      NicFront = await picker.getImage(source: ImageSource.gallery);
      setState(() {
        if (NicFront != null) {
          nicFName = basename(NicFront.path);
          Fluttertoast.showToast(
              msg: 'NIC Selected',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.blue,
              textColor: Colors.white,
              fontSize: 16.0);
        } else {
          print('No image selected.');
        }
      });
    } on PlatformException catch (e, s) {
    } on Exception catch (e, s) {}
  }

  void captureNicBack() async {
    final picker = ImagePicker();
    try {
      NicBack = await picker.getImage(source: ImageSource.gallery);
      setState(() {
        if (NicBack != null) {
          Fluttertoast.showToast(
              msg: 'NIC Selected',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.blue,
              textColor: Colors.white,
              fontSize: 16.0);
          nicBName = basename(NicBack.path);
        } else {
          print('No image selected.');
        }
      });
    } on PlatformException catch (e, s) {
    } on Exception catch (e, s) {}
  }

  Future<CloudinaryResponse> prepareUpload() async {
    CloudinaryResponse response;
    if (pickedImage != null) {
      if (pickedImage.path != null) {
        response = await uploadFileOnCloudinary(
          filePath: pickedImage.path,
          resourceType: CloudinaryResourceType.image,
        );
        data.add(response.url);
      }
    }
    return response;
  }

  Future<CloudinaryResponse> prepareUploadNicFront() async {
    CloudinaryResponse response;
    if (NicFront != null) {
      if (NicFront.path != null) {
        response = await uploadNicFrontDataOnMongo(
          filePath: NicFront.path,
          resourceType: CloudinaryResourceType.image,
        );
        data.add(response.url);
      }
    }
    return response;
  }

  Future<CloudinaryResponse> prepareUploadNicBack() async {
    CloudinaryResponse response;
    if (NicBack != null) {
      if (NicBack.path != null) {
        response = await uploadNicBackDataOnMongo(
          filePath: NicBack.path,
          resourceType: CloudinaryResourceType.image,
        );
        data.add(response.url);
      }
    }
    return response;
  }

  Future<CloudinaryResponse> uploadFileOnCloudinary(
      {String filePath, CloudinaryResourceType resourceType}) async {
    CloudinaryResponse response;
    var cloudinary = Cloudinary.signedConfig(
        apiKey: '461133995855746',
        apiSecret: '-QpKX775LFGsnxH4csUfswOTQl4',
        cloudName: 'projecthandyman');
    response = await cloudinary.upload(
      file: filePath,
      fileBytes: _image.readAsBytesSync(),
      resourceType: CloudinaryResourceType.image,
      folder: 'profile images',
      fileName: data[1],
      // progressCallback: (count, total) {
      //   print('Uploading image from file with progress: $count/$total');
      // },
    );
    return response;
  }

  Future<CloudinaryResponse> uploadNicBackDataOnMongo(
      {String filePath, CloudinaryResourceType resourceType}) async {
    CloudinaryResponse response;
    var cloudinary = Cloudinary.signedConfig(
        apiKey: '461133995855746',
        apiSecret: '-QpKX775LFGsnxH4csUfswOTQl4',
        cloudName: 'projecthandyman');
    response = await cloudinary.upload(
      file: filePath,
      fileBytes: File(NicBack.path).readAsBytesSync(),
      resourceType: CloudinaryResourceType.image,
      folder: 'nic images',
      fileName: data[1] + '_NICBACK',
      // progressCallback: (count, total) {
      //   print('Uploading image from file with progress: $count/$total');
      // },
    );
    return response;
  }

  Future<CloudinaryResponse> uploadNicFrontDataOnMongo(
      {String filePath, CloudinaryResourceType resourceType}) async {
    CloudinaryResponse response;
    var cloudinary = Cloudinary.signedConfig(
        apiKey: '461133995855746',
        apiSecret: '-QpKX775LFGsnxH4csUfswOTQl4',
        cloudName: 'projecthandyman');
    response = await cloudinary.upload(
      file: filePath,
      fileBytes: File(NicFront.path).readAsBytesSync(),
      resourceType: CloudinaryResourceType.image,
      folder: 'nic images',
      fileName: data[1] + '_NICFRONT',
      // progressCallback: (count, total) {
      //   print('Uploading image from file with progress: $count/$total');
      // },
    );
    return response;
  }

  // void uploadPropicDataOnMongo(email, url) {
  //   AuthService().uploadPropic(email, url).then((val) {
  //     if (val.data['success']) {
  //       print('Successfully Uploaded');
  //     }
  //   });
  // }

  // void uploadNicFrontDataOnMongo(email, url) {
  //   AuthService().uploadNicFront(email, url).then((val) {
  //     if (val.data['success']) {
  //       print('Successfully Uploaded');
  //     }
  //   });
  // }

  // void uploadNicBackDataOnMongo(email, url) {
  //   AuthService().uploadNicBack(email, url).then((val) {
  //     if (val.data['success']) {
  //       print('Successfully Uploaded');
  //     }
  //   });
  // }

  List data;
  String valueChooseJobType;
  List jobTypes = [
    'Mason',
    'Tile Fixer',
    'Carpenter',
    'Painter',
    'Plumber',
    'Electrician',
    'Landscaping',
    'Contractor',
    'Equipment Reparing',
    'Welding',
    'A/C',
    'Cushion Works',
    'Cleaners',
    'Mechanics',
    'CCTV Fixers',
    'Solar Panel Fixers',
    'Curtains',
    'Movers',
    'Pest Control'
  ];
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    void httpJob(AnimationController controller) async {
      controller.forward();
      await prepareUploadNicBack();
      await prepareUploadNicFront();
      await prepareUpload();

      await AuthService().addUserWorker(data).then((val) {
        if (val.data['success']) {
          Navigator.of(context).pushNamed(LoginScreen.routeName);

          Fluttertoast.showToast(
              msg: 'Successfully Registered',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Theme.of(context).buttonColor,
              textColor: Theme.of(context).shadowColor,
              fontSize: 16.0);
        }
      });
      controller.reset();
    }

    data = ModalRoute.of(context).settings.arguments as List;
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
                      Center(
                        child: GestureDetector(
                          child: CircleAvatar(
                            backgroundColor: Colors.grey,
                            backgroundImage:
                                _image == null ? null : FileImage(_image),
                            radius: 50,
                            child: _image == null
                                ? Center(
                                    child: Icon(
                                      Icons.person,
                                      color: Colors.white,
                                      size: 40,
                                    ),
                                  )
                                : null,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 120,
                        child: CircleAvatar(
                          radius: 20,
                          backgroundColor: Theme.of(context).buttonColor,
                          child: Center(
                            child: IconButton(
                              icon: Icon(Icons.camera_alt_rounded),
                              color: Theme.of(context).backgroundColor,
                              onPressed: (() {
                                selectFile();
                              }),
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
                          child: DropdownButtonFormField(
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.work,
                                color: Theme.of(context).buttonColor,
                              ),
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
                            icon: Icon(
                              Icons.arrow_drop_down,
                              color: Theme.of(context).buttonColor,
                            ),
                            hint: Text("Job Type",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16)),
                            dropdownColor: Theme.of(context).backgroundColor,
                            isExpanded: true,
                            style: TextStyle(color: Colors.white),
                            value: valueChooseJobType,
                            onChanged: (newValue) {
                              setState(() {
                                valueChooseJobType = newValue;
                              });
                            },
                            items: jobTypes.map((valueItem) {
                              return DropdownMenuItem(
                                  value: valueItem, child: Text(valueItem));
                            }).toList(),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: GestureDetector(
                            onTap: () => captureNicFront(),
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
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15, right: 15, top: 5),
                          child: GestureDetector(
                            onTap: () => captureNicBack(),
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
                    child: Container(
                      height: 46,
                      width: width,
                      decoration: BoxDecoration(
                        // color: Theme.of(context).buttonColor,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: ProgressButton(
                          color: Theme.of(context).buttonColor,
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          child: Text('Submit',
                              style: TextStyle(
                                  color: Theme.of(context).backgroundColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500)),
                          onPressed: (AnimationController controller) async {
                            data.add(valueChooseJobType);
                            await httpJob(controller);
                          }),
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
