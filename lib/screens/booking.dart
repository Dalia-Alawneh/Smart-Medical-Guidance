import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:booking_calendar/booking_calendar.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import '../Util/var.dart';

class BookingCalendarDemoApp extends StatefulWidget {
  const BookingCalendarDemoApp({Key? key, this.cid}) : super(key: key);
  final cid;
  @override
  State<BookingCalendarDemoApp> createState() => _BookingCalendarDemoAppState();
}

class _BookingCalendarDemoAppState extends State<BookingCalendarDemoApp> {
  final now = DateTime.now();
  List booked = [];
  List name = [];
  String clinicName = '';
  var user = FirebaseAuth.instance.currentUser;
  late BookingService mockBookingService;
  List<DateTimeRange> converted = [];
  Future getBooked() async {
    await FirebaseFirestore.instance
        .collection('Booked')
        .where("clinicId", isEqualTo: widget.cid)
        .get()
        .then((value) {
      // await Future.delayed(const Duration(seconds: 1));
      // setState(() {
      booked = value.docs;
      for (int i = 0; i < booked.length; i++) {
        // booked.add(value.docs[i].data());
        // setState(() {
        //   converted.add(DateTimeRange(
        //       start: value.docs[i]['start'], end: value.docs[i]['end']));
        // });
        BookingService bookingService = BookingService(
          bookingStart: value.docs[i]['start'],
          bookingEnd: value.docs[i]['end'],
          serviceName: 'Mock Service',
          serviceDuration: 30,
        );
        uploadBookingMock(newBooking: bookingService, b: false);
        print(value.docs[i]['start']);
        // uploadBookingMock(
        //   newBooking: booked[i]['start'].bookingStart,);
      }
      // });
    });
  }

  @override
  void initState() {
    // getBooked();
    // print(booked);
    name = CLINICSNAMES[widget.cid].split(' ');
    name.sublist(0, 3);
    clinicName = name.join(" ");
    setState(() {});
    super.initState();
    print(widget.cid);
    print(converted);

    // DateTime.now().startOfDay
    // DateTime.now().endOfDay
    mockBookingService = BookingService(
        serviceName: 'Mock Service',
        serviceDuration: 30,
        bookingEnd: DateTime(now.year, now.month, now.day, 18, 0),
        bookingStart: DateTime(now.year, now.month, now.day, 8, 0));
  }

  List<DateTimeRange> convertStreamResultFirebase(
      {required dynamic streamResult}) {
    ///here you can parse the streamresult and convert to [List<DateTimeRange>]
    ///Note that this is dynamic, so you need to know what properties are available on your result, in our case the [SportBooking] has bookingStart and bookingEnd property
    List<DateTimeRange> converted = [];
    for (var i = 0; i < streamResult.size; i++) {
      final item = streamResult.docs[i].data();
      converted.add(
          DateTimeRange(start: (item.bookingStart!), end: (item.bookingEnd!)));
    }
    return converted;
  }

//  Stream<dynamic>? getBookingStreamFirebase(
//     {required DateTime end, required DateTime start}) {
//        return getBooked()
//                         .getBookingStream(placeId: widget.cid)
//                         .where('bookingStart', isGreaterThanOrEqualTo: start)
//                         .where('bookingStart', isLessThanOrEqualTo: end)
//                         .snapshots(),
//   }

  Stream<dynamic>? getBookingStreamMock(
      {required DateTime end, required DateTime start}) {
    return Stream.value([]);
  }

  Future<dynamic> uploadBookingMock(
      {required BookingService newBooking, bool b = true}) async {
    await Future.delayed(const Duration(seconds: 1));
    converted.add(DateTimeRange(
        start: newBooking.bookingStart, end: newBooking.bookingEnd));
    print("hello" + FirebaseAuth.instance.currentUser!.uid);
    print("hello" + FirebaseAuth.instance.currentUser!.uid);
    if (b) {
      await FirebaseFirestore.instance.collection('Booked').add({
        "start": newBooking.toJson()['bookingStart'],
        "end": newBooking.toJson()['bookingEnd'],
        "patientID": FirebaseAuth.instance.currentUser!.uid,
        "clinicId": widget.cid
      });
    }
    print('${newBooking.toJson()['bookingStart']} has been uploaded');
    print('${newBooking.toJson()['bookingEnd']} has been uploaded');
    print('hhhhhhhhhhhh');
  }

  List<DateTimeRange> convertStreamResultMock({required dynamic streamResult}) {
    ///here you can parse the streamresult and convert to [List<DateTimeRange>]
    ///take care this is only mock, so if you add today as disabledDays it will still be visible on the first load
    ///disabledDays will properly work with real data
    DateTime first = now;
    // DateTime tomorrow = now.add(Duration(days: 1));
    // DateTime second = now.add(const Duration(minutes: 75));
    // DateTime third = now.subtract(const Duration(minutes: 240));
    // DateTime fourth = now.subtract(const Duration(minutes: 500));
    converted.add(
        DateTimeRange(start: first, end: now.add(const Duration(minutes: 0))));
    // converted.add(DateTimeRange(
    //     start: second, end: second.add(const Duration(minutes: 23))));
    // converted.add(DateTimeRange(
    //     start: third, end: third.add(const Duration(minutes: 15))));
    // converted.add(DateTimeRange(
    //     start: fourth, end: fourth.add(const Duration(minutes: 50))));
    // converted.add(DateTimeRange(
    //     start: DateTime(tomorrow.year, tomorrow.month, tomorrow.day, 5, 0),
    //     end: DateTime(tomorrow.year, tomorrow.month, tomorrow.day, 23, 0)));
    return converted;
  }

  List<DateTimeRange> generatePauseSlots() {
    return [
      DateTimeRange(
          start: DateTime(now.year, now.month, now.day, 12, 0),
          end: DateTime(now.year, now.month, now.day, 13, 0))
    ];
  }

  CollectionReference bookings =
      FirebaseFirestore.instance.collection('bookings');

  ///This is how can you get the reference to your data from the collection, and serialize the data with the help of the Firestore [withConverter]. This function would be in your repository.
  CollectionReference getBookingStream({required String placeId}) {
    return bookings.doc(placeId).collection('bookings').withConverter(
          fromFirestore: (snapshots, _) => SportBooking.fromJson(snapshots.data()!),
          toFirestore: (snapshots, _) => snapshots.toJson(),
        );
  }
  Stream<dynamic>? getBookingStreamFirebase(
      {required DateTime end, required DateTime start}) {
    return getBookingStream(placeId: 'YOUR_DOC_ID')
        .where('bookingStart', isGreaterThanOrEqualTo: start)
        .where('bookingStart', isLessThanOrEqualTo: end)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    // //getBooked();
    // print(booked[1].data());
    // print(booked[0].data());

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xff2894B1),
            title: Text(
              'مواعيد اليوم لـ ${name[0]} ${name[1]} ${name[2]}',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontFamily: 'Lalezar',
              ),
            ),
            centerTitle: true,
          ),
          body: Directionality(
            textDirection: TextDirection.rtl,
            child: Center(
              child: BookingCalendar(
                bookingService: mockBookingService,
                convertStreamResultToDateTimeRanges: convertStreamResultMock,
                // convertStreamResultToDateTimeRanges:
                //     convertStreamResultFirebase,
                getBookingStream: getBookingStreamMock,
                uploadBooking: uploadBookingMock,
                pauseSlots: generatePauseSlots(),
                pauseSlotText: 'بريك',
                hideBreakTime: false,
                loadingWidget: const Text('جارِ التحميل...'),
                uploadingWidget: const CircularProgressIndicator(),
                locale: 'ar_ps',
                startingDayOfWeek: StartingDayOfWeek.saturday,
                bookingButtonText: 'حجز',
                bookingButtonColor: Color(0xff2894B1),
                selectedSlotText: 'محدد',
                selectedSlotColor: Color(0xff89A008),
                bookedSlotText: 'محجوز',
                bookedSlotColor: Color(0xffB8000F),
                availableSlotText: 'الحجوزات المتاحة',
                availableSlotColor: Color(0xff62CA65),
                // wholeDayIsBookedWidget:
                // const Text('Sorry, for this day everything is booked'),
                //disabledDates: [DateTime(2023, 1, 20)],
                //disabledDays: [6, 7],
              ),
            ),
          ),
        ));
  }
}
