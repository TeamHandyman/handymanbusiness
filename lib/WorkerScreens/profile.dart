import 'dart:ffi';
import 'dart:io';
import 'package:cloudinary/cloudinary.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:handyman/Onboarding/login.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:progress_indicator_button/progress_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/authservice.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<File> _image = [];
  List<String> imageUrls = [];
  final _form = GlobalKey<FormState>();
  List<String> _services = [];
  var pickedImage;
  final picker = ImagePicker();
  File _storedImage;
  var _isSelected = false;
  var selectedImg = -2;
  String temp;
  var servicestr;
  var editedstr;
  String url;
  var email;
  var _clicked = false;

  var name, district, proPic;

  void httpJob(AnimationController controller) async {
    controller.forward();
    await prepareUpload();
    if (imageUrls.length < 5) {
      while (imageUrls.length < 5) {
        imageUrls.add("");
      }
    }
    await AuthService().workerPortfolio(email, imageUrls).then((val) {
      Fluttertoast.showToast(
          msg: "Saved Successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: Theme.of(context).buttonColor,
          textColor: Colors.black,
          fontSize: 16.0);
    });
    controller.reset();
  }

  void _takePicture() async {
    final _pickedImage = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _image.add(File(_pickedImage.path));

      Fluttertoast.showToast(
          msg: "Drag down to remove image",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Theme.of(context).buttonColor,
          textColor: Colors.black,
          fontSize: 16.0);
    });
    //if (_pickedImage.path == null) retrieveLostData();
  }

  void _addService(String str) async {
    setState(() {
      _services.add(str);
      Fluttertoast.showToast(
          msg: "Tap and hold to remove image",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Theme.of(context).buttonColor,
          textColor: Colors.black,
          fontSize: 16.0);
    });
    //if (_pickedImage.path == null) retrieveLostData();
  }

  void _remove(int index) {
    setState(() {
      _image.removeAt(index);
      _isSelected = false;
    });
  }

  void _removeService(int index) {
    setState(() {
      _image.removeAt(index);
    });
  }

  void _saveForm() {
    _form.currentState.save();
  }

  Future<CloudinaryResponse> prepareUpload() async {
    CloudinaryResponse response;
    if (_image.length > 0) {
      for (var i = 0; i < _image.length; i++) {
        response = await uploadFileOnCloudinary(
          image: _image[i],
          filePath: _image[i].path,
          resourceType: CloudinaryResourceType.image,
        );
        url = response.url;
        print(url);
        imageUrls.add(url);
      }
    }
    return response;
  }

  Future<CloudinaryResponse> uploadFileOnCloudinary(
      {File image,
      String filePath,
      CloudinaryResourceType resourceType}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    Map<String, dynamic> payload = Jwt.parseJwt(token);
    email = payload['email'];
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // var token = prefs.getString('token');

    CloudinaryResponse response;
    var cloudinary = Cloudinary.signedConfig(
        apiKey: '461133995855746',
        apiSecret: '-QpKX775LFGsnxH4csUfswOTQl4',
        cloudName: 'projecthandyman');

    response = await cloudinary.upload(
      file: filePath,
      fileBytes: image.readAsBytesSync(),
      resourceType: CloudinaryResourceType.image,
      folder: 'worker portfolio images/$email',
      // progressCallback: (count, total) {
      //   print('Uploading image from file with progress: $count/$total');
      // },
    );
    return response;
  }

  @override
  void getDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    Map<String, dynamic> payload = Jwt.parseJwt(token);
    name = payload['fName'] + ' ' + payload['lName'];
    district = payload['district'];
    // proPic =
    // "https://res.cloudinary.com/projecthandyman/image/upload/v1666765606/WhatsApp_Image_2022-10-26_at_9.23.20_AM_c0kj5k.jpg";
  }

  // void initState() {
  //   super.initState();
  //   getDetails();
  // }

  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    Widget editText(BuildContext context) {
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
                      labelText: 'Write about your advertisement here...',
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

    Widget addNewService(BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15))),
        child: Container(
          margin: EdgeInsets.all(7),
          padding: EdgeInsets.all(7),
          width: width,
          height: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Form(
            key: _form,
            child: ListView(
              children: <Widget>[
                TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Type a service',
                    ),
                    textInputAction: TextInputAction.next,
                    onSaved: (newValue) {
                      setState(() {
                        servicestr = newValue;
                      });
                    }),
                SizedBox(
                  height: 5,
                ),
                GestureDetector(
                  onTap: () {
                    _saveForm();
                    _addService(servicestr);
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
                        'Add service',
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

    Widget imgalertDialog(BuildContext context, int i) {
      return AlertDialog(
        title: const Text('Are you sure want to delete?'),
        // content: SingleChildScrollView(
        //   child: ListBody(
        //     children: const <Widget>[
        //       Text('This is a demo alert dialog.'),
        //       Text('Would you like to approve of this message?'),
        //     ],
        //   ),
        // ),
        actions: <Widget>[
          TextButton(
            child: const Text('Yes'),
            onPressed: () {
              setState(() {
                _image.removeAt(i);
                Navigator.of(context).pop();
              });
            },
          ),
          TextButton(
            child: const Text('No'),
            onPressed: () {
              setState(() {
                // _services.removeAt(i);
                Navigator.of(context).pop();
              });
            },
          ),
        ],
      );
    }

    Widget alertDialog(BuildContext context, int i) {
      return AlertDialog(
        title: const Text('Are you sure want to delete?'),
        // content: SingleChildScrollView(
        //   child: ListBody(
        //     children: const <Widget>[
        //       Text('This is a demo alert dialog.'),
        //       Text('Would you like to approve of this message?'),
        //     ],
        //   ),
        // ),
        actions: <Widget>[
          TextButton(
            child: const Text('Yes'),
            onPressed: () {
              setState(() {
                _services.removeAt(i);
                Navigator.of(context).pop();
              });
            },
          ),
          TextButton(
            child: const Text('No'),
            onPressed: () {
              setState(() {
                // _services.removeAt(i);
                Navigator.of(context).pop();
              });
            },
          ),
        ],
      );
    }

    Widget otherServices(BuildContext context) {
      return Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 15),
        child: Container(
            height: 40,
            width: width * 0.95,
            // decoration: BoxDecoration(
            //   border: Border.all(color: Colors.white),
            //   borderRadius: BorderRadius.circular(8),
            // ),
            child: ListView.builder(
              itemCount: _services.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (ctx, i) => InkWell(
                onLongPress: () {
                  showDialog(
                      context: context,
                      builder: (context) => alertDialog(context, i));
                },
                child: !_services.isEmpty
                    ? Container(
                        height: 30,
                        width: 180,
                        margin: EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Color.fromRGBO(255, 255, 255, 0.6),
                        ),
                        child: Center(
                          child: Text(
                            _services[i],
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                        ),
                      )
                    : Center(
                        child: Text(
                          'No services added',
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                      ),
              ),
            )),
      );
    }

    Widget coverImage(BuildContext context, int i, bool isSelected) {
      return Padding(
        padding:
            const EdgeInsets.only(left: 15.0, right: 15, top: 15, bottom: 3),
        child: Container(
          height: height * 0.4,
          width: width,
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
            borderRadius: BorderRadius.circular(5),
          ),
          child: !_image.isEmpty
              ? Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      image: !isSelected
                          ? FileImage(_image[0])
                          : FileImage(_image[i]),
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              : Container(
                  height: height * 0.4,
                  width: width,
                  color: Colors.grey[400],
                  child: Center(
                    child: Icon(
                      Icons.image_not_supported,
                      color: Colors.black45,
                      size: 100,
                    ),
                  ),
                ),
        ),
      );
    }

    Widget imageTile(BuildContext context, String image) {
      return Padding(
        padding: const EdgeInsets.all(3.0),
        child: Container(
          height: 80,
          width: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Theme.of(context).shadowColor,
          ),
          child: Container(
            decoration: const BoxDecoration(
                // image: DecorationImage(
                //   image: AssetImage('assets/images/portfolio2.jpeg'),
                //   fit: BoxFit.fill,
                // ),
                ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5.0),
              child: Image.asset(
                'assets/images/${image}.jpeg',
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
      );
    }

    // Widget imageSlider(BuildContext context) {
    //   return Padding(
    //     padding: const EdgeInsets.only(left: 15.0, right: 15),
    //     child: Container(
    //       height: 80,
    //       width: double.infinity,
    //       decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
    //       child: ListView(
    //         scrollDirection: Axis.horizontal,
    //         children: [
    //           imageTile(context, 'portfolio2'),
    //           imageTile(context, 'portfolio3'),
    //         ],
    //       ),
    //     ),
    //   );
    // }

    Widget imageSlider(BuildContext context) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 100,
                  width: width * 0.95,
                  // decoration: BoxDecoration(
                  //   border: Border.all(color: Colors.white),
                  //   borderRadius: BorderRadius.circular(8),
                  // ),
                  child: ListView.builder(
                      itemCount: _image.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (ctx, i) => Dismissible(
                            key: Key(_image[i].toString()),
                            direction: DismissDirection.down,
                            onDismissed: (DismissDirection direction) {
                              showDialog(
                                  context: context,
                                  builder: (context) =>
                                      imgalertDialog(context, i));
                            },
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _isSelected = true;
                                  selectedImg = i;
                                });
                              },
                              child: Container(
                                height: 120,
                                width: 90,
                                margin: EdgeInsets.all(3),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  image: DecorationImage(
                                    image: FileImage(_image[i]),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          )

                      // MyPhotos(
                      //   photos[i].id,
                      //   photos[i].imagestr,
                      // ),
                      ),
                ),
              ],
            ),
            if (_image.length < 5)
              Positioned(
                right: 0,
                top: 40,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    child: GestureDetector(
                      onTap: () {
                        _takePicture();
                        _clicked = true;
                      },
                      child: Icon(
                        Icons.add_a_photo,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            if (_image.length < 1)
              Positioned(
                top: 60,
                left: 10,
                child: Center(
                    child: Text(
                  'No photos added',
                  style: TextStyle(color: Colors.white54),
                )),
              ),
          ],
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
          // _clicked
          //     ? IconButton(
          //         icon: Icon(
          //           Icons.check,
          //           color: Theme.of(context).buttonColor,
          //         ),
          //         onPressed: () {
          //           prepareUpload();

          //           AuthService().workerPortfolio(email, imageUrls).then((val) {
          //             Fluttertoast.showToast(
          //                 msg: "Quotation Sent",
          //                 toastLength: Toast.LENGTH_SHORT,
          //                 gravity: ToastGravity.BOTTOM,
          //                 timeInSecForIosWeb: 3,
          //                 backgroundColor: Theme.of(context).buttonColor,
          //                 textColor: Colors.black,
          //                 fontSize: 16.0);
          //             // Navigator.of(context).pop();
          //           });
          //         })
          //     : Text(''),
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
                    'Portfolio',
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        fontSize: 40),
                    textAlign: TextAlign.start,
                  ),
                ),
              ],
            ),
            coverImage(context, selectedImg, _isSelected),
            Divider(color: Colors.white54, indent: 25, endIndent: 25),
            imageSlider(context),
            Padding(
              padding: const EdgeInsets.only(
                top: 20.0,
                bottom: 10,
                left: 15,
                right: 15,
              ),
              child: _clicked
                  ? GestureDetector(
                      child: Container(
                        height: 46,
                        width: width * 0.5,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: ProgressButton(
                            color: Theme.of(context).buttonColor,
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            child: Text('Save',
                                style: TextStyle(
                                    color: Theme.of(context).backgroundColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500)),
                            onPressed: (AnimationController controller) async {
                              await httpJob(controller);
                            }),
                      ),
                    )
                  : Center(
                      child: Text(''),
                    ),
            ),
            Container(
              width: width,
              height: 130,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'About the advertisment',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                        Spacer(),
                        IconButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) => editText(context));
                            },
                            icon: Icon(
                              Icons.edit,
                              color: Colors.white,
                            ))
                      ],
                    ),
                    editedstr == null
                        ? Text(
                            '',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          )
                        : Text(
                            editedstr,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                  ],
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 15, right: 15, top: 3, bottom: 3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Services Provided',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  Spacer(),
                  IconButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) => addNewService(context));
                        _clicked = true;
                      },
                      icon: Icon(
                        Icons.my_library_add_outlined,
                        color: Colors.white,
                      )),
                ],
              ),
            ),
            otherServices(context),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15, top: 3, bottom: 3),
              child: Container(
                width: width,
                height: 150,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 45,
                      backgroundColor: Theme.of(context).shadowColor,
                      backgroundImage: NetworkImage(
                          "https://res.cloudinary.com/projecthandyman/image/upload/v1666765606/WhatsApp_Image_2022-10-26_at_9.23.20_AM_c0kj5k.jpg"),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 25.0, left: 15, right: 15, bottom: 25),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Deelaka Kumara',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.star,
                                size: 20,
                                color: Theme.of(context).buttonColor,
                              ),
                              Icon(
                                Icons.star,
                                size: 20,
                                color: Theme.of(context).buttonColor,
                              ),
                              Icon(
                                Icons.star,
                                size: 20,
                                color: Theme.of(context).buttonColor,
                              ),
                              Icon(
                                Icons.star,
                                size: 20,
                                color: Theme.of(context).buttonColor,
                              ),
                              Icon(
                                Icons.star,
                                size: 20,
                                color: Theme.of(context).buttonColor,
                              ),
                            ],
                          ),
                          Text(
                            'From Gampaha',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
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
                      color: Theme.of(context).backgroundColor,
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      child: Text('Log Out',
                          style: TextStyle(
                              color: Theme.of(context).buttonColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w500)),
                      onPressed: (AnimationController controller) async {
                        SharedPreferences preferences =
                            await SharedPreferences.getInstance();
                        await preferences.clear();
                        Navigator.of(context).pushNamed(LoginScreen.routeName);
                      }),
                ),
              ),
            ),

            // Padding(
            //   padding: const EdgeInsets.only(
            //       left: 15.0, right: 15, top: 5, bottom: 5),
            //   child: Container(
            //     width: width,
            //     height: 100,
            //     child: Padding(
            //       padding: const EdgeInsets.all(8.0),
            //       child: Text(
            //         'This is the bio of the handyman. You can tell about your work experience and everything about you',
            //         style: TextStyle(color: Colors.white),
            //       ),
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
