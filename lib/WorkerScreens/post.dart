import 'package:cloudinary/cloudinary.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:handyman/services/authservice.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'dart:ffi';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

class PostScreen extends StatefulWidget {
  static const routeName = '/postscreen';

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final _form = GlobalKey<FormState>();
  var editedstr, desc = "Add a description...", imgUrl;
  File _image;
  List data = [];
  var _clicked = false;

  void _saveForm() async {
    _form.currentState.save();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    Map<String, dynamic> payload = Jwt.parseJwt(token);
    var email = payload['email'];
    prefs.setString('workerAdDesc', editedstr);
    await AuthService().updateWorkerAdDesc(editedstr, email).then((val) {
      Fluttertoast.showToast(
          msg: "Description Changed",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: Theme.of(context).buttonColor,
          textColor: Colors.black,
          fontSize: 16.0);
    });
  }

  void getDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    imgUrl = prefs.getString('workerAdImgUrl');
    desc = prefs.getString('workerAdDesc');

    setState(() {});
  }

  void initState() {
    super.initState();
    getDetails();
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
          prepareUpload();
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
        SharedPreferences prefs = await SharedPreferences.getInstance();
        var token = prefs.getString('token');
        Map<String, dynamic> payload = Jwt.parseJwt(token);
        var email = payload['email'];
        prefs.setString('workerAdImgUrl', response.url);
        await AuthService().updateWorkerAdImg(response.url, email).then((val) {
          Fluttertoast.showToast(
              msg: "Image Changed",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 3,
              backgroundColor: Theme.of(context).buttonColor,
              textColor: Colors.black,
              fontSize: 16.0);
        });
      }
    }
    return response;
  }

  Future<CloudinaryResponse> uploadFileOnCloudinary(
      {String filePath, CloudinaryResourceType resourceType}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    Map<String, dynamic> payload = Jwt.parseJwt(token);
    var email = payload['email'];
    CloudinaryResponse response;
    var cloudinary = Cloudinary.signedConfig(
        apiKey: '461133995855746',
        apiSecret: '-QpKX775LFGsnxH4csUfswOTQl4',
        cloudName: 'projecthandyman');
    response = await cloudinary.upload(
      file: filePath,
      fileBytes: _image.readAsBytesSync(),
      resourceType: CloudinaryResourceType.image,
      folder: 'worker ad images',
      fileName: email + ' adPhoto',
    );
    return response;
  }

  void _reOpen() async {}

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    Widget editAd(BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15))),
        child: Container(
          margin: EdgeInsets.all(7),
          padding: EdgeInsets.all(7),
          width: width,
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Form(
            key: _form,
            child: ListView(
              children: <Widget>[
                TextFormField(
                    maxLines: 5,
                    decoration: InputDecoration(
                      labelText: 'Write a description...',
                    ),
                    textInputAction: TextInputAction.next,
                    onSaved: (newValue) {
                      setState(() {
                        editedstr = newValue;
                      });
                    }),
                SizedBox(
                  height: 5,
                ),
                GestureDetector(
                  onTap: () {
                    _saveForm();

                    Navigator.of(context).pop();
                  },
                  child: Container(
                    height: 46,
                    width: width * 0.7,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      // color: Theme.of(context).buttonColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(
                      child: Text(
                        'Save',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
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
          IconButton(icon: Icon(Icons.more_vert), onPressed: () {}),
        ],
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 10.0, bottom: 0, left: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Create Ads',
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
              padding: EdgeInsets.only(top: 3.0, bottom: 0, left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Flexible(
                    child: Text(
                      'You can create/edit your ads that will be posted by Handyman team',
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
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('+ Add  Advertisement',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).buttonColor,
                      fontSize: 14,
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                width: width,
                height: height * 0.55,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                        onLongPress: () {
                          setState(() {
                            _image = null;
                            Fluttertoast.showToast(
                                msg: "Image removed",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 3,
                                backgroundColor: Theme.of(context).buttonColor,
                                textColor: Colors.black,
                                fontSize: 16.0);
                          });
                        },
                        child: _image != null
                            ? Container(
                                height: 250,
                                width: width,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Theme.of(context).shadowColor,
                                  image: DecorationImage(
                                      image: FileImage(_image),
                                      fit: BoxFit.fill),
                                ),
                              )
                            : imgUrl == null
                                ? Container(
                                    height: 250,
                                    width: width,
                                    color: Colors.grey[400],
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Center(
                                          child: Icon(
                                        Icons.image_not_supported_rounded,
                                        size: 100,
                                        color: Colors.black45,
                                      )),
                                    ),
                                  )
                                : Container(
                                    height: 250,
                                    width: width,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Theme.of(context).shadowColor,
                                      image: DecorationImage(
                                          image: NetworkImage(imgUrl),
                                          fit: BoxFit.fill),
                                    ),
                                  )),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        editedstr == null ? desc : editedstr,
                        style: TextStyle(color: Colors.black),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Jobs completed: 10',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: Theme.of(context).buttonColor,
                              size: 15,
                            ),
                            Text(
                              '4.7',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ],
                    ),
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: GestureDetector(
                            onTap: () {
                              selectFile();
                            },
                            child: Row(
                              children: [
                                Icon(
                                  Icons.image,
                                  color: Theme.of(context).buttonColor,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  'Edit Image',
                                  style: TextStyle(
                                      color: Theme.of(context).buttonColor,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: GestureDetector(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (context) => editAd(context));
                            },
                            child: Row(
                              children: [
                                Icon(
                                  Icons.edit,
                                  color: Theme.of(context).buttonColor,
                                ),
                                Text(
                                  'Edit Description',
                                  style: TextStyle(
                                      color: Theme.of(context).buttonColor,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
