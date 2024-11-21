import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:havana/component/builttextformperinfo.dart';
import 'package:havana/component/custombuttonauth.dart';
import 'package:havana/view/screens/view_all_attendees.dart';
import 'package:havana/view/widgets/appbar_home.dart';
import 'package:havana/view/screens/camer_capture.dart';
import 'package:havana/view/screens/personalinfo.dart';
import 'package:havana/view/screens/sighnature.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PageHome extends StatefulWidget {
  PageHome({super.key});

  @override
  State<PageHome> createState() => _PageHomeState();
}

//CollectionReference users = FirebaseFirestore.instance.collection('users');
//var user = FirebaseAuth.instance.currentUser;

//Future<void> addUser() {
// Call the user's CollectionReference to add a new user
//return users
//  .add({
//  "fname": fname.text,
//"lname": lname.text,
//"email": email.text,
//"phone": phone.text,
//"calendar": Timestamp.now(),
//})
//.then((value) => print("User Added"))
//.catchError((error) => print("Failed to add user: $error"));
//}

//TextEditingController fname = TextEditingController();
//TextEditingController lname = TextEditingController();
//TextEditingController email = TextEditingController();
//TextEditingController phone = TextEditingController();

//GlobalKey<FormState> formState = GlobalKey<FormState>();
//Personalinfo()
class _PageHomeState extends State<PageHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: ElevatedButton(
        onPressed: () {
          Get.to(() => const Personalinfo());
        },
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(
              horizontal: 20, vertical: 15), // تغيير الأبعاد
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.black),
            borderRadius: BorderRadius.circular(10), // يمكنك تعديل الزوايا هنا
          ),
        ),
        child: const Text(
          'Add Customer',
          style: TextStyle(fontSize: 18), // تعديل حجم النص
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: const AppbarHome(),
      body: !FirebaseAuth.instance.currentUser!.emailVerified
          //personal informatin
          ? ViewAllAttendees()
          //Center(
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     crossAxisAlignment: CrossAxisAlignment.center,
          //     children: [
          //       CustomButtonAuth(
          //         title: "View all attendees",
          //         onPressed: () {
          //           Get.to(() => ViewAllAttendees());
          //         },
          //       ),
          //       CustomButtonAuth(
          //         title: "Customer Registration",
          //         onPressed: () {
          //           Get.to(() => Personalinfo());
          //         },
          //       ),
          //     ],
          //   ),
          // )
          : MaterialButton(
              child: const Text('Send Email Verification'),
              textColor: Colors.white,
              color: Colors.black,
              onPressed: () {
                FirebaseAuth.instance.currentUser!.sendEmailVerification();
              }),
    );
  }
}

//Container(
//  key: formState,
// child: Form(
//   child: Column(children: [
//firstname
//Padding(
//padding: const EdgeInsets.symmetric(
//  vertical: 20, horizontal: 25),
//child: AddTextForm(
//  hinttext: "first name",
//mycontroller: fname,
//validator: (val) {
//if (val == "") {
//return "can't be empty";
//}
//}),
//),

//last name
//Padding(
//padding: EdgeInsets.symmetric(
//  vertical: 20, horizontal: 25),
//child: AddTextForm(
//  hinttext: "last name",
//mycontroller: lname,
//validator: (val) {
//if (val == "") {
//return "can't be empty";
//}
//}),
//),
//Email
//Padding(
//padding: EdgeInsets.symmetric(
//  vertical: 20, horizontal: 25),
//child: AddTextForm(
//  hinttext: "Email",
//mycontroller: email,
//validator: (val) {
//if (val == "") {
//return "can't be empty";
//}
//}),
//),
//phone
//Padding(
//padding: EdgeInsets.symmetric(
//  vertical: 20, horizontal: 25),
//child: AddTextForm(
//  hinttext: "mobile phone",
//mycontroller: phone,
//validator: (val) {
//if (val == "") {
//return "can't be empty";
//}
//}),
//),
//])),
//)
