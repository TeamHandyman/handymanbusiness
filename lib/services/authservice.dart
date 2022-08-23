import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthService {
  Dio dio = new Dio();

  addUserWorker(data) async {
    try {
      return await dio.post('https://projecthandyman.herokuapp.com/addWorker',
          data: {
            "fName": data[3],
            "lName": data[4],
            "phone": data[0],
            "email": data[1],
            "password": data[2],
            "gender": data[5],
            "district": data[6],
            "city": data[7],
            "jobType": data[8],
          },
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } on DioError catch (e) {
      Fluttertoast.showToast(
          msg: e.response.data['msg'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  loginWorker(email, password) async {
    try {
      return await dio.post(
          'https://projecthandyman.herokuapp.com/loginCustomer',
          data: {"email": email, "password": password, "userType": "worker"},
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } on DioError catch (e) {
      Fluttertoast.showToast(
          msg: e.response.data['msg'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  checkEmailAvailability(email, userType) async {
    try {
      return await dio.post(
          'https://projecthandyman.herokuapp.com/checkEmailAvailability',
          data: {"email": email, "userType": userType});
    } on DioError catch (e) {
      Fluttertoast.showToast(
          msg: e.response.data['msg'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  checkPhoneAvailability(phone, userType) async {
    try {
      return await dio.post(
          'https://projecthandyman.herokuapp.com/checkPhoneAvailability',
          data: {"phone": phone, "userType": userType});
    } on DioError catch (e) {
      Fluttertoast.showToast(
          msg: e.response.data['msg'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  uploadPropic(email, url) async {
    try {
      return await dio.post(
        'https://projecthandyman.herokuapp.com/uploadProPic',
        data: {
          "email": email,
          "url": url,
        },
      );
    } on DioError catch (e) {
      Fluttertoast.showToast(
          msg: e.response.data['msg'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  uploadNicFront(email, url) async {
    try {
      return await dio.post(
        'https://projecthandyman.herokuapp.com/uploadNicFront',
        data: {
          "email": email,
          "url": url,
        },
      );
    } on DioError catch (e) {
      Fluttertoast.showToast(
          msg: e.response.data['msg'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  uploadNicBack(email, url) async {
    try {
      return await dio.post(
        'https://projecthandyman.herokuapp.com/uploadNicBack',
        data: {
          "email": email,
          "url": url,
        },
      );
    } on DioError catch (e) {
      Fluttertoast.showToast(
          msg: e.response.data['msg'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  getCustomerAds(searchTerm) async {
    try {
      return await dio.get(
          'https://projecthandyman.herokuapp.com/getCustomerAds?term=$searchTerm');
    } on DioError catch (e) {
      Fluttertoast.showToast(
          msg: e.response.data['msg'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }
}
