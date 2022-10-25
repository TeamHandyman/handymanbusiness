import 'package:cloudinary/cloudinary.dart';
import 'package:flutter/material.dart';
import 'package:date_field/date_field.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:handyman/WorkerScreens/notifications.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'dart:ffi';
import 'dart:io';

import 'package:progress_indicator_button/progress_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../services/authservice.dart';

class QuotationScreen extends StatefulWidget {
  static const routeName = '/quotationscreen';

  @override
  State<QuotationScreen> createState() => _QuotationScreenState();
}

class _QuotationScreenState extends State<QuotationScreen> {
  final _form = GlobalKey<FormState>();
  var chooseRevenueMethod, revMethod, hourlyRate, estTotal, desc, imgUrl;
  List data;
  DateTime estDate;
  List revenueMethods = [
    'Contract basis',
    'Hourly rate',
  ];
  File _image;

  void httpJob(AnimationController controller) async {
    controller.forward();
    await prepareUpload();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    Map<String, dynamic> payload = Jwt.parseJwt(token);
    var name = payload['fName'] + ' ' + payload['lName'];

    // var msg = 'You recieved a quotation from ' + name;
    // await AuthService().sendPushNotification(data[3], msg);

    await AuthService().workerUpdateQuotation(data,name).then((val) {
      Fluttertoast.showToast(
          msg: "Quotation Sent",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: Theme.of(context).buttonColor,
          textColor: Colors.black,
          fontSize: 16.0);
      Navigator.of(context).pop();
    });
    controller.reset();
  }

  final picker = ImagePicker();
  var pickedImage;
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
      folder: 'quotation images',
      fileName: data[1],
      // progressCallback: (count, total) {
      //   print('Uploading image from file with progress: $count/$total');
      // },
    );
    return response;
  }

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context).settings.arguments as List;
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
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
              'Create Quotation',
              style: TextStyle(color: Colors.white, fontSize: 30),
            ),
          ),
          Form(
            key: _form,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    style: TextStyle(color: Colors.white),
                    enabled: false,
                    decoration: InputDecoration(
                      labelText: data[0],
                      fillColor: Colors.white,
                      labelStyle: TextStyle(color: Colors.white),
                      disabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Theme.of(context).shadowColor),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Theme.of(context).shadowColor),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: null,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter job title';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButtonFormField(
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Theme.of(context).shadowColor),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: Colors.white,
                    ),
                    hint: Text("Revenue method",
                        style: TextStyle(color: Colors.white, fontSize: 16)),
                    dropdownColor: Theme.of(context).backgroundColor,
                    isExpanded: true,
                    style: TextStyle(color: Colors.white),
                    value: chooseRevenueMethod,
                    onChanged: (newValue) {
                      setState(() {
                        chooseRevenueMethod = newValue;
                      });
                    },
                    items: revenueMethods.map((valueItem) {
                      return DropdownMenuItem(
                          value: valueItem, child: Text(valueItem));
                    }).toList(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: chooseRevenueMethod == revenueMethods[0]
                          ? 'Hourly rate not available in contract basis mode'
                          : 'Hourly Rate',
                      fillColor: Colors.white,
                      enabled: chooseRevenueMethod == revenueMethods[0]
                          ? false
                          : true,
                      labelStyle: TextStyle(
                          color: chooseRevenueMethod == revenueMethods[0]
                              ? Colors.white54
                              : Colors.white,
                          fontStyle: chooseRevenueMethod == revenueMethods[0]
                              ? FontStyle.italic
                              : FontStyle.normal),
                      disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white54),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Theme.of(context).shadowColor),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (val) {
                      hourlyRate = val;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: chooseRevenueMethod == revenueMethods[1]
                          ? 'Estimated total not available in hourly rate mode'
                          : 'Estimated Total',
                      labelStyle: TextStyle(
                          color: chooseRevenueMethod == revenueMethods[1]
                              ? Colors.white54
                              : Colors.white,
                          fontStyle: chooseRevenueMethod == revenueMethods[1]
                              ? FontStyle.italic
                              : FontStyle.normal),
                      enabled: chooseRevenueMethod == revenueMethods[1]
                          ? false
                          : true,
                      disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white54),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Theme.of(context).shadowColor),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    // maxLines: 5,
                    keyboardType: TextInputType.number,
                    onChanged: (val) {
                      estTotal = val;
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter a total';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Description',
                      labelStyle: TextStyle(color: Colors.white),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Theme.of(context).shadowColor),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    maxLines: 5,
                    keyboardType: TextInputType.multiline,
                    onChanged: ((value) {
                      desc = value;
                    }),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter a description';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DateTimeFormField(
                    dateTextStyle: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintStyle: TextStyle(color: Colors.white),
                      errorStyle: TextStyle(color: Colors.redAccent),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      suffixIcon: Icon(
                        Icons.event_note,
                        color: Colors.white,
                      ),

                      labelText: 'Estimated Completion Date',
                      labelStyle: TextStyle(color: Colors.white),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Theme.of(context).shadowColor),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      // enabledBorder: InputBorder(borderSide: )
                    ),
                    mode: DateTimeFieldPickerMode.date,
                    autovalidateMode: AutovalidateMode.always,
                    validator: (e) =>
                        (e?.day ?? 0) == 1 ? 'Please not the first day' : null,
                    onDateSelected: (DateTime value) {
                      estDate = value;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      selectFile();
                      Fluttertoast.showToast(
                          msg: "Tap and hold to remove image",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 3,
                          backgroundColor: Theme.of(context).buttonColor,
                          textColor: Colors.black,
                          fontSize: 16.0);
                    },
                    onLongPress: () {
                      setState(() {
                        _image = null;
                      });
                      Fluttertoast.showToast(
                          msg: "Image removed",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 3,
                          backgroundColor: Theme.of(context).buttonColor,
                          textColor: Colors.black,
                          fontSize: 16.0);
                    },
                    child: Container(
                      height: 200,
                      width: width,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(8),
                          image: _image != null
                              ? DecorationImage(
                                  image: FileImage(_image), fit: BoxFit.fill)
                              : null),
                      child: _image == null
                          ? Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.image,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    'Upload Image',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            )
                          : null,
                    ),
                  ),
                ),
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
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: ProgressButton(
                          color: Theme.of(context).buttonColor,
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          child: Text('Send Quotation',
                              style: TextStyle(
                                  color: Theme.of(context).backgroundColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500)),
                          onPressed: (AnimationController controller) async {
                            if (chooseRevenueMethod == "Hourly rate") {
                              data.addAll([
                                chooseRevenueMethod,
                                hourlyRate,
                                desc,
                                estDate
                              ]);
                            } else {
                              data.addAll([
                                chooseRevenueMethod,
                                estTotal,
                                desc,
                                estDate
                              ]);
                            }

                            await httpJob(controller);
                          }),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      )),
    );
  }
}
