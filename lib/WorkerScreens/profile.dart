import 'dart:ffi';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<File> _image = [];
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

  @override
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
          IconButton(icon: Icon(Icons.more_vert), onPressed: () {}),
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
                      backgroundImage: AssetImage('assets/images/profile.png'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 25.0, left: 15, right: 15, bottom: 25),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Saul Goodman',
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
                          Text(
                            'Member since 2020',
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
                  left: 15.0, right: 15, top: 5, bottom: 5),
              child: Container(
                width: width,
                height: 100,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'This is the bio of the handyman. You can tell about your work experience and everything about you',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
