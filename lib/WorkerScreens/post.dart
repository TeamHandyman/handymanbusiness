import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:ffi';
import 'dart:io';

class PostScreen extends StatefulWidget {
  static const routeName = '/postscreen';

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final _form = GlobalKey<FormState>();
  var editedstr;
  File _image;
  final picker = ImagePicker();
  var _clicked = false;

  void _saveForm() {
    _form.currentState.save();
  }

  void _takePicture() async {
    final _pickedImage = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _image = File(_pickedImage.path);
      print('image picked');
      print(_image);
    });
    //if (_pickedImage.path == null) retrieveLostData();
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
      // return Container(
      //   width: width * 0.9,
      //   // color: Theme.of(context).shadowColor,
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     crossAxisAlignment: CrossAxisAlignment.center,
      //     children: [
      //       Container(
      //         height: height * 0.3,
      //         width: width * 0.8,
      //         decoration: BoxDecoration(
      //           borderRadius: BorderRadius.circular(15),
      //           image: DecorationImage(
      //               image: AssetImage('assets/images/ad.jpg'),
      //               fit: BoxFit.fill),
      //         ),
      //       ),
      //       // Align(
      //       //   alignment: Alignment.bottomLeft,
      //       //   child: FloatingActionButton(
      //       //     backgroundColor: Theme.of(context).buttonColor,
      //       //     child: IconButton(
      //       //         onPressed: null,
      //       //         icon: Icon(Icons.photo_size_select_actual_rounded)),
      //       //   ),
      //       // ),

      //       Container(
      //         width: width * 0.8,
      //         height: 200,
      //         color: Colors.white,
      //         child: Column(
      //           children: [
      //             TextButton.icon(
      //                 onPressed: null,
      //                 icon: Icon(
      //                   Icons.photo_size_select_actual_rounded,
      //                   color: Theme.of(context).buttonColor,
      //                 ),
      //                 label: Text(
      //                   'Change picture',
      //                   style: TextStyle(
      //                       color: Theme.of(context).buttonColor,
      //                       fontWeight: FontWeight.bold),
      //                 )),
      //             Center(
      //               child: Form(
      //                 key: _form,
      //                 child: ListView(
      //                   children: <Widget>[
      //                     TextFormField(
      //                         decoration: InputDecoration(
      //                           labelText: 'Click to edit your text',
      //                         ),
      //                         textInputAction: TextInputAction.next,
      //                         onSaved: (newValue) {
      //                           setState(() {
      //                             editedstr = newValue;
      //                           });
      //                         }),
      //                     SizedBox(
      //                       height: 5,
      //                     ),
      //                     GestureDetector(
      //                       onTap: () {
      //                         _saveForm();

      //                         Navigator.of(context).pop();
      //                       },
      //                       child: Container(
      //                         height: 46,
      //                         width: width * 0.7,
      //                         decoration: BoxDecoration(
      //                           color: Colors.black,
      //                           // color: Theme.of(context).buttonColor,
      //                           borderRadius: BorderRadius.circular(5),
      //                         ),
      //                         child: Center(
      //                           child: Text(
      //                             'Save',
      //                             style: TextStyle(
      //                                 color: Colors.white,
      //                                 fontWeight: FontWeight.bold),
      //                           ),
      //                         ),
      //                       ),
      //                     ),
      //                   ],
      //                 ),
      //               ),
      //             ),
      //           ],
      //         ),
      //       ),
      //     ],
      //   ),
      // );
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
                                    image: FileImage(_image), fit: BoxFit.fill),
                              ),
                            )
                          : Container(
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
                            ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        editedstr == null ? 'Add a description...' : editedstr,
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
                              _takePicture();
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
