import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthService {
  Dio dio = new Dio();

  addUserWorker(data) async {
    try {
      var data0 = {
        "fName": data[3],
        "lName": data[4],
        "phone": data[0],
        "email": data[1],
        "password": data[2],
        "gender": data[5],
        "district": data[6],
        "city": data[7],
        "jobType": data[8],
        "nicBackUrl": data[9],
        "nicFrontUrl": data[10],
      };
      if (data.length == 12) {
        data0["proPicUrl"] = data[11];
      }
      return await dio.post('https://projecthandyman.herokuapp.com/addWorker',
          data: data0,
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

  workerPortfolio(email, imageUrls) async {
    try {
      return await dio.post(
          'https://projecthandyman.herokuapp.com/workerPortfolio',
          data: {
            "email": email,
            "url1": imageUrls[0],
            "url2": imageUrls[1],
            "url3": imageUrls[2],
            "url4": imageUrls[3],
            "url5": imageUrls[4],
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

  workerUpdateQuotation(data, name) async {
    try {
      return await dio.post(
        'https://projecthandyman.herokuapp.com/workerUpdateQuotation',
        data: {
          "id": data[1],
          "revenueMethod": data[2],
          "rateOrTotal": data[3],
          "description": data[4],
          "estimatedDate": data[5].toString(),
          "imgUrl": data[6],
          "workerName": name
        },
      );
    } on DioError catch (e) {
      print(e.toString());
    }
  }

  updateWorkerAdDesc(desc, email) async {
    try {
      return await dio.post(
        'https://projecthandyman.herokuapp.com/updateWorkerAdDesc',
        data: {
          "desc": desc,
          "email": email,
        },
      );
    } on DioError catch (e) {
      print(e.toString());
    }
  }

  updateWorkerAdImg(url, email) async {
    try {
      return await dio.post(
        'https://projecthandyman.herokuapp.com/updateWorkerAdImg',
        data: {
          "url": url,
          "email": email,
        },
      );
    } on DioError catch (e) {
      print(e.toString());
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

  sendPushNotification(id, msg) async {
    try {
      return await dio.get(
          'https://projecthandyman.herokuapp.com/sendPushNotification',
          queryParameters: {'device': id, 'msg': msg});
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

  acceptCustomerJob(id, email) async {
    try {
      return await dio.post(
        'https://projecthandyman.herokuapp.com/acceptCustomerJob',
        data: {
          "id": id,
          "email": email,
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

  getAcceptedStateCustomerJob(id) async {
    try {
      return await dio.post(
        'https://projecthandyman.herokuapp.com/getAcceptedStateCustomerJob',
        data: {
          "id": id,
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

  getWorkerNotificationsForQuotationRequests(email) async {
    try {
      return await dio.get(
          'https://projecthandyman.herokuapp.com/getWorkerNotificationsForQuotationRequests?email=$email');
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

  // getCustomerJobStatus(id) async {
  //   try {
  //     return await dio.post(
  //       'https://projecthandyman.herokuapp.com/getCustomerJobStatus',
  //       data: {
  //         "id": id,
  //       },
  //     );
  //   } on DioError catch (e) {
  //     Fluttertoast.showToast(
  //         msg: e.response.data['msg'],
  //         toastLength: Toast.LENGTH_SHORT,
  //         gravity: ToastGravity.BOTTOM,
  //         backgroundColor: Colors.red,
  //         textColor: Colors.white,
  //         fontSize: 16.0);
  //   }
  // }

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

  getConfirmedQuotationsWorker(email) async {
    try {
      return await dio.get(
          'https://projecthandyman.herokuapp.com/getConfirmedQuotationsWorker?email=$email');
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

  getInfo(email) async {
    try {
      return await dio
          .get('https://projecthandyman.herokuapp.com/getInfo?email=$email');
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
