import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:handyman/WorkerScreens/WorkerSubscreens/quotation.dart';
import 'package:handyman/WorkerScreens/WorkerSubscreens/quotationview.dart';

import 'package:progress_indicator_button/progress_button.dart';
import 'dart:async';

class ConfirmedJobsScreen extends StatefulWidget {
  static const routeName = '/confiremdjobsscreen';

  @override
  State<ConfirmedJobsScreen> createState() => _ConfirmedJobsScreenState();
}

class _ConfirmedJobsScreenState extends State<ConfirmedJobsScreen> {
  bool flag = true;
  Stream<int> timerStream;
  StreamSubscription<int> timerSubscription;
  String hoursStr = '00';
  String minutesStr = '00';
  String secondsStr = '00';
  var _paused = false;
  var _started = false;
  var _finished = false;
  double rating = 0;

  Stream<int> stopWatchStream() {
    StreamController<int> streamController;
    Timer timer;
    Duration timerInterval = Duration(seconds: 1);
    int counter = 0;
    //var timer = PausableTimer(Duration(seconds: 1), () => print('Fired!'));

    void stopTimer() {
      if (timer != null) {
        timer.cancel();
        // timer = null;
        // counter = 0;
        //streamController.close();
      }
    }

    // void pauseTimer() {
    //   if (timer != null) {
    //     timer.pause();
    //   }
    // }

    void tick(_) {
      counter++;
      streamController.add(counter);
      if (!flag) {
        stopTimer();
      }
    }

    void startTimer() {
      timer = Timer.periodic(timerInterval, tick);
      //timer.start();
    }

    streamController = StreamController<int>(
      onListen: startTimer,
      onCancel: stopTimer,
      onResume: startTimer,
      onPause: stopTimer,
    );

    return streamController.stream;
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    Widget timerButtons(BuildContext context) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          !_finished
              ? RaisedButton(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                  onPressed: () {
                    if (!_started) {
                      timerStream = stopWatchStream();
                      timerSubscription = timerStream.listen((int newTick) {
                        setState(() {
                          hoursStr = ((newTick / (60 * 60)) % 60)
                              .floor()
                              .toString()
                              .padLeft(2, '0');
                          minutesStr = ((newTick / 60) % 60)
                              .floor()
                              .toString()
                              .padLeft(2, '0');
                          secondsStr =
                              (newTick % 60).floor().toString().padLeft(2, '0');
                        });
                      });
                    } else {
                      timerSubscription.cancel();
                      setState(() {
                        _finished = true;
                      });
                    }

                    setState(() {
                      _started = true;
                    });
                  },
                  color: Theme.of(context).buttonColor,
                  child: !_started
                      ? Text(
                          'START',
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        )
                      : Text(
                          'FINISH',
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                )
              : Center(
                  child: Text(''),
                ),
          SizedBox(width: 10.0),
          !_finished
              ? RaisedButton(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                  onPressed: () {
                    if (!_paused) {
                      timerSubscription.pause();
                    } else {
                      //timerStream = stopWatchStream();
                      timerSubscription.resume();
                    }

                    //timerStream = null;
                    setState(() {
                      print('status1');
                      print(_paused);
                      _paused = !_paused;
                      print('status');
                      print(_paused);
                    });
                  },
                  color: Colors.red,
                  child: !_paused
                      ? Text(
                          'PAUSE',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                          ),
                        )
                      : Text(
                          'RESUME',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                          ),
                        ),
                )
              : Center(
                  child: Text(''),
                ),
        ],
      );
    }

    Widget headingText(
        BuildContext context, String title, String worker, String location) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Text(
          title + ' | ' + worker + ' | ' + location,
          style: TextStyle(
              color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            headingText(context, 'Mechanic', 'Nuwan', 'Matara'),
            Center(
              child: Text(
                'Ongoing',
                style: TextStyle(
                    color: Theme.of(context).buttonColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.calendar_month_outlined,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  '21 June 2022',
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.calendar_month_rounded,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  '21 September 2022',
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: Text(
                'Description',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 5),
                child: Text(
                  'Sample description',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Method - ' + 'Hourly rate',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.keyboard_return_rounded,
                  size: 20,
                  color: Theme.of(context).buttonColor,
                ),
                GestureDetector(
                  onTap: () {
                    print("Clicked");
                    Navigator.of(context)
                        .pushNamed(quotationviewScreen.routeName);
                  },
                  child: Text(
                    'View quotation',
                    style: TextStyle(
                      color: Theme.of(context).buttonColor,
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            // Column(
            //   children: [
            //     Text(
            //       '10',
            //       style: TextStyle(
            //           color: Theme.of(context).buttonColor,
            //           fontSize: 50,
            //           fontWeight: FontWeight.bold),
            //     ),
            //     Text(
            //       'Hours',
            //       style: TextStyle(
            //           color: Theme.of(context).buttonColor, fontSize: 15),
            //     ),
            //   ],
            // ),
            SizedBox(
              height: 30,
            ),
            Text(
              "$hoursStr:$minutesStr:$secondsStr",
              style: TextStyle(
                fontSize: 70.0,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            timerButtons(context),
            SizedBox(
              height: 30,
            ),
            Text(
              'Estimated Total',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            Text(
              'LKR 10, 000',
              style:
                  TextStyle(color: Theme.of(context).buttonColor, fontSize: 15),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Payment',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
                Icon(
                  Icons.check_box,
                  color: Colors.white,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.keyboard_return_rounded,
                  size: 20,
                  color: Theme.of(context).buttonColor,
                ),
                Text(
                  'View payment details',
                  style: TextStyle(
                      color: Theme.of(context).buttonColor, fontSize: 15),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              'Add a rating',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            RatingBar.builder(
                minRating: 1,
                maxRating: 5,
                allowHalfRating: true,
                unratedColor: Colors.grey[400],
                itemBuilder: ((context, index) => Icon(
                      Icons.star,
                      color: Theme.of(context).buttonColor,
                    )),
                updateOnDrag: true,
                onRatingUpdate: (rating) {
                  setState(() {
                    this.rating = rating;
                  });
                }),
            Center(
                child: Text(
              '$rating',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            )),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Container(
                height: 46,
                width: width * 0.8,
                decoration: BoxDecoration(
                  // color: Theme.of(context).buttonColor,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: ProgressButton(
                    color: Theme.of(context).buttonColor,
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    child: Text('Mark as completed',
                        style: TextStyle(
                            color: Theme.of(context).backgroundColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w500)),
                    onPressed: (AnimationController controller) async {
                      // print(date.day);

                      await null;
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
