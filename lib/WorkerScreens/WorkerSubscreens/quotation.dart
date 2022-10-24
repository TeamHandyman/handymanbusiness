import 'package:flutter/material.dart';
import 'package:date_field/date_field.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:ffi';
import 'dart:io';

class QuotationScreen extends StatefulWidget {
  static const routeName = '/quotationscreen';

  @override
  State<QuotationScreen> createState() => _QuotationScreenState();
}

class _QuotationScreenState extends State<QuotationScreen> {
  final _form = GlobalKey<FormState>();
  var chooseRevenueMethod;
  List revenueMethods = [
    'Contract basis',
    'Hourly rate',
  ];
  File _image;
  DateTime date;
  final picker = ImagePicker();

  void _takePicture() async {
    final _pickedImage = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _image = File(_pickedImage.path);
    });
    //if (_pickedImage.path == null) retrieveLostData();
  }

  @override
  Widget build(BuildContext context) {
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
                      labelText: 'Mechanic job| Nugegoda | Kamal ',
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
                        print('choose');

                        print(chooseRevenueMethod);
                        print('Method');
                        print(revenueMethods[1]);
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
                          : 'Hourly rate',
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
                  child: TextFormField(
                    style: TextStyle(color: Colors.white),
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

                      enabled: false,
                      labelText: DateTime.now().toString(),
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
                      // enabledBorder: InputBorder(borderSide: )
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Estimated total',
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
                    keyboardType: TextInputType.number,
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
                  child: GestureDetector(
                    onTap: () {
                      _takePicture();
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Container(
                    height: 46,
                    width: width,
                    decoration: BoxDecoration(
                      color: Theme.of(context).buttonColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(
                      child: Text('Send quotation',
                          style: TextStyle(
                              color: Theme.of(context).backgroundColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w500)),
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
